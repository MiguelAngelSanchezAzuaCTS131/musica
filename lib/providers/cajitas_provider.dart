import 'package:flutter/material.dart';

class CajitaModel {
  final String id;
  final String titulo;
  final String descripcion;
  final List<String> reviewIds; // Guarda los IDs de las reseñas asociadas

  CajitaModel({
    required this.id,
    required this.titulo,
    required this.descripcion,
    this.reviewIds = const [],
  });
}

class CajitasProvider with ChangeNotifier {
  final List<CajitaModel> _cajitas = [];

  List<CajitaModel> get cajitas => [..._cajitas];

  // 1. Función para crear una cajita
  void agregarCajita(String titulo, String descripcion) {
    if (titulo.isEmpty) return;
    final nuevaCajita = CajitaModel(
      id: DateTime.now().toString(),
      titulo: titulo,
      descripcion: descripcion,
    );
    _cajitas.add(nuevaCajita);
    notifyListeners();
  } 
  // 2. Ahora es un método independiente y accesible por las pantallas
  void eliminarReviewDeCajita(String cajitaId, String reviewId) {
    final index = _cajitas.indexWhere((c) => c.id == cajitaId);
    if (index >= 0) {
      final nuevasReviews = _cajitas[index].reviewIds.where((id) => id != reviewId).toList();

      _cajitas[index] = CajitaModel(
        id: _cajitas[index].id, 
        titulo: _cajitas[index].titulo, 
        descripcion: _cajitas[index].descripcion,
        reviewIds: nuevasReviews,
      );
      notifyListeners();
    }
  }

  // 3. Función para añadir reseñas
  void agregarReviewACajita(String cajitaId, String reviewId) {
    final index = _cajitas.indexWhere((c) => c.id == cajitaId);
    if (index >= 0) {
      if (!_cajitas[index].reviewIds.contains(reviewId)) {
        _cajitas[index] = CajitaModel(
          id: _cajitas[index].id,
          titulo: _cajitas[index].titulo,
          descripcion: _cajitas[index].descripcion,
          reviewIds: [..._cajitas[index].reviewIds, reviewId],
        );
        notifyListeners(); 
      }
    }
  }

  // En tu archivo cajitas_provider.dart, dentro de la clase:

void eliminarCajita(String id) {
  // Filtramos la lista eliminando el elemento que coincida con el ID
  _cajitas.removeWhere((cajita) => cajita.id == id);
  

  notifyListeners();
}
}