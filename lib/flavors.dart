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
}