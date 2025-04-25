import 'dart:ui';

import 'package:book_app/flavors.dart';

class AppConstants {
  static  String baseUrl = Flavors.baseUrl();
  static const String internetConnectionError =
      "Please check your internet";
  static String appBarText =  Flavors.appBarText();
  static Color primaryColor = Flavors.primaryColor();
  static Color cardColor = Flavors.cardColor();

}
