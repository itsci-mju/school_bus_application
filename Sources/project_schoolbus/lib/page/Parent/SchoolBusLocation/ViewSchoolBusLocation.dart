import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:project_schoolbus/manager/SchoolManager.dart';

import '../../../importer.dart';

class ViewSchoolBusLocationPage extends StatefulWidget {
  const ViewSchoolBusLocationPage({Key? key}) : super(key: key);

  @override
  State<ViewSchoolBusLocationPage> createState() => _ViewSchoolBusLocationState();
}


class _ViewSchoolBusLocationState extends State<ViewSchoolBusLocationPage> {
  final Completer<GoogleMapController> _controller = Completer();
 /* static const LatLng sourceLocation = LatLng(school!.school_latitude, double.parse(school.school_longitude));*/
  static const LatLng sourceLocation2 = LatLng(18.920101321544333, 98.99763430921033);

  @override
  void initState(){
    super.initState();
    getSchoolDetails();
  }

  bool isLoading = true;
  String school_ID = getSharedPreferences.getSchoolID() ?? '';
  SchoolManager manager = SchoolManager();
  School? school;
  void getSchoolDetails() {
    manager.getSchool(school_ID).then((value) => {
      setState(() {
        double l1 = double.parse(school!.school_latitude);
        school = value;
        isLoading = false;
      }),
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Track Loacation"
              /*  style: TextStyle(color: Colors.black,fontSize: 16),*/
          ),
        ),
        body: GoogleMap(
          initialCameraPosition: CameraPosition(
            target: sourceLocation2,
            zoom: 14.5
          ),
          markers: {
            const Marker(
              markerId: MarkerId("source"),
              /*position: sourceLocation,*/
            ),
            const Marker(
              markerId: MarkerId("destination"),
             /* position: sourceLocation,*/
            )
          },)

    );
  }

}