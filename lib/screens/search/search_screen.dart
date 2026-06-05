import 'dart:async';
import 'package:flutter/material.dart';
import 'package:musicboxd/services/spotify_service.dart';
import 'package:musicboxd/screens/review/review_screen.dart';
import 'package:musicboxd/theme/app_theme.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final SpotifyService spotifyService = SpotifyService();
  final TextEditingController searchController = TextEditingController();

  List<dynamic> songs = [];
  Timer? debounce;
  bool isLoading = false;

  void searchMusic(String query) async {
    if (query.isEmpty) {
      setState(() {
        songs = [];
        isLoading = false;
      });
      return;
    }

    setState(() => isLoading = true);

    try {
      final results = await spotifyService.searchSongs(query);
      setState(() {
        songs = List<Map<String, dynamic>>.from(results);
        isLoading = false;
      });
    } catch (e) {
      setState(() => isLoading = false);
    }
  }

  @override
  void dispose() {
    searchController.dispose();
    debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor, // Fondo ultra oscuro
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Buscar Música",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          // 🔍 BARRA DE BÚSQUEDA NEOMÓRFICA CON SOMBRA SÓLIDA
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Container(
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                color: const Color(0xFF2E1A6B), // Morado de la barra
                borderRadius: BorderRadius.circular(30),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0xFF1E0B2E), // Sombra dura inferior
                    offset: Offset(4, 5),
                    blurRadius: 0,
                  )
                ],
              ),
              child: TextField(
                controller: searchController,
                onChanged: (value) {
                  if (debounce?.isActive ?? false) debounce!.cancel();

                  debounce = Timer(
                    const Duration(milliseconds: 600),
                    () => searchMusic(value),
                  );
                },
                style: const TextStyle(color: Colors.white, fontSize: 18),
                cursorColor: Colors.white,
                decoration: const InputDecoration(
                  hintText: "Buscar canciones...",
                  hintStyle: TextStyle(color: Colors.white60, fontSize: 18),
                  prefixIcon: Icon(Icons.search, color: Colors.white, size: 28),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                ),
              ),
            ),
          ),

          const SizedBox(height: 15),


          Expanded(
            child: isLoading
                ? const Center(
                    child: CircularProgressIndicator(color: Color(0xFF6353A8)),
                  )
                : songs.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              searchController.text.isEmpty 
                                  ? Icons.music_note 
                                  : Icons.search_off, 
                              size: 64, 
                              color: Colors.white24,
                            ),
                            const SizedBox(height: 12),
                            Text(
                              searchController.text.isEmpty
                                  ? "Escribe algo para buscar tus canciones favoritas"
                                  : "No se encontraron resultados",
                              style: const TextStyle(color: Colors.white38, fontSize: 14),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        itemCount: songs.length,
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                        itemBuilder: (context, index) {
                          final Map<String, dynamic> song = songs[index];
                          
                          // Extracción segura de la portada de Spotify
                          String imageUrl = '';
                          if (song['album'] != null &&
                              song['album']['images'] != null &&
                              song['album']['images'] is List &&
                              song['album']['images'].isNotEmpty) {
                            imageUrl = song['album']['images'][0]['url'].toString();
                          }

                          // Extracción segura del artista
                          String artistName = 'Artista desconocido';
                          if (song['artists'] != null &&
                              song['artists'] is List &&
                              song['artists'].isNotEmpty) {
                            artistName = song['artists'][0]['name'].toString();
                          }

                          return Padding(
                            padding: const EdgeInsets.only(bottom: 20.0),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => ReviewScreen(song: song),
                                  ),
                                );
                              },
                              child: Container(
                                height: 110, // Altura fija de tarjeta estilizada
                                decoration: BoxDecoration(
                                  color: const Color(0xFF6353A8), // Morado claro del contenedor
                                  borderRadius: BorderRadius.circular(24),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Color(0xFF382361), // Bloque de sombra oscura en 3D
                                      offset: Offset(5, 6),
                                      blurRadius: 0,
                                    )
                                  ],
                                ),
                                child: Row(
                                  children: [
                                    // Portada de la canción (Lado Izquierdo)
                                    Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(12),
                                        child: imageUrl.isNotEmpty
                                            ? Image.network(
                                                imageUrl,
                                                width: 85,
                                                height: 85,
                                                fit: BoxFit.cover,
                                              )
                                            : Container(
                                                width: 85,
                                                height: 85,
                                                color: const Color(0xFF1E0B2E),
                                                child: const Icon(Icons.music_note, color: Colors.white70),
                                              ),
                                      ),
                                    ),
                                    
                                    // Título y Artista (Centro)
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            song['name']?.toString() ?? '',
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 19,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'Poppins',
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            artistName,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                              color: Colors.white, // Blanco suave y limpio
                                              fontSize: 15,
                                              fontFamily: 'Poppins',
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    // Flecha de navegación estilo Chevron blanco (Lado Derecho)
                                    const Padding(
                                      padding: EdgeInsets.only(right: 20.0),
                                      child: Icon(
                                        Icons.arrow_forward_ios_rounded,
                                        color: Colors.white,
                                        size: 24,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }
}