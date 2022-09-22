import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:project_schoolbus/manager/DriverManager.dart';
import 'package:project_schoolbus/model/ContractModel.dart';
import 'package:project_schoolbus/page/Driver/HomePage/top_container.dart';

import '../../../importer.dart';
import '../../manager/ContractManager.dart';
import '../Driver/HomePage/light_colors.dart';
import '../MainPage/mainChidren.dart';
import 'addbarChildren.dart';

class HomePageChidren extends StatefulWidget {
  const HomePageChidren({Key? key}) : super(key: key);

  @override
  State<HomePageChidren> createState() => _MainRegisterState();
}

class _MainRegisterState extends State<HomePageChidren> {
  String profile = getSharedPreferences.getProfile() ?? '';
  ContractManager manager = ContractManager();
  Contract? contract;
  Children? c;
  bool isLoading = true;

  @override
  void initState() {
    getProfile();
    getContractDetails();
    super.initState();
  }

  void getContractDetails() {
    manager.getContractDetailsbychildren(c!.IDCard).then((value) async => {
      // await getSharedPreferences.setSchoolID(contract!.routes.school.school_ID),
      setState(() {
        contract = value;
        isLoading = false;
      }),
    });
  }

  void getProfile() {
    var log = Logger();
    Map<String, dynamic> map = jsonDecode(profile);
     c = Children.fromJson(map);
  }

  Text subheading(String title) {
    return Text(
      title,
      style: const TextStyle(
          color: LightColors.kDarkBlue,
          fontSize: 20.0,
          fontWeight: FontWeight.w700,
          letterSpacing: 1.2),
    );
  }
  Completer<GoogleMapController> _controller = Completer();
  @override
  Widget build(BuildContext context) {
    if(isLoading){
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              ChildrenAddbar(),
              Padding(
                  padding: EdgeInsets.all(8.0)
                ,child: Row(
                children: [
                  Text(
                    "รายละเอียดคนขับรถรับส่ง : ",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800)

                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(40, 0, 0, 0),
                    child: InkWell(
                      child: Image.asset(
                        'images/Linemass.png',
                        height: 30.0,
                        fit: BoxFit.cover,
                      ),
                      onTap: ()async {
                        String url = contract!.routes.bus.driver.groupline;
                        var urllaunchable = await canLaunch(url);
                        if(urllaunchable){
                          await launch(url);
                        }else{
                          print("URL can't be launched.");
                        }
                      },
                    ),
                  )
                ],
              ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(8, 1, 0, 0),
                child: Row(
                  children: [
                    Text(
                        contract!.routes.bus.driver.firstname,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w600)
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Text(
                        contract!.routes.bus.driver.lastname,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500)
                    ),
                  ],
                ),
                ),
              Padding(
                padding: EdgeInsets.fromLTRB(8, 1, 0, 5),
                child: Row(
                  children: [
                    Text(
                        CalAge(contract!.routes.bus.driver.birthday),
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500)
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    RichText(
                      text: TextSpan(
                        style: DefaultTextStyle.of(context).style,
                        children:  <TextSpan>[
                          const TextSpan(text: "เบอร์โทร : ", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18)),
                          TextSpan(text: contract!.routes.bus.driver.phone, style: TextStyle(fontSize: 18))
                        ],

                      ),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.topRight,
                        child: InkWell(
                          onTap: (){
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) =>
                                        MainPageChidren(indexScreen: null,)));
                          },
                          child: Container(
                            width: 80,
                            height: 40,
                            child: Row(
                              children: [
                                Icon(Icons.refresh, color: Color(0xffa3d064),),
                                Text("รีเฟรช",style: TextStyle(fontSize: 18))
                              ],
                            ),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    color: Color(0xffa3d064),
                                    width: 1
                                )
                            ),
                          ),
                        )
                    ),),
                    SizedBox(
                      width: 20.0,
                    ),

                  ],

                ),
              ),

              Container(
                height: MediaQuery.of(context).size.height*0.53,
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 2,
                    color: Colors.black,  // red as border color
                  ),
                ),
                child: GoogleMap(
                  myLocationEnabled: true,
                  mapType: MapType.normal,
                  initialCameraPosition: CameraPosition(
                    target: LatLng(double.parse(contract!.routes.bus.bus_latitude), double.parse(contract!.routes.bus.bus_longitude)),
                    zoom: 16,
                  ),
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                  },
                  markers: {
                    Marker(
                        markerId: MarkerId("1"),
                        position:  LatLng(double.parse(contract!.routes.bus.bus_latitude), double.parse(contract!.routes.bus.bus_longitude)),
                        infoWindow: InfoWindow(title: "ที่อยู่ปัจจุบันคนขับรถ")),
                  },

                ),
              )
            ],
          ),
        ),
      )
    );
  }

  String CalAge(DateTime date){
    DateTime purchaseDate = DateTime(date.year, date.month, date.day);
    DateDuration duration;
    duration = AgeCalculator.age(purchaseDate);
    return "อายุ : "+duration.years.toString()+" ปี";
  }
}
