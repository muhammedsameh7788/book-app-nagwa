class Book {
  final int id;
  final String title;
  final List<String> authors;
  final String? imageUrl;
  final String? description;

  Book({
    required this.id,
    required this.title,
    required this.authors,
    this.imageUrl,
    this.description,
  });
}