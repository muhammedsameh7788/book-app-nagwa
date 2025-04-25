import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../core/common/result.dart';
import '../../domain/entity/book.dart';
import '../../domain/use_case/get_books_usecase.dart';

part 'book_state.dart';
@injectable
class BookCubit extends Cubit<BookState> {
  BookCubit(this.getBooksUseCase) : super(BookInitial());

  final GetBooksUseCase getBooksUseCase;
  int _currentPage = 1;
  bool _isFetching = false;
  bool _hasReachedEnd = false;
  String? _currentQuery;
  List<Book> _books = [];

  Future<void> fetchBooks({String? query}) async {
    if (_isFetching || _hasReachedEnd) return;
    _isFetching = true;

    final isNewQuery = query != _currentQuery;
    if (isNewQuery) {
      _currentPage = 1;
      _books = [];
      _hasReachedEnd = false;
      _currentQuery = query;
      emit(BookLoading());
    }

    final result = await getBooksUseCase(page: _currentPage, query: query);

    if (result is Success<List<Book>>) {
      final newBooks = result.data ?? [];
      if (newBooks.isEmpty && _currentPage == 1) {
        emit(BookEmpty());
      } else {
        _books.addAll(newBooks);
        _currentPage++;
        emit(BookLoaded(List<Book>.from(_books)));
      }
      emit(BookLoaded(List<Book>.from(_books)));
    } else if (result is Error<List<Book>>) {
      emit(BookError(result.exception ?? 'Unexpected error'));
    }

    _isFetching = false;
  }

  String? get currentQuery => _currentQuery;
}

