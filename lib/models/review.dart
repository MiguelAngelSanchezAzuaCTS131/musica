class Review {
  String id;
  String songName;
  String artist;
  String imageUrl;
  String comment;
  double rating;
  bool isFavorite;
  DateTime createdAt;

  Review({
    required this.id,
    required this.songName,
    required this.artist,
    required this.imageUrl,
    required this.comment,
    required this.rating,
    required this.createdAt,
    this.isFavorite = false,
  });

  // 1. Convierte un Mapa (JSON) que viene de la base de datos o almacenamiento en un objeto Review
  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      id: json['id'] as String,
      songName: json['songName'] as String,
      artist: json['artist'] as String,
      imageUrl: json['imageUrl'] as String,
      comment: json['comment'] as String,
      rating: (json['rating'] as num).toDouble(), // Evita errores si viene como int o double
      isFavorite: json['isFavorite'] as bool? ?? false,
      createdAt: DateTime.parse(json['createdAt'] as String), // Convierte el texto de nuevo a Fecha
    );
  }

  // 2. Convierte este objeto Review en un Mapa (JSON) para poder guardarlo fácilmente
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'songName': songName,
      'artist': artist,
      'imageUrl': imageUrl,
      'comment': comment,
      'rating': rating,
      'isFavorite': isFavorite,
      'createdAt': createdAt.toIso8601String(), // Las fechas se guardan mejor como texto (String)
    };
  }
}