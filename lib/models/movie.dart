class Movie {
  final String? id;
  final String title;
  final String? imageUrl;
  final double rating;
  final String review;

  const Movie(
      {this.id,
      required this.title,
      this.imageUrl,
      required this.rating,
      required this.review});
}
