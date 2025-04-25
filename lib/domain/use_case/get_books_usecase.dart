import '../../core/common/result.dart';
import '../entity/book.dart';
import '../repository/book_repository.dart';

import 'package:injectable/injectable.dart';

@injectable
class GetBooksUseCase {
  final BookRepository repository;

  GetBooksUseCase(this.repository);

  Future<Result<List<Book>>>  call({int page = 1, String? query}) async {
    return repository.getBooks(page: page, query: query);
  }
}