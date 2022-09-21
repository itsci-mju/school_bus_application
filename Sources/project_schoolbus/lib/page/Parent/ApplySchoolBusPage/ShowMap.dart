
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import '../../../importer.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'ApplySchoolBusPage.dart';

class ShowMap extends StatefulWidget {
  const ShowMap({Key? key}) : super(key: key);

  @override
  State<ShowMap> createState() => _ShowMapState();
}

class _ShowMapState extends State<ShowMap> {
  Completer<GoogleMapController> _controller = Completer();
  Position? _currentLocation;
  static const LatLng centerMap = LatLng(18.89463,99.01087);
  CameraPosition cameraPosition = const CameraPosition(
      target: centerMap,
      zoom: 16.0,
  );

  @override
  void initState(){
    super.initState();
    findLocation();
  }

  Future<void> findLocation() async {
    _currentLocation = await locationData();
    print('Lat = ${_currentLocation?.latitude}, Lng = ${_currentLocation?.longitude}' );
  }
  final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;

  Future<Position?> locationData() async{
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await _geolocatorPlatform.isLocationServiceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await _geolocatorPlatform.isLocationServiceEnabled();
      if (!serviceEnabled) {
        return null;
      }
    }else{
      _currentLocation = await _geolocatorPlatform.getCurrentPosition();
    }

    permission = await _geolocatorPlatform.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await _geolocatorPlatform.requestPermission();
      if (permission == LocationPermission.denied) {
        return null;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('เลือกจุดที่ให้รับขึ้นรถ'),
        backgroundColor: Colors.amber,
      ),
      body:  Padding(
        padding: const EdgeInsets.all(15.0),
        child: GoogleMap(
          myLocationEnabled: true,
          mapType: MapType.normal,
          initialCameraPosition: cameraPosition,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
          markers: Set.from(myMarker),
          onTap: _handleTap,
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.fromLTRB(50, 0, 15, 0),
        child: Row(
          mainAxisAlignment : MainAxisAlignment.center,
          children: [
            FloatingActionButton.extended(
              onPressed: SavePosition,
              label: const Text('Sava Position'),
              icon: const Icon(Icons.location_on),
            ),
          ],
        ),
      ),
    );
  }

  List<Marker> myMarker = [];
  double? latitude;
  double? longitude;

  _handleTap(LatLng tappedPoint) async{
    print(tappedPoint.latitude);
    print(tappedPoint.longitude);
    latitude = tappedPoint.latitude;
    longitude = tappedPoint.longitude;
    setState(() {
      myMarker = [];
      myMarker.add(
        Marker(
          markerId: MarkerId(tappedPoint.toString()),
          position: tappedPoint,
          draggable: true,
          onDragEnd: ((newPosition){
            print(newPosition.latitude);
            print(newPosition.longitude);
          })
        )
      );

    });
  }

  void SavePosition() async{
    await getSharedPreferences.init();
    await getSharedPreferences.setLatitude(latitude.toString());
    await getSharedPreferences.setLongitude(longitude.toString());

    if(latitude == null || longitude == null){
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("กรุณาเลือกที่อยู่"))
      );
    }

    List<Placemark> placemarks = await placemarkFromCoordinates(latitude!, longitude!);
    Placemark pmarks = placemarks[0];
    String Address = '${pmarks.street} ,${pmarks.subLocality} ,${pmarks.subAdministrativeArea} ,${pmarks.administrativeArea} ,${pmarks.postalCode} ,${pmarks.country}';

    await getSharedPreferences.setAddress(Address);

    Navigator.of(context).pushReplacement(
        MaterialPageRoute(
            builder: (context) => ApplySchoolBusPage()));
  }

}