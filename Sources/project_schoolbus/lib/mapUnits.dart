import 'package:url_launcher/url_launcher.dart';

class mapUnits{
  mapUnits._();

  static Future<void> openMap(
      double latitude,
      double longitude,
      ) async{
    String mapUrl="https://www.google.com/maps/search/?api=1&query=$latitude,$longitude";

    if(await canLaunch(mapUrl)){
      await launch(mapUrl);
    }else{
      print("URL can't be launched.");
    }
  }
}