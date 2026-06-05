import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lottie/lottie.dart'; 
import 'package:musicboxd/theme/app_theme.dart';
import 'package:musicboxd/providers/review_provider.dart';
import 'package:musicboxd/providers/cajitas_provider.dart'; 
import 'package:musicboxd/screens/review/edit_review.dart';
import 'package:musicboxd/widgets/animated_favorite_button.dart';

class ReviewsScreen extends StatelessWidget {
  const ReviewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final reviewProvider = Provider.of<ReviewProvider>(context);
    final reviews = reviewProvider.reviews;
    final cajitasProvider = Provider.of<CajitasProvider>(context);

    return Scaffold(
      backgroundColor: AppTheme.backgroundColor, // Fondo ultra oscuro
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Mis reseñas",
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
            fontFamily: 'Poppins',
          ),
        ),
        actions: [
          PopupMenuButton<ReviewFilter>(
            icon: const Icon(Icons.sort, color: Colors.white, size: 28),
            tooltip: "Ordenar por",
            color: const Color(0xFF1E0B2E), 
            itemBuilder: (context) => <PopupMenuEntry<ReviewFilter>>[
              const PopupMenuItem<ReviewFilter>(
                value: ReviewFilter.best,
                child: Row(
                  children: [
                    Icon(Icons.star, color: Colors.amber, size: 18),
                    SizedBox(width: 8),
                    Text("Mayor calificación", style: TextStyle(color: Colors.white)),
                  ],
                ),
              ),
              const PopupMenuItem<ReviewFilter>(
                value: ReviewFilter.worst,
                child: Row(
                  children: [
                    Icon(Icons.star_border, color: Colors.amber, size: 18),
                    SizedBox(width: 8),
                    Text("Menor calificación", style: TextStyle(color: Colors.white)),
                  ],
                ),
              ),
              const PopupMenuItem<ReviewFilter>(
                value: ReviewFilter.newest,
                child: Row(
                  children: [
                    Icon(Icons.calendar_today, color: Colors.white70, size: 18),
                    SizedBox(width: 8),
                    Text("Más recientes", style: TextStyle(color: Colors.white)),
                  ],
                ),
              ),
              const PopupMenuItem<ReviewFilter>(
                value: ReviewFilter.oldest,
                child: Row(
                  children: [
                    Icon(Icons.history, color: Colors.white70, size: 18),
                    SizedBox(width: 8),
                    Text("Más antiguas", style: TextStyle(color: Colors.white)),
                  ],
                ),
              ),
            ],
            onSelected: (ReviewFilter selectedFilter) {
              reviewProvider.setFilter(selectedFilter);
            },
          ),
        ],
      ),
      body: reviews.isEmpty
          ? Center(
              child: Container(
                constraints: const BoxConstraints(maxWidth: 500),
                child: _buildEmptyState(),
              ),
            )
          : Center(
              child: Container(
                constraints: const BoxConstraints(maxWidth: 500), // Mismo límite visual para mantener la proporción
                child: ListView.builder(
                  itemCount: reviews.length,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  itemBuilder: (context, index) {
                    final r = reviews[index];

                    return Dismissible(
                      key: Key(r.id.toString()),
                      direction: DismissDirection.endToStart,
                      background: Container(
                        margin: const EdgeInsets.only(bottom: 24), 
                        padding: const EdgeInsets.only(right: 24),
                        decoration: BoxDecoration(
                          color: const Color(0xFFD32F2F), 
                          borderRadius: BorderRadius.circular(24),
                        ),
                        alignment: Alignment.centerRight,
                        child: const Icon(Icons.delete_sweep_rounded, color: Colors.white, size: 32),
                      ),
                      onDismissed: (direction) {
                        reviewProvider.deleteReview(r.id);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Reseña de '${r.songName}' eliminada"),
                            backgroundColor: const Color(0xFF1E0B2E),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 24.0), 
                        child: Container(
                          padding: const EdgeInsets.all(14), // Unificado el padding interno
                          decoration: BoxDecoration(
                            color: const Color(0xFF6353A8), // Color morado pop-art fijo
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
                                      maxLines: 3, // Incrementado a 3 líneas máx para mayor balance visual
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


                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  AnimatedFavoriteButton(
                                    isLiked: r.isFavorite,
                                    onTap: () => reviewProvider.toggleFavorite(r.id),
                                  ),
                                  _buildPopMenu(context, reviewProvider, cajitasProvider, r),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
    );
  }

  Widget _buildPopMenu(BuildContext context, dynamic reviewProvider, dynamic cajitasProvider, dynamic r) {
    return PopupMenuButton<String>(
      icon: const Icon(Icons.more_vert, color: Colors.white70, size: 24),
      padding: EdgeInsets.zero,
      color: const Color(0xFF1E0B2E),
      constraints: const BoxConstraints(maxWidth: 170),
      onSelected: (value) {
      
        if (value == 'edit') {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: const Color(0xFF120320),
            builder: (_) => EditReviewModal(review: r),
          );
        }

        if (value == 'add_to_box') {
          _showSelectCajitaModal(context, cajitasProvider, r.id);
        }
      },
      itemBuilder: (context) => const [
        PopupMenuItem(
          value: 'edit',
          child: Text('Editar', style: TextStyle(color: Colors.white)),
        ),
        PopupMenuItem(
          value: 'add_to_box', 
          child: Text('Agregar a Cajita', style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }


  void _showSelectCajitaModal(BuildContext context, CajitasProvider provider, String reviewId) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1E0B2E),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        final listas = provider.cajitas;

        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Guardar reseña en...",
                style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'Poppins'),
              ),
              const SizedBox(height: 15),
              listas.isEmpty
                  ? const Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: Text("No tienes Cajitas creadas. Ve al menú Cajitas para crear una.", style: TextStyle(color: Colors.white54)),
                    )
                  : Flexible(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: listas.length,
                        itemBuilder: (context, i) {
                          final lista = listas[i];
                          return ListTile(
                            leading: const Icon(Icons.inventory_2_outlined, color: Color(0xFF6F42EC)),
                            title: Text(lista.titulo, style: const TextStyle(color: Colors.white)),
                            trailing: lista.reviewIds.contains(reviewId) 
                                ? const Icon(Icons.check_circle, color: Colors.green) 
                                : const Icon(Icons.add, color: Colors.white54),
                            onTap: () {
                              provider.agregarReviewACajita(lista.id, reviewId);
                              Navigator.pop(context); 
                              
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("Agregada con éxito a '${lista.titulo}'"),
                                  backgroundColor: const Color(0xFF6F42EC),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
            ],
          ),
        );
      },
    );
  }


  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              'assets/lottie/review.json',
              width: 250,
              height: 250,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 20),
            const Text(
              "Aún no tienes reseñas",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "Busca tus álbumes o canciones favoritas y comparte lo que piensas de ellos.",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white.withOpacity(0.6),
                fontSize: 14,
                fontFamily: 'Poppins',
              ),
            ),
          ],
        ),
      ),
    );
  }
}