import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:musicboxd/providers/review_provider.dart';
import '../models/review.dart';

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
   
    rating = widget.review.rating.toDouble(); 
    commentController = TextEditingController(text: widget.review.comment);
    isFavorite = widget.review.isFavorite;
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
        height: MediaQuery.of(context).size.height * 0.75, 
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
              children: List.generate(5, (index) {
                return IconButton(
                  icon: Icon(
                    index < rating ? Icons.star : Icons.star_border,
                    color: Colors.amber,
                    size: 30,
                  ),
                  onPressed: () {
                    setState(() {
                      rating = (index + 1).toDouble();
                    });
                  },
                );
              }),
            ),
            const SizedBox(height: 10),

            TextField(
              controller: commentController,
              maxLines: 4,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                hintText: "Edita tu comentario...",

              ),
            ),
            const SizedBox(height: 10),


            Row(
              children: [
                Checkbox(
                  value: isFavorite,
                  onChanged: (v) => setState(() => isFavorite = v!),
                ),
                const Text(
                  "Favorito",
                  style: TextStyle(color: Colors.white70),
                ),
              ],
            ),
            const Spacer(),


            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  final updated = Review(
                    id: widget.review.id,
                    songName: widget.review.songName,
                    artist: widget.review.artist,
                    imageUrl: widget.review.imageUrl,
                    // Si el modelo espera explícitamente un int, usa: rating.toInt()
                    rating: rating, 
                    comment: commentController.text,
                    isFavorite: isFavorite,
                    createdAt: widget.review.createdAt,
                  );

                  Provider.of<ReviewProvider>(context, listen: false)
                      .updateReview(widget.review.id, updated);

                  Navigator.pop(context);
                },
                child: const Text("Guardar cambios"),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}