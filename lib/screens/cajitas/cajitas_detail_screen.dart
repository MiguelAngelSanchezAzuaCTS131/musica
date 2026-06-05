import 'package:flutter/material.dart';
import 'package:musicboxd/theme/app_theme.dart';
import 'package:provider/provider.dart';
import 'package:musicboxd/providers/cajitas_provider.dart';
import 'package:musicboxd/providers/review_provider.dart';

class CajitaDetailScreen extends StatelessWidget {
  final String cajitaId;

  const CajitaDetailScreen({super.key, required this.cajitaId});

  @override
  Widget build(BuildContext context) {
    final cajitasProvider = Provider.of<CajitasProvider>(context);
    final reviewProvider = Provider.of<ReviewProvider>(context);

    // Encontramos la cajita actual usando su ID
    final cajita = cajitasProvider.cajitas.firstWhere((c) => c.id == cajitaId);
    
    // Filtramos las reseñas que pertenecen a esta cajita
    final lasReviewsDeEstaCajita = reviewProvider.reviews
        .where((r) => cajita.reviewIds.contains(r.id))
        .toList();

    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          cajita.titulo, 
          style: const TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.bold)
        ),
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.add_circle_outline, size: 28, color: Colors.white),
            onPressed: () => _showAddReviewsModal(context, cajitasProvider, reviewProvider, cajita),
          )
        ],
      ),
      body: lasReviewsDeEstaCajita.isEmpty
          ? Center(
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Text(
                  "Esta cajita está vacía.\n¡Toca el botón + para añadir reseñas!",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 16, fontFamily: 'Poppins'),
                ),
              ),
            )
          : ListView.builder(
              itemCount: lasReviewsDeEstaCajita.length,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              itemBuilder: (context, index) {
                final r = lasReviewsDeEstaCajita[index];
                
                
                final bool esFavorita = (r as dynamic).isFavorite ?? false;

                return Container(
                  margin: const EdgeInsets.only(bottom: 18),
                  decoration: BoxDecoration(
                    color: const Color(0xFF6353A8), // Morado claro exacto de tus tarjetas
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0xFF382361), // Sombra sólida 3D
                        offset: Offset(5, 6),
                        blurRadius: 0,
                      )
                    ],
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 1. Imagen del Álbum
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          r.imageUrl, 
                          width: 70, 
                          height: 70, 
                          fit: BoxFit.cover
                        ),
                      ),
                      const SizedBox(width: 16),
                      
                      // 2. Columna central: Info, estrellas y comentario integrado
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              r.songName, 
                              style: const TextStyle(
                                color: Colors.white, 
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Poppins',
                                fontSize: 18,
                              ),
                            ),
                            Text(
                              r.artist, 
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 14,
                                fontFamily: 'Poppins',
                              ),
                            ),
                            const SizedBox(height: 4),
                            
                            // Estrellas de calificación
                            Row(
                              children: List.generate(5, (starIndex) {
                                final checkRating = (r as dynamic).rating ?? 5; 
                                return Icon(
                                  starIndex < checkRating ? Icons.star : Icons.star_border,
                                  color: const Color(0xFFFFD700),
                                  size: 16,
                                );
                              }),
                            ),
                            
                            // Comentario de la reseña
                            if (r.comment.isNotEmpty) ...[
                              const SizedBox(height: 8),
                              Text(
                                r.comment,
                                style: const TextStyle(
                                  color: Colors.white, 
                                  fontSize: 13, 
                                  fontFamily: 'Poppins',
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                      
                      // 3. Bloque derecho: Iconos alineados perfectamente
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // ✨ CORREGIDO: Corazón dinámico según el estado real de la reseña
                          Icon(
                            esFavorita ? Icons.favorite : Icons.favorite_border, 
                            color: esFavorita ? const Color(0xFFFF4A4A) : Colors.white70, 
                            size: 22
                          ),
                          const SizedBox(width: 8),
                          IconButton(
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                            icon: const Icon(Icons.delete_outline, color: Colors.white70, size: 22),
                            onPressed: () {
                              cajitasProvider.eliminarReviewDeCajita(cajita.id, r.id);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("'${r.songName}' eliminada de la cajita"),
                                  backgroundColor: const Color(0xFFFF4A4A),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }

  // El modal se mantiene intacto
  void _showAddReviewsModal(BuildContext context, CajitasProvider cProvider, ReviewProvider rProvider, dynamic cajita) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        final todasLasReviews = rProvider.reviews;

        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom + 20,
            top: 24,
            left: 16,
            right: 16,
          ),
          child: Center(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 500),
              decoration: BoxDecoration(
                color: const Color(0xFF6353A8),
                borderRadius: BorderRadius.circular(32),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0xFF382361),
                    offset: Offset(6, 7),
                    blurRadius: 0,
                  )
                ],
              ),
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(
                    child: Text(
                      "Añadir reseñas a la lista",
                      style: TextStyle(
                        color: Colors.white, 
                        fontSize: 20, 
                        fontWeight: FontWeight.bold, 
                        fontFamily: 'Poppins'
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  todasLasReviews.isEmpty
                      ? const Padding(
                          padding: EdgeInsets.symmetric(vertical: 24),
                          child: Center(
                            child: Text(
                              "No tienes reseñas creadas en la app todavía.", 
                              style: TextStyle(color: Colors.white60, fontFamily: 'Poppins')
                            ),
                          ),
                        )
                      : Flexible(
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: todasLasReviews.length,
                            itemBuilder: (context, index) {
                              final r = todasLasReviews[index];
                              final yaEstaEnCajita = cajita.reviewIds.contains(r.id);

                              return Container(
                                margin: const EdgeInsets.only(bottom: 10),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF231254),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: ListTile(
                                  contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                                  leading: ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.network(r.imageUrl, width: 45, height: 45, fit: BoxFit.cover),
                                  ),
                                  title: Text(
                                    r.songName, 
                                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontFamily: 'Poppins')
                                  ),
                                  subtitle: Text(
                                    r.artist, 
                                    style: const TextStyle(color: Colors.white54, fontFamily: 'Poppins', fontSize: 13)
                                  ),
                                  trailing: yaEstaEnCajita
                                      ? const Icon(Icons.check_circle, color: Color(0xFF00E676), size: 26)
                                      : const Icon(Icons.add_circle, color: Color(0xFF6F42EC), size: 26),
                                  onTap: yaEstaEnCajita 
                                      ? null 
                                      : () {
                                          cProvider.agregarReviewACajita(cajita.id, r.id);
                                          Navigator.pop(context);
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(
                                              content: Text("'${r.songName}' añadida a la cajita"),
                                              backgroundColor: const Color(0xFF6F42EC),
                                            ),
                                          );
                                        },
                                ),
                              );
                            },
                          ),
                        ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}