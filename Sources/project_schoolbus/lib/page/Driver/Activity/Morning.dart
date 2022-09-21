import 'package:flutter/cupertino.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';

import '../../../importer.dart';
import '../../../manager/ContractManager.dart';
import '../../../model/ContractModel.dart';
import 'List_Children_Activity.dart';

class MorningPage extends StatefulWidget {
  const MorningPage({Key? key}) : super(key: key);

  @override
  State<MorningPage> createState() => _MorningState();
}

class _MorningState extends State<MorningPage>{

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
          child: ListChildrenActivity()
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

  String CalAge(DateTime date){
    DateTime purchase_date = DateTime(date.year, date.month, date.day);
    DateDuration duration;
    duration = AgeCalculator.age(purchase_date);
    return duration.years.toString();
  }

  void CheckService(bool val){

  }

  void saveActivity(){
    findLocation();
    print(_currentLocation!.latitude.toString()+""+_currentLocation!.longitude.toString());
  }


}