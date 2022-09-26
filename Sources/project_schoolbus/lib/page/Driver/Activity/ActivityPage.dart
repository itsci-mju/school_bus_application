import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';

import '../../../importer.dart';
import '../../../manager/DriverManager.dart';
import '../../MainPage/mainDriver.dart';
import '../HomePage/light_colors.dart';
import 'Evening.dart';
import 'ListChildrenActivityEvening.dart';
import 'List_Children_Activity.dart';
import 'Morning.dart';

class ActivityPage extends StatefulWidget {
  const ActivityPage({Key? key}) : super(key: key);

  @override
  State<ActivityPage> createState() => _ActivityState();
}

class _ActivityState extends State<ActivityPage> with SingleTickerProviderStateMixin {
  TabController? _tabController;

  int _selectedTab = 1;
  String b = getSharedPreferences.getBus() ?? '';
  Bus? bus;

  void getProfile(){
    Map<String, dynamic> map2 = jsonDecode(b);
    bus = Bus.fromJson(map2);
  }
  final now = DateTime.now();

  @override
  void initState() {
    super.initState();
    getProfile();

    Future.delayed(Duration(minutes: 1), (){
      doupdatebus();
    });

    _tabController = TabController(vsync: this, length: 2);

    _tabController!.addListener((){
      if (!_tabController!.indexIsChanging){
        setState(() {
          _selectedTab = _tabController!.index;
        });
      }
    });
  }
  DateTime d =DateTime.now();

  @override
  Widget build(BuildContext context) {
   int.parse(DateFormat('HH').format(d))  > 12 ?
    _tabController!.animateTo(1):
    _tabController!.animateTo(0);
    return Scaffold(
      appBar: AppBar(
        title: const Text("การขึ้นรถ-ลงรถ"),
        toolbarHeight: 60,
        shape: const RoundedRectangleBorder(
            borderRadius:  BorderRadius.only(
                bottomRight: Radius.circular(10),
                bottomLeft: Radius.circular(10))
        ),
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () =>   Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                  builder: (context) => MainPageDriver())),
        ),
        backgroundColor: Colors.amber,

      ),
      backgroundColor: LightColors.kLightYellow,
      body: DefaultTabController(
          length: 2,
          initialIndex: 1,
          child: Column(
            children: <Widget>[
              Material(
                color: Colors.grey.shade300,
                child: TabBar(
                  unselectedLabelColor: Colors.grey,
                  labelColor: const Color(0xff3f5632),
                  indicatorColor: Colors.black,
                  controller: _tabController,
                  labelPadding: const EdgeInsets.all(0.0),
                  tabs: [
                    _getTab(0,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(
                             Icons.wb_sunny,
                            ),
                            SizedBox(width: 10,),
                            Text('รอบเช้า',style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w800),)
                          ],
                        )
                    ),
                    _getTab(1,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(
                              Icons.wb_twilight,
                            ),
                            SizedBox(width: 10,),
                            Text('รอบเย็น',style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w800),)
                          ],
                        )
                    ),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: _tabController,
                  children: [
                    SizedBox(
                        height: MediaQuery.of(context).size.height*0.74,
                        width: 400,
                        child: const ListChildrenActivity()
                    ),
                    SizedBox(
                        height: MediaQuery.of(context).size.height*0.74,
                        width: 400,
                        child: const ListChildrenActivityEvening()
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }


  _getTab(index, child) {
    return Tab(
      child: SizedBox.expand(
        child: Container(
          child: child,
          decoration: BoxDecoration(
              color:
              (_selectedTab == index ? Colors.white : Colors.grey.shade300),
              borderRadius: _generateBorderRadius(index)),
        ),
      ),
    );
  }

  _generateBorderRadius(index) {
    if ((index + 1) == _selectedTab) {
      return const BorderRadius.only(bottomRight: Radius.circular(10.0));
    }else if ((index - 1) == _selectedTab) {
      return const BorderRadius.only(bottomLeft: Radius.circular(10.0));
    }else {
      return BorderRadius.zero;
    }
  }
  Position? _position;
  Future _getCurrentLocation() async {
    Position position = await _determinePosition();
    setState(() {
      _position = position;
    });
  }

  Future<Position> _determinePosition() async {
    LocationPermission permission;

    permission = await Geolocator.checkPermission();

    if(permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if(permission == LocationPermission.denied) {
        return Future.error('Location Permissions are denied');
      }
    }

    return await Geolocator.getCurrentPosition();
  }
  DriverManager dmanager = DriverManager();
  Future doupdatebus() async {
    await _getCurrentLocation();
    bus!.bus_latitude =_position!.latitude.toString();
    bus!.bus_longitude =_position!.longitude.toString();
    String results = await dmanager.updateBuslocation(bus!);
    if(results != "0") {
      AnimatedSnackBar.rectangle(
          'สำเร็จ',
          'คุณเพิ่มกิจกรรมสำเร็จ',
          type: AnimatedSnackBarType.success,
          brightness: Brightness.light,
          duration : const Duration(seconds: 5)
      ).show(
        context,
      );
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(
              builder: (context) =>
                  ActivityPage()));

    }else{
      AnimatedSnackBar.rectangle(
          'เกิดข้อผิดพลาด',
          'เกิดข้อผิดพลาดในการเพิ่มกิจกรรมสำเร็จ',
          type: AnimatedSnackBarType.error,
          brightness: Brightness.light,
          duration : const Duration(seconds: 5)
      ).show(
        context,
      );
    }
  }

}