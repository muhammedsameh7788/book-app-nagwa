import 'package:book_app/data/data_source/book_remote_data_source.dart';
import 'package:book_app/domain/entity/book.dart';
import 'package:book_app/domain/repository/book_repository.dart';

import 'package:injectable/injectable.dart';

import '../../core/common/result.dart';
import '../../core/error/api_execute.dart';


@Injectable(as: BookRepository)
class BookRepositoryImpl implements BookRepository {
  final BookRemoteDataSource remoteDataSource;

  BookRepositoryImpl(this.remoteDataSource);

  @override
  @override
  Future<Result<List<Book>>> getBooks({int page = 1, String? query}) async {
    return await executeApi(
          () async {
        final result = await remoteDataSource.fetchBooks(page: page, query: query);
        return result;
      },
    );
  }
}