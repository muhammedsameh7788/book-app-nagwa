import '../../core/common/result.dart';
import '../entity/book.dart';

abstract class BookRepository {
  Future<Result<List<Book>>>  getBooks({int page = 1, String? query});
}
