import 'package:book_app/core/utils/constant_manager.dart';
import 'package:book_app/data/model/book_model.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../core/error/error_handler.dart';
import '../../core/network/network_info.dart';
import '../../core/utils/end_points.dart';


@injectable
class BookRemoteDataSource {
  final Dio dio;
  final NetworkInfo networkInfo;

  BookRemoteDataSource(this.dio, this.networkInfo);

  Future<List<BookModel>> fetchBooks({int page = 1, String? query}) async {
    if (!await networkInfo.isConnected) {
      throw AppError("No Internet Connection");
    }

    final url = '${AppConstants.baseUrl}${ApiEndPoints.bookListEndPoint}?page=$page${query != null ? '&search=$query' : ''}';

    try {
      final response = await dio.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> results = response.data['results'];
        return results.map((json) => BookModel.fromJson(json)).toList();
      } else {
        throw AppError('Failed to load books: ${response.statusMessage}');
      }
    } catch (e) {
      throw AppError('Failed to load books: $e');
    }
  }
}
