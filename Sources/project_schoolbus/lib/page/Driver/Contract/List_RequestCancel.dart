
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:project_schoolbus/importer.dart';
import 'package:project_schoolbus/page/Driver/Contract/RequestCancelDetailsPage.dart';

import '../../../LineNotify.dart';
import '../../../manager/ContractManager.dart';
import '../../../model/ContractModel.dart';
import '../../../model/RequestCancelModel.dart';
import '../../LoginPage/Linenoti.dart';
import '../../Parent/Contract/ContractDetailsPage.dart';

class ListRequestCancel extends StatefulWidget {
  const ListRequestCancel({Key? key}) : super(key: key);

  @override
  State<ListRequestCancel> createState() => _ListRequestCancelState();
}

class _ListRequestCancelState extends State<ListRequestCancel> {
  final f = DateFormat('yyyy-MM-dd');
  ContractManager manager = ContractManager();
  String num_plate = getSharedPreferences.getNum_plate() ?? '';
  List<RequestCancel>? listRequest;
  String? result;
  bool isLoading = true;
  late final Linenoti? linenoti = new Linenoti() ;
  @override
  void initState() {
    refreshRequestCancel();
    super.initState();
  }

  void refreshRequestCancel() {
    setState(() {
      isLoading = true;
    });
    manager.driver_requestCancel(num_plate).then((value) => {
      setState(() {
        listRequest = value;
        isLoading = false;
      }),
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
      child: (listRequest == null || listRequest!.isEmpty) ? const Text("ไม่มีรายการขอยกเลิก") : buildListContract(),
    );
  }

  Widget buildListContract() {
    return Align(
      alignment: Alignment.topCenter,
      child:  SingleChildScrollView(
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
                  Text('รายการขอยกเลิกสัญญา :',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800),),
                ],
              ),
              SizedBox(height: 5,),
              Align(
                alignment: Alignment.topCenter,
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: listRequest!.length,
                  itemBuilder: (context, index) {
                    //ProjectModel project = projectSnap.data![index];
                    return SizedBox(
                      height: MediaQuery.of(context).size.height*0.35,
                      width:  MediaQuery.of(context).size.width*1,
                      child: InkWell(
                        onTap: (){
                          setRequestID(listRequest![index].request_ID);
                          Navigator.push(context, PageTransition(type: PageTransitionType.rightToLeft, duration : const Duration(milliseconds: 150),reverseDuration : const Duration(milliseconds: 150),
                              child: const RequestCancelDetailsPage()));
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
                                        listRequest![index].contract.children.image_profile,
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
                                                    listRequest![index].contract.children.firstname,
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
                                                    'นามสกุล',
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight: FontWeight.w500),
                                                  ),
                                                  const SizedBox(height: 5.0,),
                                                  Text(
                                                    listRequest![index].contract.children.lastname,
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
                                                    CalAge(listRequest![index].contract.children.birthday),
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
                                                listRequest![index].contract.busStop.school.school_name,
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
                                                'เหลือสัญญา : ',
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w500),
                                              ),
                                              SizedBox(width: MediaQuery.of(context).size.width*0.02,),
                                              Text(
                                                CalExpire(listRequest![index].request_date,listRequest![index].contract.end_date),
                                                style: const TextStyle(
                                                    fontSize: 15,
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
                                                          doApprove(listRequest![index].contract.contract_ID,listRequest![index].contract.busStop.bus.driver.firstname+" "+listRequest![index].contract.busStop.bus.driver.lastname);
                                                          refreshRequestCancel();
                                                          Navigator.pop(context);

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
                                                          setRequestID(listRequest![index].request_ID);
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
              ),
            ],
          )
      ),
    )
     ;
  }

  void setRequestID(String request_ID) async{
    await getSharedPreferences.setRequestID(request_ID);
  }

  String CalAge(DateTime date){
    DateTime purchase_date = DateTime(date.year, date.month, date.day);
    DateDuration duration;
    duration = AgeCalculator.age(purchase_date);
    return duration.years.toString();
  }

  String CalExpire(DateTime start,DateTime end){
    DateDuration duration;
    duration = AgeCalculator.dateDifference(
      fromDate: start,
      toDate: end,
    );
    if(duration.years != 0){
      return '${duration.years} ปี ${duration.months} เดือน ${duration.days} วัน';
    }else if(duration.months != 0 && duration.years == 0){
      return "${duration.months} เดือน ${duration.days} วัน";
    }else if(duration.days != 0 && duration.months == 0 && duration.years == 0){
      return "${duration.days} วัน";
    }
    return duration.toString();
  }

  void doApprove(String contract_ID,String name) async{
    String result = await manager.approveRequestCancel(contract_ID);
    if(result != "0") {
      refreshRequestCancel();
      linenoti!.send(message: name+' ได้ตอบรับคำร้องขอการยกเลิกของคุณแล้ว');
      AnimatedSnackBar.rectangle(
          'สำเร็จ',
          'คุณได้อนุมัติการร้องขอยกเลิกสำเร็จ',
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

}
