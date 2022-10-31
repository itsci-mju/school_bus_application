

import 'package:intl/intl.dart';
import 'package:project_schoolbus/page/Driver/Profile/ImageDialog.dart';

import '../../../importer.dart';

import '../../AlertDialog.dart';
import '../../Driver/HomePage/light_colors.dart';
import '../ApplySchoolBusPage/ApplySchoolBusPage.dart';

class SchoolBusDetailsPage extends StatefulWidget {
  const SchoolBusDetailsPage({Key? key}) : super(key: key);

  @override
  State<SchoolBusDetailsPage> createState() => _SchoolBusDetailsState();
}

class _SchoolBusDetailsState extends State<SchoolBusDetailsPage> {
  RouteManager manager = RouteManager();
  String num_plate = getSharedPreferences.getNum_plate() ?? '';
  String Firstname = getSharedPreferences.getFirstname() ?? '';
  List<BusStop>? listRoutes ;
  List<BusStop>? listRoutesBySchool ;
  bool isLoading = true;
  List? l;
  final f = new DateFormat('HH:mm');

  @override
  void initState() {
    getSchoolBusDetails();
    getCalDetails();
    super.initState();
  }

  void getSchoolBusDetails() async{
    setState(() {
      isLoading = true;
    });
    await manager.getSchoolBusDetails(num_plate).then((value) => {
      listRoutes = value,
      setState(() {
        var log = Logger();
        log.e("dsadsaddddddddddddddddddsadasdasd "+listRoutes.toString());
        isLoading = false;
      })
    });
  }

  void getCalDetails() async{
    setState(() {
      isLoading = true;
    });
    manager.getCalDetails(num_plate).then((value) => {
      l = value,
      setState(() {
        isLoading = false;
      })
    });
  }



  @override
  Widget build(BuildContext context) {
    AlertDialogApp alertDialogApp =AlertDialogApp();
    if(l == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return Scaffold(
        appBar: AppBar(title: const Text('รายระเอียดรถรับส่ง'), backgroundColor: Colors.amber,
        ),
        body: Container(
          decoration: const BoxDecoration(
            color: LightColors.kLightYellow2,
          ),
          child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 400,
                    height: 800,
                    child: SingleChildScrollView(
                      child: Card(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Center(
                                              child: Padding(
                                                padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                                                    child: Row(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Padding(
                                                          padding: const EdgeInsets.fromLTRB(8, 0, 15, 0),
                                                          child: Image.network(
                                                            listRoutes![0].bus.image_Bus,
                                                            width: 150.0,
                                                            height: 150.0,
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          width: 20,
                                                        ),
                                                        Expanded(
                                                          child: Column(
                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              Container(
                                                                decoration: BoxDecoration(
                                                                  border: Border.all(width: 1.9, color: const Color(
                                                                      0xFFC9C9C9)),
                                                                ),
                                                                child: Padding(
                                                                  padding: const EdgeInsets.symmetric(horizontal: 45.0,vertical: 5.0),
                                                                  child: Column(
                                                                      children: [
                                                                        Text(
                                                                          listRoutes![0].bus.num_plate,
                                                                          style: const TextStyle(
                                                                              fontSize: 20,
                                                                              fontWeight: FontWeight.w500),
                                                                        ),
                                                                        const SizedBox(
                                                                          height: 5,
                                                                        ),
                                                                        Text(
                                                                          listRoutes![0].bus.province ,
                                                                          style: const TextStyle(
                                                                              fontSize: 16,
                                                                              fontWeight: FontWeight.w500),
                                                                        ),
                                                                      ],
                                                                  ),
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                height: 5,
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Column(
                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                    children: [
                                                                      const Text(
                                                                        "ยี่ห้อ",
                                                                        style: TextStyle(
                                                                            fontSize: 14,
                                                                            fontWeight: FontWeight.w500),
                                                                      ),
                                                                      const SizedBox(
                                                                        height: 8,
                                                                      ),
                                                                      Text(
                                                                        listRoutes![0].bus.brand,
                                                                        style: const TextStyle(
                                                                            fontSize: 16,
                                                                            fontWeight: FontWeight.w500),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  const SizedBox(
                                                                    width : 20,
                                                                  ),
                                                                  Column(
                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                    children: [
                                                                      const Text(
                                                                        "อายุการใช้งาน",
                                                                        style: TextStyle(
                                                                            fontSize: 14,
                                                                            fontWeight: FontWeight.w500),
                                                                      ),
                                                                      const SizedBox(
                                                                        height: 8,
                                                                      ),
                                                                      Text(
                                                                        CalAge(listRoutes![0].bus.purchase_date)+" ปี",
                                                                        style: const TextStyle(
                                                                            fontSize: 16,
                                                                            fontWeight: FontWeight.w500),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        )
                                                      ],
                                                    )
                                              ),
                                            ),
                                            Center(
                                              child: Container(
                                                width: 350,
                                                decoration: BoxDecoration(
                                                  border: Border.all(width: 1.0, color: const Color(
                                                      0xFFC9C9C9)),
                                                ),
                                              ),
                                            ),
                                            Center(
                                              child: Padding(
                                                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                                                  child: Row(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Padding(
                                                        padding: const EdgeInsets.fromLTRB(8, 0, 15, 0),
                                                        child: Container (
                                                          height: 150,
                                                          width: 150,
                                                          decoration:  BoxDecoration(
                                                              image: DecorationImage(
                                                                  image: NetworkImage(listRoutes![0].bus.driver.image_profile),
                                                                  fit: BoxFit.cover)
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        width: 20,
                                                      ),
                                                      Expanded(
                                                        child: Column(
                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                                    Text(
                                                                      listRoutes![0].bus.driver.firstname+" "+listRoutes![0].bus.driver.lastname,
                                                                      style: const TextStyle(
                                                                          fontSize: 20,
                                                                          fontWeight: FontWeight.w500),
                                                                    ),
                                                                    const SizedBox(
                                                                      height: 5,
                                                                    ),
                                                            const SizedBox(
                                                              height: 8,
                                                            ),
                                                            Row(
                                                              children: [
                                                                    Text(
                                                                      "อายุ  "+CalAge(listRoutes![0].bus.driver.birthday)+"  ปี",
                                                                      style: const TextStyle(
                                                                          fontSize: 16,
                                                                          fontWeight: FontWeight.w500),
                                                                    ),
                                                              ],
                                                            ),
                                                            const SizedBox(
                                                              height: 8,
                                                            ),
                                                            Column(
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                const Text(
                                                                  "เบอร์โทร :",
                                                                  style: TextStyle(
                                                                      fontSize: 15,
                                                                      fontWeight: FontWeight.w500),
                                                                ),
                                                                const SizedBox(
                                                                  height: 8,
                                                                ),
                                                                Text(
                                                                  listRoutes![0].bus.driver.phone,
                                                                  style: const TextStyle(
                                                                      fontSize: 16,
                                                                      fontWeight: FontWeight.w500),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  )
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Firstname != ''?
                                            Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Container(

                                                  child: Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.spaceBetween,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Column(
                                                        children: [
                                                          Text("รูปใบอณุาตขับขี่รถยนต์ส่วนบุคคล"
                                                          ),
                                                          Material(
                                                            child: InkWell(
                                                              splashColor: Colors.grey,
                                                              onTap: () => showDialog(
                                                                  context: context, builder: (_) =>  ImageDialog(listRoutes![0].bus.driver.driver_license)),
                                                              child: Container(
                                                                height: 50,
                                                                width: 150,
                                                                child: Center(
                                                                  child: Text(
                                                                    "ดูรูป",
                                                                    style: TextStyle(
                                                                        fontSize: 14,
                                                                        color: Colors.grey),
                                                                  ),
                                                                ),
                                                                decoration: BoxDecoration(
                                                                  borderRadius:
                                                                  BorderRadius.circular(10),
                                                                  border: Border.all(
                                                                      color: Colors.grey, width: 1),
                                                                ),
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      )
                                                      ,
                                                      Column(
                                                        children: [
                                                          Text("รูปใบอณุาตขับขี่รถรับส่ง"),
                                                          Material(
                                                            child: InkWell(
                                                              splashColor: Colors.grey,
                                                              onTap: () => showDialog(
                                                                  context: context, builder: (_) =>  ImageDialog(listRoutes![0].bus.driver.student_bus_license)),
                                                              child: Container(
                                                                height: 50,
                                                                width: 150,
                                                                child: Center(
                                                                  child: Text(
                                                                    "ดูรูป",
                                                                    style: TextStyle(
                                                                        fontSize: 14,
                                                                        color: Colors.grey),
                                                                  ),
                                                                ),
                                                                decoration: BoxDecoration(
                                                                  borderRadius:
                                                                  BorderRadius.circular(10),
                                                                  border: Border.all(
                                                                      color: Colors.grey, width: 1),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      )

                                                    ],
                                                  ),
                                                )
                                              ],
                                            ): Container(),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Center(
                                              child: Container(

                                                width: 350,
                                                decoration: BoxDecoration(
                                                  border: Border.all(width: 1.0, color: const Color(
                                                      0xFFC9C9C9)),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 25,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 30.0),
                                              child: Row(
                                                children: const [
                                                  Icon(
                                                    Icons.list,
                                                    size: 30.0,
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    "เส้นทาง",
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight: FontWeight.w800),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 25,
                                            ),
                                            InkWell(
                                              child: Text('ดูเส้นทางที่รับ',
                                                style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w500),
                                              ),
                                              onTap: () async {
                                                String url = listRoutes![0].bus.route_mapURL;
                                                var urllaunchable = await canLaunch(url); //canLaunch is from url_launcher package
                                                if(urllaunchable){
                                                  await launch(url); //launch is from url_launcher package to launch URL
                                                }else{
                                                  print("URL can't be launched.");
                                                }
                                              },
                                            ),
                                            const SizedBox(
                                              height: 25,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 30.0),
                                              child: Row(
                                                children: const [
                                                  Icon(
                                                    Icons.list,
                                                    size: 30.0,
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                    Text(
                                                      "โรงเรียนที่รับ",
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight: FontWeight.w800),
                                                    ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 30.0),
                                              child: Container(
                                                width: 350,
                                                height: 150,
                                                child: ListView.separated(
                                                  scrollDirection: Axis.vertical,
                                                    itemCount: listRoutes!.length,
                                                    itemBuilder: (context, index) {
                                                      //getRouteBySchoolID(listRoutes![index].bus.num_plate,listRoutes![index].school.school_ID);
                                                      return Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Text(listRoutes![index].school.school_name,
                                                            style: const TextStyle(
                                                              fontSize: 18,
                                                              fontWeight: FontWeight.w500)),
                                                          const SizedBox(
                                                            height: 10,
                                                          ),
                                                          /*ListView.builder(
                                                            itemCount: listRoutesBySchool!.length,
                                                            itemBuilder: (context, index) {
                                                              return Text(listRoutesBySchool![index].school.school_name);
                                                            }
                                                          ),*/
                                                      InkWell(
                                                        child: Text('ถึงเวลาประมาณ : '+f.format(listRoutes![index].stop_time!)+' น.',
                                                          style: const TextStyle(
                                                              fontSize: 16,
                                                              fontWeight: FontWeight.w500),
                                                        ),

                                                      ),

                                                        ],
                                                      );
                                                    }, separatorBuilder: (BuildContext context, int index) => const Divider(),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Firstname != ''
                                              ?listRoutes![0].bus.status_bus != 2
                                                ?listRoutes![0].bus.seats_amount ==  int.parse(l![0])
                                            ?Padding(
                                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                                              child: ElevatedButton(
                                                onPressed: () {
                                                  alertDialogApp.showAlertDialog(context, 'รถคันนี้เต็มแล้ว');
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  padding: const EdgeInsets.fromLTRB(35, 15, 35, 15),
                                                  primary:  Color(0xffed4145),
                                                ),
                                                child: const Text(
                                                  'ร้องขอขึ้นรถรับส่ง',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            )
                                            :Padding(
                                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                                              child: ElevatedButton(
                                                onPressed: () {
                                                  removeValue();
                                                  Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                          builder: (context) => const ApplySchoolBusPage()));
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  padding: const EdgeInsets.fromLTRB(35, 15, 35, 15),
                                                  primary:  Color(0xffa3d064),
                                                ),
                                                child: const Text(
                                                  'ร้องขอขึ้นรถรับส่ง',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            )
                                            :const Align(
                                              alignment: Alignment.center,
                                              child: Text(
                                                  'พักให้บริการ',
                                                  style: TextStyle(
                                                    color: Colors.deepOrange,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18,
                                                  )
                                              )
                                            ):const SizedBox(height: 10,),

                                            SizedBox(height: 20,)
                                          ],
                                        ),

                                ),
                    ),
                  ),
                ),
        )

    );
  }

  void removeValue(){
    getSharedPreferences.removeLatitude();
    getSharedPreferences.removeLongitude();
    getSharedPreferences.removeAddress();
  }

  String CalAge(DateTime date){
    DateTime purchase_date = DateTime(date.year, date.month, date.day);
    DateDuration duration;
    duration = AgeCalculator.age(purchase_date);
    return duration.years.toString();
  }


}