import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lottie/lottie.dart'; 

import 'package:musicboxd/providers/review_provider.dart';
import 'package:musicboxd/models/review.dart';
import 'package:musicboxd/screens/home/home_screen.dart'; 
import 'package:musicboxd/widgets/animated_favorite_button.dart'; 

class ReviewScreen extends StatefulWidget {
  final dynamic song;

  const ReviewScreen({
    super.key,
    required this.song,
  });

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  double rating = 0;
  bool isFavorite = false;

  final TextEditingController commentController = TextEditingController();

  @override
  void dispose() {
    commentController.dispose();
    super.dispose();
  }

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false, 
      builder: (BuildContext context) {
        Future.delayed(const Duration(milliseconds: 2500), () {
          if (context.mounted) {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const HomeScreen()),
              (Route<dynamic> route) => false, 
            );
          }
        });

        return Dialog(
          backgroundColor: const Color(0xFF1E0B2E), 
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Lottie.asset(
                  'assets/lottie/success.json',
                  width: 130,
                  height: 130,
                ),
                const SizedBox(height: 16),
                const Text(
                  "Reseña guardada con éxito",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Extracción de datos (Mantenemos tu lógica intacta)
    final songName = widget.song['name']?.toString() ?? 'Sin nombre';
    final artist = widget.song['artists'] != null &&
            widget.song['artists'] is List &&
            widget.song['artists'].isNotEmpty
        ? widget.song['artists'][0]['name'].toString()
        : 'Artista desconocido';
        
    final imageUrl = widget.song['album'] != null &&
            widget.song['album']['images'] != null &&
            (widget.song['album']['images'] as List).isNotEmpty
        ? widget.song['album']['images'][0]['url'].toString()
        : '';

    return Scaffold(
      backgroundColor: const Color(0xFF120320), // Fondo ultra oscuro general
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
   
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Container(
            constraints: const BoxConstraints(maxWidth: 500), // Evita que se estire en pantallas web grandes
            decoration: BoxDecoration(
              color: const Color(0xFF6353A8), // El morado de tu diseño Figma
              borderRadius: BorderRadius.circular(32), // Bordes ultra redondeados de la tarjeta
              boxShadow: const [
                BoxShadow(
                  color: Color(0xFF382361), // Sombra sólida 3D retro sin difuminado
                  offset: Offset(6, 7),
                  blurRadius: 0,
                )
              ],
            ),
            padding: const EdgeInsets.all(24.0), // Espaciado interno del bloque
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
           
                const Center(
                  child: Text(
                    "¡Crea tu reseña!",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),
                const SizedBox(height: 24),


                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: imageUrl.isNotEmpty
                          ? Image.network(
                              imageUrl,
                              width: 130,
                              height: 130,
                              fit: BoxFit.cover,
                            )
                          : Container(
                              width: 130,
                              height: 130,
                              color: const Color(0xFF1E0B2E),
                              child: const Icon(
                                Icons.music_note,
                                color: Colors.white54,
                                size: 40,
                              ),
                            ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 8),
                          Text(
                            songName,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Poppins',
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            artist,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Color(0xFFE9E9E9),
                              fontSize: 18,
                              fontFamily: 'Poppins',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 28),


                const Text(
                  "Calificación",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: List.generate(5, (index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 2.0),
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        icon: Icon(
                          index < rating ? Icons.star : Icons.star_border,
                          color: Colors.amber,
                          size: 40, // Estrellas grandes y llamativas
                        ),
                        onPressed: () {
                          setState(() {
                            rating = (index + 1).toDouble();
                          });
                        },
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 24),


                const Text(
                  "Comentarios",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF231254), // Morado oscuro profundo para el fondo del TextField
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: TextField(
                    controller: commentController,
                    maxLines: 5,
                    style: const TextStyle(color: Colors.white, fontFamily: 'Poppins'),
                    decoration: const InputDecoration(
                      hintText: "Escribe tu opinión...",
                      hintStyle: TextStyle(color: Colors.white38),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(16),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                Row(
                  children: [
                    AnimatedFavoriteButton(
                      isLiked: isFavorite,
                      onTap: () {
                        setState(() {
                          isFavorite = !isFavorite;
                        });
                      },
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      "Guardar en favoritos",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),


                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF6F42EC), // Morado eléctrico del mockup original
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      elevation: 0,
                    ),
                    onPressed: () {
                      if (rating == 0) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Por favor, selecciona una calificación antes de guardar."),
                            backgroundColor: Colors.redAccent,
                          ),
                        );
                        return;
                      }

                      final review = Review(
                        id: DateTime.now().toString(),
                        songName: songName,
                        artist: artist,
                        imageUrl: imageUrl,
                        rating: rating,
                        comment: commentController.text,
                        isFavorite: isFavorite,
                        createdAt: DateTime.now(),
                      );

                      Provider.of<ReviewProvider>(context, listen: false).addReview(review);
                      _showSuccessDialog(context);
                    },
                    child: const Text(
                      "Guardar reseña",
                      style: TextStyle(
                        fontSize: 16, 
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}