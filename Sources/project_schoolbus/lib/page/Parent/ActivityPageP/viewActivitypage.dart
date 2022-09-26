import 'package:intl/intl.dart';
import 'package:project_schoolbus/model/ActivityModel.dart';
import 'package:project_schoolbus/mapUnits.dart';
import '../../../importer.dart';
import '../../../manager/ActivityManager.dart';
import '../../../manager/ContractManager.dart';
import '../../../model/ContractModel.dart';

class viewActivitypage extends StatefulWidget {
  const viewActivitypage({Key? key}) : super(key: key);

  @override
  State<viewActivitypage> createState() => _viewActivityState();
}
class _viewActivityState extends State<viewActivitypage> {
  final f = DateFormat('yyyy-MM-dd');

  @override
  void initState() {
    getContractDetails();
    getActivityByID();
    super.initState();
  }
  List<Activity>? listActivity;
  bool isLoading = true;
  Contract? contract;
  String contrac_ID = getSharedPreferences.getContractID() ?? '';
  ContractManager manager = ContractManager();

  void getContractDetails() {
    manager.getContractDetails(contrac_ID).then((value) async => {
      // await getSharedPreferences.setSchoolID(contract!.routes.school.school_ID),
      setState(() {
        contract = value;
        isLoading = false;
      }),
    });
  }
  ActivityManager amanager = ActivityManager();
  void getActivityByID() {
    amanager.getlistActivityById(contrac_ID).then((value) async => {
      // await getSharedPreferences.setSchoolID(contract!.routes.school.school_ID),
      setState(() {
        listActivity = value;
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
          title: const Text("กิจกรรมขึ้นรถ - ลงรถ"),
          toolbarHeight: 60,
          shape: const RoundedRectangleBorder()),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children:  [
              apppbar(),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child:  Text('รายการกิจกรรม :',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800),),
                ),
              ),
              (listActivity == null) ? const Text("ไม่มีกิจกรรมขึ้นรถ - ลงรถ" ,
                  style: TextStyle(
                      color: Colors.deepOrange,
                  fontSize: 20,
                  fontWeight: FontWeight.w800),) : buildListActivity(),
            ],
          ),
        ),
      ),
    );


  }

  Widget buildListActivity(){
    return Container(
        child: ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: listActivity!.length,
            itemBuilder: (context, index){
              return SizedBox(
                width:  MediaQuery.of(context).size.width*1,
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              listActivity![index].get_up_time.split(" ")[0],
                              style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600),
                            ),
                            SizedBox(width: 10.0,),
                            Text(
                              listActivity![index].time_of_date == 1 ? "ช่วงเช้า":"ช่วงเย็น",
                              style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                        SizedBox(width: 15.0,),
                        listActivity![index].status_children ==  "ไม่ขึ้นรถ"?
                            Column(
                              children:  [
                                const Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    "ไม่ขึ้นรถ",
                                    style: TextStyle(
                                        color: Colors.deepOrange,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600
                                    ),
                                  ),
                                ),
                                Text(
                                  "เนื่องจาก : "+listActivity![index].reason,
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                  ),
                                ),
                              ],
                            )
                       :Column(
                          children: [
                            Row(
                              children: [
                                const Text(
                                  "ขึ้นเวลา",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600),
                                ),
                                SizedBox(width: 10.0,),
                                Text(
                                  listActivity![index].get_up_time.split(" ")[1],
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600),
                                ),
                                SizedBox(width: 20.0,),
                                const Text(
                                  "ที่",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600),
                                ),
                                SizedBox(width: 10.0,),
                                InkWell(
                                  child: Container(
                                      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                      child: const Text('ดูแผนที่',
                                          style: TextStyle(
                                            fontSize: 14,
                                          )
                                      ),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          border: Border.all(
                                              color: Colors.black,
                                              width: 1
                                          )
                                      )
                                  ),
                                  onTap: (){
                                    mapUnits.openMap(double.parse(listActivity![index].get_up_latitude),double.parse(listActivity![index].get_up_longitude));
                                  },
                                ),
                                SizedBox(width: 20.0,),

                              ],
                            ),
                            SizedBox(width: 10.0,),
                            listActivity![index].get_off_time.split(" ")[0] != "1900-01-01" ?
                            Row(
                              children: [
                                const Text(
                                  "ลงเวลา",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600),
                                ),
                                SizedBox(width: 10.0,),
                                Text(
                                  listActivity![index].get_off_time.split(" ")[1],
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600),
                                ),
                                SizedBox(width: 20.0,),
                                const Text(
                                  "ที่",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600),
                                ),
                                SizedBox(width: 10.0,),
                                InkWell(
                                  child: Container(
                                      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                      child: const Text('ดูแผนที่',
                                          style: TextStyle(
                                            fontSize: 14,
                                          )
                                      ),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          border: Border.all(
                                              color: Colors.black,
                                              width: 1
                                          )
                                      )
                                  ),
                                  onTap: (){
                                    mapUnits.openMap(double.parse(listActivity![index].get_off_latitude),double.parse(listActivity![index].get_off_longitude));
                                  },
                                ),
                                SizedBox(width: 20.0,),
                              ],
                            ): const Text(
                              "ไม่พบการลงรถของเด็ก กรูณาติดต่อคนขับ ",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600),
                            ),

                            SizedBox(width: 10.0,),
                            Row(
                               children: [
                                 const Text(
                                  "สถานะ : ",
                                   style: TextStyle(
                                       fontSize: 14,
                                       fontWeight: FontWeight.w600),
                                 ),
                                 Text(
                                   listActivity![index].status_children,
                                   style: const TextStyle(
                                       fontSize: 14,
                                       fontWeight: FontWeight.w600),
                                 ),
                               ],
                             )
                            ,SizedBox(width: 10.0,)
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              );
            }
        ),
    );
  }
  Widget apppbar(){
    return Container(
      child: Container(
        decoration:  BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: <Color>[
              Colors.amber,
              Colors.yellow
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 5,
              blurRadius: 5,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        margin: const EdgeInsets.only(),
        padding: const EdgeInsets.fromLTRB(40, 20, 20, 20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: Container (
                    height: 130,
                    width: 130,
                    decoration:  BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(contract!.children.image_profile),
                            fit: BoxFit.cover)
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'การขึ้นรถ-ลงรถ',
                      style:
                      const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Text(
                          contract!.children.firstname,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black.withOpacity(0.6),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          contract!.children.lastname,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black.withOpacity(0.6),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),

          ],
        ),

      ),
    );
  }

}