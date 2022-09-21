import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:project_schoolbus/manager/DriverManager.dart';
import 'package:project_schoolbus/model/ContractModel.dart';
import 'package:project_schoolbus/page/Driver/HomePage/top_container.dart';

import '../../../importer.dart';
import '../../manager/ContractManager.dart';
import '../Driver/HomePage/light_colors.dart';
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

  @override
  Widget build(BuildContext context) {
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
                padding: EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text(
                        contract!.routes.bus.driver.firstname,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w500)
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
                )
            ],
          ),
        ),
      )
    );
  }
}
