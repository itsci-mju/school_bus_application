import 'package:flutter/material.dart';
import 'package:map_launcher/map_launcher.dart';

import 'MapsSheet.dart';

class ShowMarker extends StatefulWidget {
  late double latitude  ;
  late double longitude  ;
  late String title ;
  ShowMarker({Key? key,required this.latitude,required this.longitude,required this.title}) :super(key: key);
  @override
  _ShowMarkerState createState() => _ShowMarkerState();

}

class _ShowMarkerState extends State<ShowMarker> {
  late double latitude ;
  late double longitude  ;
  late String title ;

  int zoom = 18;
  @override
  void initState() {
     latitude = widget.latitude ;
     longitude  = widget.longitude ;
     title = widget.title ;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return

      Column(
        children: <Widget>[
          MaterialButton(
            onPressed: () {
              MapsSheet.show(
                context: context,
                onMapTap: (map) {
                  map.showMarker(
                    coords: Coords(latitude, longitude),
                    title: title,
                    zoom: zoom,
                  );
                },
              );
            },
            child: Text('Show Maps'),
          )
        ],
      );
  }
}