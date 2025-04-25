// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:book_app/core/di/injection.dart' as _i451;
import 'package:book_app/core/network/network_factory.dart' as _i255;
import 'package:book_app/core/network/network_info.dart' as _i928;
import 'package:book_app/data/data_source/book_remote_data_source.dart'
    as _i218;
import 'package:book_app/data/repository_imp/book_repository_impl.dart'
    as _i449;
import 'package:book_app/domain/repository/book_repository.dart' as _i558;
import 'package:book_app/domain/use_case/get_books_usecase.dart' as _i594;
import 'package:book_app/presitesion/cubit/book_cubit.dart' as _i682;
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:internet_connection_checker/internet_connection_checker.dart'
    as _i973;
import 'package:pretty_dio_logger/pretty_dio_logger.dart' as _i528;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final registerModule = _$RegisterModule();
    final dioProvider = _$DioProvider();
    gh.lazySingleton<_i973.InternetConnectionChecker>(
      () => registerModule.connectionChecker,
    );
    gh.lazySingleton<_i928.NetworkInfo>(() => registerModule.networkInfo);
    gh.lazySingleton<_i361.Dio>(() => dioProvider.dioProvider());
    gh.lazySingleton<_i528.PrettyDioLogger>(() => dioProvider.providePretty());
    gh.factory<_i218.BookRemoteDataSource>(
      () =>
          _i218.BookRemoteDataSource(gh<_i361.Dio>(), gh<_i928.NetworkInfo>()),
    );
    gh.factory<_i558.BookRepository>(
      () => _i449.BookRepositoryImpl(gh<_i218.BookRemoteDataSource>()),
    );
    gh.factory<_i594.GetBooksUseCase>(
      () => _i594.GetBooksUseCase(gh<_i558.BookRepository>()),
    );
    gh.factory<_i682.BookCubit>(
      () => _i682.BookCubit(gh<_i594.GetBooksUseCase>()),
    );
    return this;
  }
}

class _$RegisterModule extends _i451.RegisterModule {}

class _$DioProvider extends _i255.DioProvider {}
