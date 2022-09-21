import 'package:geolocator/geolocator.dart';

import '../../../importer.dart';
import 'ListChildrenActivityEvening.dart';

class EveningPage extends StatefulWidget {
  const EveningPage({Key? key}) : super(key: key);

  @override
  State<EveningPage> createState() => _EveningState();
}

class _EveningState extends State<EveningPage>{
  Position? _currentLocation;
  final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;

  Future<void> findLocation() async {
    _currentLocation = await locationData();
    print('Lat = ${_currentLocation?.latitude}, Lng = ${_currentLocation?.longitude}' );
  }

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
      body: SingleChildScrollView(
        child: Container(
            height: MediaQuery.of(context).size.height*1,
            child: ListChildrenActivityEvening()
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          saveActivity();
        },
        backgroundColor: Colors.green,
        child: const Icon(Icons.check_circle_outline),
      ),
    );
  }


  void saveActivity(){
    findLocation();
    print(_currentLocation!.latitude.toString()+""+_currentLocation!.longitude.toString());
  }



}