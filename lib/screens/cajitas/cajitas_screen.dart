import 'package:flutter/material.dart';
import 'package:musicboxd/theme/app_theme.dart';
import 'package:provider/provider.dart';
import 'package:lottie/lottie.dart'; // 🌟 Importante para Lottie
import 'package:musicboxd/providers/cajitas_provider.dart';
import 'cajitas_detail_screen.dart';

class CajitasScreen extends StatelessWidget {
  const CajitasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cajitasProvider = Provider.of<CajitasProvider>(context);
    final misCajitas = cajitasProvider.cajitas;

    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Mis Cajitas",
          style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.bold),
        ),
        foregroundColor: Colors.white,
      ),
      body: misCajitas.isEmpty
          ? _buildEmptyCajitas() 
          : ListView.builder(
              itemCount: misCajitas.length,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              itemBuilder: (context, index) {
                final cajita = misCajitas[index];
                
                
                return TweenAnimationBuilder(
                  duration: Duration(milliseconds: 400 + (index * 100)), // Se escalonan una tras otra
                  tween: Tween<double>(begin: 0, end: 1),
                  builder: (context, double value, child) {
                    return Opacity(
                      opacity: value,
                      child: Transform.translate(
                        offset: Offset(0, 30 * (1 - value)), // Desliza de abajo hacia arriba
                        child: child,
                      ),
                    );
                  },
                  child: Card(
                    color: AppTheme.indigoColor,
                    margin: const EdgeInsets.only(bottom: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      leading: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: const Color(0xFF6F42EC),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(Icons.inventory_2_outlined, color: Colors.white, size: 28),
                      ),
                      title: Text(
                        cajita.titulo,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Text(
                          cajita.descripcion,
                          style: const TextStyle(color: Colors.white60, fontSize: 13),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.delete_outline_rounded, color: Color(0xFFFF4A4A), size: 22),
                            onPressed: () {
                              _confirmarEliminacion(context, cajitasProvider, cajita);
                            },
                          ),
                          const SizedBox(width: 2),
                          const Icon(Icons.arrow_forward_ios, color: Colors.white24, size: 16),
                        ],
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => CajitaDetailScreen(cajitaId: cajita.id),
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
      
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF6F42EC),
        child: const Icon(Icons.add, color: Colors.white, size: 28),
        onPressed: () {
          _showCreateCajitaModal(context, cajitasProvider);
        },
      ),
    );
  }

  
  Widget _buildEmptyCajitas() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              'assets/lottie/caja.json', // Caja animada oficial de Lottie
              width: 200,
              height: 200,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(Icons.inventory_2_outlined, size: 100, color: Color(0xFF6F42EC));
              },
            ),
            const SizedBox(height: 20),
            const Text(
              "Tu caja está muy vacía",
              style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'Poppins'),
            ),
            const SizedBox(height: 8),
            Text(
              "Crea tu primera cajita para organizar tus reseñas favoritas.",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 14, fontFamily: 'Poppins'),
            ),
          ],
        ),
      ),
    );
  }

  
  void _confirmarEliminacion(BuildContext context, CajitasProvider provider, dynamic cajita) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1E1242), // Morado oscuro acorde a tu AppTheme
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text(
          "¿Borrar cajita?",
          style: TextStyle(color: Colors.white, fontFamily: 'Poppins', fontWeight: FontWeight.bold),
        ),
        content: Text(
          "¿Seguro que quieres eliminar la lista '${cajita.titulo}'? Esta acción no se puede deshacer.",
          style: const TextStyle(color: Colors.white70, fontFamily: 'Poppins'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancelar", style: TextStyle(color: Colors.white38, fontFamily: 'Poppins')),
          ),
          TextButton(
            onPressed: () {
    
              provider.eliminarCajita(cajita.id); 
              Navigator.pop(context);
              
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Cajita '${cajita.titulo}' eliminada"),
                  backgroundColor: const Color(0xFFFF4A4A),
                ),
              );
            },
            child: const Text(
              "Borrar", 
              style: TextStyle(color: Color(0xFFFF4A4A), fontFamily: 'Poppins', fontWeight: FontWeight.bold)
            ),
          ),
        ],
      ),
    );
  }

 
  void _showCreateCajitaModal(BuildContext context, CajitasProvider provider) {
    final tituloController = TextEditingController();
    final descripcionController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent, // Fondo nativo transparente para usar nuestra tarjeta pop-art
      builder: (context) {
        return Padding(
          // Controla que el teclado no tape el diseño en móviles
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom + 20,
            top: 24,
            left: 16,
            right: 16,
          ),
          child: Center(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 500), // Límite responsivo idéntico para Web y Escritorio
              decoration: BoxDecoration(
                color: const Color(0xFF6353A8), // Color morado claro base de tus contenedores
                borderRadius: BorderRadius.circular(32), // Bordes ultra redondeados pop-art
                boxShadow: const [
                  BoxShadow(
                    color: Color(0xFF382361), // Sombra sólida 3D icónica sin difuminado
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
                      "Nueva Cajita",
                      style: TextStyle(
                        color: Colors.white, 
                        fontSize: 22, 
                        fontWeight: FontWeight.bold, 
                        fontFamily: 'Poppins'
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  
                  // Campo 1: Nombre de la caja
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFF231254), // Fondo ultra oscuro para inputs dentro de la tarjeta
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: TextField(
                      controller: tituloController,
                      style: const TextStyle(color: Colors.white, fontFamily: 'Poppins'),
                      decoration: const InputDecoration(
                        hintText: "Nombre de la caja",
                        hintStyle: TextStyle(color: Colors.white38),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(16),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  // Campo 2: Descripción
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFF231254),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: TextField(
                      controller: descripcionController,
                      maxLines: 2,
                      style: const TextStyle(color: Colors.white, fontFamily: 'Poppins'),
                      decoration: const InputDecoration(
                        hintText: "Descripción (opcional)",
                        hintStyle: TextStyle(color: Colors.white38),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(16),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  
                  // Botón de acción: Crear Cajita
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF6F42EC), // Morado eléctrico pop
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        elevation: 0,
                      ),
                      onPressed: () {
                        if (tituloController.text.isNotEmpty) {
                          provider.agregarCajita(
                            tituloController.text,
                            descripcionController.text,
                          );
                          Navigator.pop(context);
                        }
                      },
                      child: const Text(
                        "Crear Cajita", 
                        style: TextStyle(
                          color: Colors.white, 
                          fontSize: 16, 
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Poppins'
                        ),
                      ),
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