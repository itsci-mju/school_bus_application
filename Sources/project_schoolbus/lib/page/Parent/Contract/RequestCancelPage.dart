import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:project_schoolbus/manager/ContractManager.dart';
import 'package:project_schoolbus/model/RequestCancelModel.dart';
import 'package:project_schoolbus/page/MainPage/mainDriver.dart';

import '../../../importer.dart';
import '../../../model/ContractModel.dart';
import '../../Driver/HomePage/light_colors.dart';


class RequestCancelPage extends StatefulWidget {
  const RequestCancelPage({Key? key}) : super(key: key);

  @override
  State<RequestCancelPage> createState() => _RequestCancelState();
}

class _RequestCancelState extends State<RequestCancelPage> {
  DateTime now = DateTime.now();
  final f = DateFormat('yyyy-MM-dd');

  final _formKey = GlobalKey<FormState>();
  late final _ctrlReason = TextEditingController();

  @override
  void initState() {
    getContract();
    super.initState();
  }

  String contrac_ID = getSharedPreferences.getContractID() ?? '';
  String contract = getSharedPreferences.getContract() ?? '';
  ContractManager manager = ContractManager();
  Contract? c;
  void getContract(){
   /* Map<String, dynamic> map = jsonDecode(contract);
    c = Contract.fromJson(map);
    var log = Logger();
    log.e(c.toString());*/
    manager.getContractDetails(contrac_ID).then((value) async => {
      // await getSharedPreferences.setSchoolID(contract!.routes.school.school_ID),
      setState(() {
        c = value;
      }),
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ยกเลิกการให้บริการ",style: TextStyle(
            fontWeight: FontWeight.w800),),
        toolbarHeight: 60,
        shape: const RoundedRectangleBorder(
            borderRadius:  BorderRadius.only(
                bottomRight: Radius.circular(10),
                bottomLeft: Radius.circular(10))
        ),
        backgroundColor: LightColors.kDarkYellow,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height*1,
        color:LightColors.kLightYellow,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0,vertical: 40.0),
          child: SingleChildScrollView(
            child: Container(
              color: Colors.white,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 5.0, color: const Color(
                      0xFFC9C9C9)),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0,vertical: 20.0),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height*0.44,
                    width: 350,
                    child: Column(
                      children: [
                        Center(
                          child: Row(
                            mainAxisAlignment : MainAxisAlignment.spaceBetween,
                            children: const [
                              Text('ยกเลิกบริการ',style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold),),
                            ],
                          ),
                        ),
                        const SizedBox(height: 30,),
                        Row(
                          mainAxisAlignment : MainAxisAlignment.spaceAround,
                          children: [
                            const Text('วันที่ยกเลิกบริการ',style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w800),),
                            Text(f.format(now),style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w800),),
                          ],
                        ),
                        SizedBox(height: 20,),
                        Form(
                          key: _formKey,
                          child: Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: _ctrlReason,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter Reason';
                                    }
                                    return null;
                                  },
                                  maxLines: 3,
                                  textAlign : TextAlign.start,
                                  decoration: InputDecoration(
                                    labelText: 'กรุณาใส่เหตุผล',
                                    prefixIcon: const Icon(CupertinoIcons.info),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20,),
                        Row(
                          mainAxisAlignment : MainAxisAlignment.center,
                          children: [
                            Align(
                              alignment : Alignment.center,
                              child: ElevatedButton(onPressed: () {
                                showDialog(context: context, builder: (context) => AlertDialog(
                                  title: const Text("คุณต้องการร้องขอยกเลิกสัญญา ?"),
                                  actions: [
                                    ElevatedButton(onPressed: () {
                                      Navigator.pop(context);
                                      requestCancel();
                                    }, child: const Text("ยืนยัน")),
                                    ElevatedButton(onPressed: (){
                                      Navigator.pop(context);
                                    }, child: const Text("ยกเลิก"))
                                  ],
                                ));
                              }, child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text("บันทึก"),
                              )),
                            ),
                            const SizedBox(width: 15,),
                            Align(
                              alignment : Alignment.center,
                              child: ElevatedButton(onPressed: () {
                                Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (context) => const MyHomePage(indexScreen: null)));
                              }, child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text("ยกเลิก"),
                              )),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }


  Future requestCancel() async{
    if(_formKey.currentState!.validate()){
      try{
        RequestCancel requestCancel = RequestCancel("R", now, null, _ctrlReason.text, 1, c!);
        String result = await manager.requestCancel(requestCancel);
        if(result != "0") {
          AnimatedSnackBar.rectangle(
              'สำเร็จ',
              'คุณได้ร้องขอยกเลิกสัญญาแล้ว',
              type: AnimatedSnackBarType.success,
              brightness: Brightness.light,
              duration : const Duration(seconds: 8)
          ).show(
            context,
          );
          Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (context) => const MyHomePage(indexScreen: null)));
        }else{
          AnimatedSnackBar.rectangle(
              'เกิดข้อผิดพลาด',
              'กรุณาลองอีกครั้ง',
              type: AnimatedSnackBarType.error,
              brightness: Brightness.light,
              duration : const Duration(seconds: 5)
          ).show(
            context,
          );
        }
      }catch(error){
        print(error);
      }
    }

  }




}