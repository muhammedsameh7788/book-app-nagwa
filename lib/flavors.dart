import 'dart:ui';

enum AppFlavor {
  development , production
}
class Flavors{
  static AppFlavor? appFlavor;
  static String appBarText(){
    switch (appFlavor){
      case AppFlavor.development:
        return "book (d)";
      case AppFlavor.production:
        return "book app";
      default:
        return'development';
    }

  }
  static Color primaryColor (){
    switch (appFlavor){
      case AppFlavor.development:
        return Color(0xffD21E6A);
      case AppFlavor.production:
        return Color(0xff7FCFA8);
      default:
        return Color(0xffD21E6A);


    }
  }
  static Color cardColor (){
    switch (appFlavor){
      case AppFlavor.development:
        return Color(0xffffffff);
      case AppFlavor.production:
        return Color(0xffffffff);
      default:
        return Color(0xffffffff);


    }
  }
  static String baseUrl(){
    switch (appFlavor){
      case AppFlavor.development:
        return "https://gutendex.com";
      case AppFlavor.production:
        return "https://gutendex.com";
      default:
        return'https://gutendex.com';
    }

  }

}