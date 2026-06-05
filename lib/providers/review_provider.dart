import 'package:flutter/material.dart';
import '../models/review.dart';

enum ReviewFilter {
  newest,
  oldest,
  best,
  worst,
}

class ReviewProvider extends ChangeNotifier {
  final List<Review> _reviews = [];

  ReviewFilter _filter = ReviewFilter.newest;

  ReviewFilter get filter => _filter;

  void setFilter(ReviewFilter newFilter) {
    _filter = newFilter;
    notifyListeners();
  }

  void addReview(Review review) {
    _reviews.add(review);
    notifyListeners();
  }

  void updateReview(String id, Review updatedReview) {
    final index = _reviews.indexWhere((r) => r.id == id);

    if (index != -1) {
      _reviews[index] = updatedReview;
      notifyListeners();
    }
  }

  void deleteReview(String id) {
    _reviews.removeWhere((r) => r.id == id);
    notifyListeners();
  }

  void toggleFavorite(String id) {
    final index = _reviews.indexWhere((r) => r.id == id);

    if (index != -1) {
      _reviews[index].isFavorite = !_reviews[index].isFavorite;
      notifyListeners();
    }
  }

  List<Review> get reviews {
    List<Review> list = List.from(_reviews);

    switch (_filter) {
      case ReviewFilter.newest:
        list.sort((a, b) => b.createdAt.compareTo(a.createdAt));
        break;

      case ReviewFilter.oldest:
        list.sort((a, b) => a.createdAt.compareTo(b.createdAt));
        break;

      case ReviewFilter.best:
        list.sort((a, b) => b.rating.compareTo(a.rating));
        break;

      case ReviewFilter.worst:
        list.sort((a, b) => a.rating.compareTo(b.rating));
        break;
    }

    return list;
  }

  List<Review> get favorites =>
      _reviews.where((r) => r.isFavorite).toList();
}