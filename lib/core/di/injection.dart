import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'injection.config.dart';

import '../../core/network/network_info.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

final getIt = GetIt.instance;

@InjectableInit()
Future<void> configureDependencies() async => getIt.init();



@module
abstract class RegisterModule {


  @lazySingleton
  InternetConnectionChecker get connectionChecker =>InternetConnectionChecker.createInstance();

  @lazySingleton
  NetworkInfo get networkInfo => NetworkInfoImpl(connectionChecker);
}