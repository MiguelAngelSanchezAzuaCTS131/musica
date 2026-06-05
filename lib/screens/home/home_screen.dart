import 'package:flutter/material.dart';
import 'package:musicboxd/screens/favorites/favorites_screen.dart';
import 'package:musicboxd/widgets/menu_card.dart';
import 'package:musicboxd/screens/search/search_screen.dart';
import 'package:musicboxd/screens/review/reviews_screen.dart';
import 'package:musicboxd/screens/cajitas/cajitas_screen.dart';
import '../profiles/profile_screen.dart'; 

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
   
    const Color moradoOscuro = Color(0xFF211161);
    const Color moradoClaro = Color(0xFF6F42EC);

    return Scaffold(
      backgroundColor: const Color(0xFF0E0B1F), 
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
            
                  const Text(
                    "MELOBOXD",
                    style: TextStyle(
                      fontFamily: 'Brasika',
                      fontSize: 50,
                      color: Color(0xFFD2B4DE), // Color lila suave del logo
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Menú Principal",
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 40),

              
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    crossAxisSpacing: 25,
                    mainAxisSpacing: 30,
                    childAspectRatio: 0.95, // Forma casi cuadrada perfecta
                    children: [
                      MenuCard(
                        title: "Buscar",
                        icon: Icons.search_rounded,
                        backgroundColor: moradoOscuro, // 1. Oscuro
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (_) => const SearchScreen()));
                        },
                      ),
                      MenuCard(
                        title: "Reviews",
                        icon: Icons.chat_bubble_outline_rounded,
                        backgroundColor: moradoClaro, // 2. Claro
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (_) => const ReviewsScreen()));
                        },
                      ),
                      MenuCard(
                        title: "Favoritos",
                        icon: Icons.favorite_rounded,
                        backgroundColor: moradoClaro, // 3. Claro
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (_) => const FavoritesScreen()));
                        },
                      ),
                      MenuCard(
                        title: "Cajitas",
                        icon: Icons.add_box_rounded, // Icono de la caja abierta
                        backgroundColor: moradoOscuro, // 4. Oscuro
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (_) => const CajitasScreen()));
                        },
                      ),
                    ],
                  ),

                  const SizedBox(height: 30),

                  // 👤 BOTÓN PERFIL ABAJO EN EL CENTRO (Navegación conectada aquí)
                  FractionallySizedBox(
                    widthFactor: 0.47, 
                    child: AspectRatio(
                      aspectRatio: 0.95, // Mismo tamaño cuadrado
                      child: MenuCard(
                        title: "Perfil",
                        icon: Icons.person_rounded,
                        backgroundColor: moradoOscuro, // 5. Claro para romper la simetría inferior y que resalte
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (_) => const ProfileScreen()));
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}