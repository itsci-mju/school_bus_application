import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../importer.dart';
import '../../../manager/ContractManager.dart';
import '../../../manager/DriverManager.dart';
import '../../../model/ContractModel.dart';

class ViewLocation extends StatefulWidget {
  const ViewLocation({Key? key}) : super(key: key);

  @override
  State<ViewLocation> createState() => _ViewLocationState();
}
class _ViewLocationState extends State<ViewLocation>{
  Completer<GoogleMapController> _controller = Completer();

  @override
  void initState() {
    getContractDetails();
    super.initState();
  }

  bool isLoading = true;

  String id = getSharedPreferences.getDeiverID() ?? '';
  DriverManager manager = DriverManager();
  Bus? bus;
  void getContractDetails() {
    manager.getBusDetails(id).then((value) async => {
      // await getSharedPreferences.setSchoolID(contract!.routes.school.school_ID),
      setState(() {
        bus = value;
        isLoading = false;
      }),
    });
  }


  @override
  Widget build(BuildContext context) {
    if(isLoading){
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return Scaffold(
      appBar: AppBar(
          title: const Text("ตำแหน่งคนขับ"),
          toolbarHeight: 60,
          shape: const RoundedRectangleBorder(),
        leading: GestureDetector(
          child: Icon( Icons.arrow_back_ios, color: Colors.black,  ),
          onTap: () {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                    builder: (context) => MyHomePage(indexScreen: null,)));
          } ,
        ) ,),
      body:  Padding(
        padding: const EdgeInsets.all(15.0),
        child: GoogleMap(
          myLocationEnabled: true,
          mapType: MapType.normal,
          initialCameraPosition: CameraPosition(
            target: LatLng(double.parse(bus!.bus_latitude), double.parse(bus!.bus_longitude)),
            zoom: 16,
          ),
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
            markers: {
              Marker(
                  markerId: MarkerId("1"),
                  position:  LatLng(double.parse(bus!.bus_latitude), double.parse(bus!.bus_longitude)),
                  infoWindow: InfoWindow(title: "ที่อยู่ปัจจุบันคนขับรถ")),
            },

        ),
      ),
    );
  }


}