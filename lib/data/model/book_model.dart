import 'package:book_app/domain/entity/book.dart';

class BookModel extends Book {
  BookModel({
    required int id,
    required String title,
    required List<String> authors,
    String? imageUrl,
    String? description,
  }) : super(
    id: id,
    title: title,
    authors: authors,
    imageUrl: imageUrl,
    description: description,
  );

  factory BookModel.fromJson(Map<String, dynamic> json) {
    final authors = (json['authors'] as List?)?.map((a) => a['name'].toString()).toList() ?? [];
    final imageUrl = (json['formats']['image/jpeg'] as String?) ?? '';
    return BookModel(
      id: json['id'],
      title: json['title'],
      authors: authors,
      imageUrl: imageUrl,
      description: json['subjects']?.join(", ") ?? '',
    );
  }
}