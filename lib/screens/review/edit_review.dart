import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:musicboxd/models/review.dart';
import 'package:musicboxd/providers/review_provider.dart';

class EditReviewModal extends StatefulWidget {
  final Review review;

  const EditReviewModal({super.key, required this.review});

  @override
  State<EditReviewModal> createState() => _EditReviewModalState();
}

class _EditReviewModalState extends State<EditReviewModal> {
  late double rating;
  late TextEditingController commentController;
  late bool isFavorite;

  @override
  void initState() {
    super.initState();
    rating = widget.review.rating; 
    commentController = TextEditingController(text: widget.review.comment);
    isFavorite = widget.review.isFavorite;
  }

  @override
  void dispose() {
    commentController.dispose(); // Buena práctica para liberar memoria
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 16,
        right: 16,
        top: 20,
      ),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.75, // Ajustado ligeramente para mejor balance
       
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
           
              Center(
                child: Container(
                  width: 60,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              const Text(
                "Editar reseña",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: List.generate(5, (index) {
                  return IconButton(
                    icon: Icon(
                      index < rating ? Icons.star : Icons.star_border,
                      color: Colors.amber,
                      size: 35,
                    ),
                    onPressed: () {
                      setState(() {
                        rating = index + 1.0;
                      });
                    },
                  );
                }),
              ),

              const SizedBox(height: 15),

             
              TextField(
                controller: commentController,
                maxLines: 4,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xFF1E0B2E),
                  hintText: "Edita tu comentario...",
                  hintStyle: const TextStyle(color: Colors.white38),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              const SizedBox(height: 15),

              Row(
                children: [
                  Checkbox(
                    value: isFavorite,
                    activeColor: Colors.purple,
                    checkColor: Colors.white,
                    side: const BorderSide(color: Colors.white54),
                    onChanged: (value) {
                      setState(() {
                        isFavorite = value ?? false;
                      });
                    },
                  ),
                  const Text(
                    "Favorito",
                    style: TextStyle(color: Colors.white70, fontSize: 16),
                  ),
                ],
              ),

              const SizedBox(height: 30),

       
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    final updated = Review(
                      id: widget.review.id,
                      songName: widget.review.songName,
                      artist: widget.review.artist,
                      imageUrl: widget.review.imageUrl,
                      rating: rating, 
                      comment: commentController.text,
                      isFavorite: isFavorite,
                      createdAt: widget.review.createdAt,
                    );

                    Provider.of<ReviewProvider>(context, listen: false)
                        .updateReview(widget.review.id, updated);

                    Navigator.pop(context);
                  },
                  child: const Text(
                    "Guardar cambios",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }
}