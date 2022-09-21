
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:project_schoolbus/manager/DriverManager.dart';
import 'package:project_schoolbus/page/Driver/HomePage/top_container.dart';

import '../../../importer.dart';
import 'card_Percent.dart';
import 'card_details.dart';
import 'light_colors.dart';

class HomePageDriver extends StatefulWidget {
  const HomePageDriver({Key? key}) : super(key: key);

  @override
  State<HomePageDriver> createState() => _MainRegisterState();
}

class _MainRegisterState extends State<HomePageDriver>{
  
  String profile = getSharedPreferences.getProfile() ?? '';
  String bus = getSharedPreferences.getBus() ?? '';
  Driver? d;
  Bus? b;
  List? l;
  bool isLoading = true;

  @override
  void initState() {
    getProfile();
    getCalDetails();
    super.initState();
  }

  void getProfile(){
    Map<String, dynamic> map = jsonDecode(profile);
    Map<String, dynamic> map2 = jsonDecode(bus);
    d = Driver.fromJson(map);
    b = Bus.fromJson(map2);
  }

  void getCalDetails() {
    DriverManager manager = DriverManager();
    var log= Logger();
      manager.getCalDetails(b!.num_plate).then((value) => {
        l = value,
        log.e(l.toString()),
        setState(() {
          isLoading = false;
        })
      });

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
    double width = MediaQuery.of(context).size.width;
    if(isLoading){
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return Container(
        color: Colors.white,
        child: Column(
            children: <Widget>[
              TopContainer(
                height: 300,
                width: width,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,

                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 0, vertical: 0.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Container (
                              height: 150,
                              width: 150,
                              decoration:  BoxDecoration(
                                  border: Border.all(
                                    color: Color(0xFFE46472),
                                    width: 10,
                                  ),
                                  borderRadius: BorderRadius.all(Radius.circular(100.0)),
                                  image: DecorationImage(
                                      image: NetworkImage(d!.image_profile),
                                      fit: BoxFit.cover)
                              ),
                            ),

                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                const Text(
                                  'รายละเอียดคนขับรถรับส่ง',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    color: LightColors.kDarkBlue,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                                Text(
                                  d!.firstname+" "+d!.lastname,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 22.0,
                                    color: LightColors.kDarkBlue,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                                Text(
                                  'โทร : '+d!.phone,
                                  textAlign: TextAlign.start,
                                  style: const TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.black45,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  'อายุ : '+CalAge(d!.birthday),
                                  textAlign: TextAlign.start,
                                  style: const TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.black45,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Padding(padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                                child: InkWell(
                                  child: Image.asset(
                                    'images/Linemass.png',
                                    height: 30.0,
                                    fit: BoxFit.cover,
                                  ),
                                  onTap: ()async {
                                    String url = d!.groupline;
                                    var urllaunchable = await canLaunch(url);
                                    if(urllaunchable){
                                      await launch(url);
                                    }else{
                                      print("URL can't be launched.");
                                    }
                                  },
                                )
                                ,)
                                ,
                              ],
                            )
                          ],
                        ),
                      )
                    ]),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Container(
                        color: Colors.transparent,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            subheading('รายละเอียด'),
                            const SizedBox(height: 5.0),
                            Row(
                              children: <Widget>[
                                CardDetails(
                                  cardColor: Color(0xff177c99),
                                  loadingPercent: 0.9,
                                  title: 'คำร้องขอยกเลิก',
                                  subtitle: '23 hours progress',
                                  number: l![2],
                                ),
                                const SizedBox(width: 20.0),
                                CardDetails(
                                  cardColor: Color(0xff177c99),
                                  loadingPercent: 0.6,
                                  title: 'คำร้องขอขึ้นรถ',
                                  subtitle: '20 hours progress',
                                  number: l![1],
                                ),
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                ActiveProjectsCard(
                                  cardColor: Color(0xff57bcd9),
                                  title: 'รถมีนักเรียนทั้งหมด',
                                  seats: b!.seats_amount.toString(),
                                  children: l![0],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
        ),
    );
  }

  String CalAge(DateTime date){
    DateTime purchase_date = DateTime(date.year, date.month, date.day);
    DateDuration duration;
    duration = AgeCalculator.age(purchase_date);
    return duration.years.toString();
  }
}


