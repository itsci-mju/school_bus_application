
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:project_schoolbus/importer.dart';

import '../../../LineNotify.dart';
import '../../../manager/ContractManager.dart';
import '../../../model/ContractModel.dart';
import '../../AlertDialog.dart';
import '../../LoginPage/Linenoti.dart';
import '../../Parent/Contract/ContractDetailsPage.dart';

class ListApplication extends StatefulWidget {
  const ListApplication({Key? key}) : super(key: key);

  @override
  State<ListApplication> createState() => _ListApplicationState();
}

class _ListApplicationState extends State<ListApplication> {
  final f = DateFormat('yyyy-MM-dd');
  DateTime now = DateTime.now();
  ContractManager manager = ContractManager();
  String num_plate = getSharedPreferences.getNum_plate() ?? '';
  RouteManager rmanager = RouteManager();
  List<Contract>? listcontract;
  String? result;
  bool isLoading = true;
  List? l;
  AlertDialogApp alertDialogApp =AlertDialogApp();
  late final Linenoti? linenoti = new Linenoti() ;
  @override
  void initState() {
    refreshContract();
    getCalDetails();
    super.initState();
  }

  void refreshContract() {
    setState(() {
      isLoading = true;
    });
    manager.driver_getListUnApproved(num_plate).then((value) => {
      setState(() {
        listcontract = value;
        isLoading = false;
      }),
    });
  }
  void getCalDetails() async{
    setState(() {
      isLoading = true;
    });
    rmanager.getCalDetails(num_plate).then((value) => {
      l = value,
      setState(() {
        isLoading = false;
      })
    });
  }
  @override
  Widget build(BuildContext context)  {
    if(isLoading){
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(8.0),
      child: (listcontract == null || listcontract!.isEmpty) ? const Text("ไม่มีรายการสัญญา") : buildListContract(),
    );
  }

  Widget buildListContract() {
    return Align(
        alignment: Alignment.topCenter,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment : CrossAxisAlignment.start,
          children: [
            Row(
              children: const [
                SizedBox(width: 5,),
                Icon(
                  CupertinoIcons.list_bullet,
                  size: 30.0,
                ),
                SizedBox(width: 10,),
                Text('รายการสัญญา :',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800),),
              ],
            ),
            const SizedBox(height: 5,),
            Align(
              alignment: Alignment.topCenter,
              child: SingleChildScrollView(
                child:  ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: listcontract!.length,
                  itemBuilder: (context, index) {
                    //ProjectModel project = projectSnap.data![index];
                    return SizedBox(
                      height: MediaQuery.of(context).size.height*0.35,
                      width:  MediaQuery.of(context).size.width*1,
                      child: InkWell(
                        onTap: (){
                          setContractID(listcontract![index].contract_ID);
                          Navigator.push(context, PageTransition(type: PageTransitionType.rightToLeft, duration : const Duration(milliseconds: 150),reverseDuration : const Duration(milliseconds: 150),
                              child: const ContractDetailsPage()));
                        },
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                                      child: Image.network(
                                        listcontract![index].children.image_profile,
                                        width: 120.0,
                                        height: 120.0,
                                        fit: BoxFit.cover,
                                      ),

                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Wrap(
                                            spacing: 40,
                                            children: [
                                              Column(
                                                crossAxisAlignment : CrossAxisAlignment.start,
                                                mainAxisAlignment : MainAxisAlignment.spaceEvenly,
                                                children: [
                                                  const Text(
                                                    'ชื่อ',
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight: FontWeight.w500),
                                                  ),
                                                  const SizedBox(height: 5.0,),
                                                  Text(
                                                    listcontract![index].children.firstname,
                                                    style: const TextStyle(
                                                        fontSize: 15,
                                                        fontWeight: FontWeight.w800),
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                crossAxisAlignment : CrossAxisAlignment.start,
                                                mainAxisAlignment : MainAxisAlignment.spaceAround,
                                                children: [
                                                  const Text(
                                                    'นามสกุล ',
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight: FontWeight.w500),
                                                  ),
                                                  const SizedBox(height: 5.0,),
                                                  Text(
                                                    listcontract![index].children.lastname,
                                                    style: const TextStyle(
                                                        fontSize: 15,
                                                        fontWeight: FontWeight.w800),
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                crossAxisAlignment : CrossAxisAlignment.start,
                                                mainAxisAlignment : MainAxisAlignment.spaceEvenly,
                                                children: [
                                                  const Text(
                                                    'อายุ',
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight: FontWeight.w500),
                                                  ),
                                                  const SizedBox(height: 6.0,),
                                                  Text(
                                                    CalAge(listcontract![index].children.birthday),
                                                    style: const TextStyle(
                                                        fontSize: 15,
                                                        fontWeight: FontWeight.w800),
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                crossAxisAlignment : CrossAxisAlignment.start,
                                                mainAxisAlignment : MainAxisAlignment.spaceEvenly,
                                                children: [
                                                  const Text(
                                                    'เบอร์โทร',
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight: FontWeight.w500),
                                                  ),
                                                  const SizedBox(height: 6.0,),
                                                  Text(
                                                    listcontract![index].children.phone,
                                                    style: const TextStyle(
                                                        fontSize: 15,
                                                        fontWeight: FontWeight.w800),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Column(
                                            crossAxisAlignment : CrossAxisAlignment.start,
                                            mainAxisAlignment : MainAxisAlignment.spaceEvenly,
                                            children: [
                                              const Text(
                                                'โรงเรียน',
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w500),
                                              ),
                                              const SizedBox(height: 5.0,),
                                              Text(
                                                listcontract![index].busStop.school.school_name,
                                                style: const TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w800),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            children: [
                                              const Text(
                                                'วันที่เริ่มรับ : ',
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w500),
                                              ),
                                              SizedBox(width: MediaQuery.of(context).size.width*0.1,),
                                              Text(
                                                f.format(listcontract![index].start_date),
                                                style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w800),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Align(
                                            alignment: Alignment.centerRight,
                                            child: Row(
                                              mainAxisAlignment : MainAxisAlignment.end,
                                              children: [
                                                ElevatedButton(
                                                  style: ElevatedButton.styleFrom(
                                                      primary: Color(0xffa3d064)
                                                  ),
                                                  onPressed: (){
                                                    showDialog(context: context, builder: (context) => AlertDialog(
                                                      title: const Text("คุณต้องการอนุมัติสัญญานี้ ?"),
                                                      actions: [
                                                        ElevatedButton(onPressed: () {
                                                          if( listcontract![index].busStop.bus.seats_amount !=  int.parse(l![0])){
                                                            doApproveApplication(listcontract![index].contract_ID,now,listcontract![index].busStop.bus.driver.firstname+" "+listcontract![index].busStop.bus.driver.lastname);
                                                            Navigator.pop(context);
                                                          }else{
                                                            Navigator.pop(context);
                                                            alertDialogApp.showAlertDialog(context, 'ไม่สามารถอนุมัติได้เนื่องจากที่นั่งเต็ม');
                                                          }

                                                        }, child: const Text("ยืนยัน")),
                                                        ElevatedButton(onPressed: (){
                                                          Navigator.pop(context);
                                                        }, child: const Text("ยกเลิก"))
                                                      ],
                                                    ));
                                                  },
                                                  child: const Padding(
                                                    padding: EdgeInsets.fromLTRB(18, 8, 18, 8),
                                                    child: Text(
                                                      'อนุมัติ',
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(width: 10.0,),
                                                ElevatedButton(
                                                  style: ElevatedButton.styleFrom(
                                                      primary: Color(0xffed4145)
                                                  ),
                                                  onPressed: (){
                                                    showDialog(context: context, builder: (context) => AlertDialog(
                                                      title: const Text("คุณไม่อนุมัติสัญญานี้ ?"),
                                                      actions: [
                                                        ElevatedButton(onPressed: () {
                                                          setContractID(listcontract![index].contract_ID);
                                                          doUnApproveApplication(listcontract![index].contract_ID,now,listcontract![index].busStop.bus.driver.firstname+" "+listcontract![index].busStop.bus.driver.lastname);
                                                          Navigator.pop(context);

                                                        }, child: const Text("ยืนยัน")),
                                                        ElevatedButton(onPressed: (){
                                                          Navigator.pop(context);
                                                        }, child: const Text("ยกเลิก"))
                                                      ],
                                                    ));
                                                  },
                                                  child: const Padding(
                                                    padding: EdgeInsets.all(8.0),
                                                    child: Text(
                                                      'ไม่อนุมัติ',
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),

                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              )
              ,
            )
          ],
        ),
      ),
    )
       ;

  }

  void doApproveApplication(String contract_ID,DateTime approve_date,String name) async{
    String datenow = f.format(approve_date);
    String result = await manager.driver_ApproveApplication(contract_ID,datenow);
    if(result != "0") {
      refreshContract();
      getCalDetails();
       linenoti!.send(message: name+' ได้ตอบรับคำร้องขอขึ้นรถของคุณแล้ว');

      AnimatedSnackBar.rectangle(
          'สำเร็จ',
          'คุณได้อนุมัติการร้องขอสำเร็จ',
          type: AnimatedSnackBarType.success,
          brightness: Brightness.light,
          duration: const Duration(seconds: 5)
      ).show(
        context,
      );
    }else{
      AnimatedSnackBar.rectangle(
          'เกิดข้อผิดพลาด',
          'กรุณาลองใหม่อีกครั้ง',
          type: AnimatedSnackBarType.error,
          brightness: Brightness.light,
          duration : const Duration(seconds: 5)
      ).show(
        context,
      );
    }
  }

  void setContractID(String contract_ID) async{
    await getSharedPreferences.setContractID(contract_ID);
  }
  void doUnApproveApplication(String contract_ID,DateTime approve_date,String name) async{
    String datenow = f.format(approve_date);
    String result = await manager.driver_UnApproveApplication(contract_ID,datenow);
    if(result != "0") {
      refreshContract();
      getCalDetails();
      linenoti!.send(message: name+' ไม่อนุมัติคำร้องขอขึ้นรถของคุณ');

      AnimatedSnackBar.rectangle(
          'สำเร็จ',
          'คุณได้ไม่อนุมัติการร้องขอสำเร็จ',
          type: AnimatedSnackBarType.success,
          brightness: Brightness.light,
          duration: const Duration(seconds: 5)
      ).show(
        context,
      );
    }else{
      AnimatedSnackBar.rectangle(
          'เกิดข้อผิดพลาด',
          'กรุณาลองใหม่อีกครั้ง',
          type: AnimatedSnackBarType.error,
          brightness: Brightness.light,
          duration : const Duration(seconds: 5)
      ).show(
        context,
      );
    }
  }
  String CalAge(DateTime date){
    DateTime purchase_date = DateTime(date.year, date.month, date.day);
    DateDuration duration;
    duration = AgeCalculator.age(purchase_date);
    return duration.years.toString();
  }
}
