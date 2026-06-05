import 'package:flutter/material.dart';
import 'package:musicboxd/theme/app_theme.dart';
import 'package:provider/provider.dart';
import 'package:lottie/lottie.dart'; 
import 'package:musicboxd/providers/review_provider.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final reviewProvider = Provider.of<ReviewProvider>(context);
    final favorites = reviewProvider.favorites;

    return Scaffold(
      backgroundColor: AppTheme.backgroundColor, 
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Favoritos",
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
            fontFamily: 'Poppins',
          ),
        ),
      ),
    
          ? Center(
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Lottie.asset(
                      'assets/lottie/favorites.json',
                      width: 250,
                      height: 250,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "No tienes favoritos aún",
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ],
                ),
              ),
            )
          : Center(
              child: Container(
                constraints: const BoxConstraints(maxWidth: 500), // Evita el estiramiento horizontal raro en PC
                child: ListView.builder(
                  itemCount: favorites.length,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  itemBuilder: (context, index) {
                    final r = favorites[index];

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 24.0), // Separación uniforme pop-art
                      child: Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: const Color(0xFF6353A8), // El morado vivo de tus tarjetas
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0xFF382361), // Bloque de sombra sólida 3D retro
                              offset: Offset(5, 6),
                              blurRadius: 0,
                            )
                          ],
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                         
                            ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Image.network(
                                r.imageUrl,
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) => Container(
                                  width: 100,
                                  height: 100,
                                  color: const Color(0xFF1E0B2E),
                                  child: const Icon(Icons.music_note, color: Colors.white54),
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),

                          
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    r.songName,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Poppins',
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    r.artist,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      color: Color(0xFFE9E9E9),
                                      fontSize: 15,
                                      fontFamily: 'Poppins',
                                    ),
                                  ),
                                  const SizedBox(height: 6),

                                 
                                  Row(
                                    children: List.generate(5, (i) {
                                      return Icon(
                                        i < r.rating ? Icons.star : Icons.star_border,
                                        color: Colors.amber,
                                        size: 18,
                                      );
                                    }),
                                  ),
                                  const SizedBox(height: 8),

                             
                                  Text(
                                    r.comment,
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      color: Color(0xFFDCDCDC),
                                      fontSize: 13,
                                      fontFamily: 'Poppins',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 8),

                            
                            IconButton(
                              icon: const Icon(
                                Icons.favorite,
                                color: Colors.red,
                                size: 28,
                              ),
                              onPressed: () {
                                reviewProvider.toggleFavorite(r.id);

                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text("${r.songName} eliminada de favoritos"),
                                    duration: const Duration(seconds: 2),
                                    backgroundColor: AppTheme.lightPurple,
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
    );
  }
}