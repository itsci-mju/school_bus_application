import 'package:flutter/cupertino.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:project_schoolbus/manager/DriverManager.dart';
import 'package:project_schoolbus/page/MainPage/mainDriver.dart';

import '../../../importer.dart';
import '../HomePage/light_colors.dart';

class UpdateServicePage extends StatefulWidget {
  const UpdateServicePage({Key? key}) : super(key: key);

  @override
  State<UpdateServicePage> createState() => _UpdateServicePageState();
}

class _UpdateServicePageState extends State<UpdateServicePage> {
  bool status = true;
  bool statusbutton = false;
  String IDCard = getSharedPreferences.getIDCard() ?? '';
  Bus? b;
  bool isLoading = true;

  final _formKey = GlobalKey<FormState>();
  late final _ctrlReason = TextEditingController();

  @override
  void initState() {
    getStatus();
    super.initState();
  }
  DriverManager manager = DriverManager();
  void getStatus() {
    manager.getBusDetails(IDCard).then((value) => {
      b = value,
      _ctrlReason.text = b!.reason,
      setState(() {
        isLoading = false;
        if(b!.status_bus == 1){
          status = true;
        }else{
          status = false;
        }
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
        color:LightColors.kLightYellow,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0,vertical: 40.0),
          child: SingleChildScrollView(
            child: Container(
              color: Colors.white,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 5.0, color: const Color(
                      0xFFC9C7C9)),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0,vertical: 20.0),
                  child: SizedBox(
                    height: 450,
                    width: 350,
                    child: Column(
                      children: [
                        Center(
                          child: Row(
                            mainAxisAlignment : MainAxisAlignment.spaceBetween,
                            children: [
                               const Text('ยกเลิกการให้บริการ',style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w800),),
                              Container(
                                child: FlutterSwitch(
                                  activeColor : Colors.green,
                                  width: 75.0,
                                  height: 35.0,
                                  valueFontSize: 15.0,
                                  toggleSize: 25.0,
                                  value: status,
                                  borderRadius: 15.0,
                                  padding: 6.0,
                                  showOnOff: true,
                                  onToggle: (val) {
                                      CheckService(val);
                                  },
                                ),
                              ),
                            ],
                          ),
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
                                      return 'กนุณาใส่เหตุผล';
                                    }
                                    return null;
                                  },
                                  maxLines: 3,
                                  textAlign : TextAlign.start,
                                  decoration: InputDecoration(
                                    enabled :  status == true ? false : true,
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
                        Visibility(
                          child: Align(
                            alignment : Alignment.centerRight,
                            child: ElevatedButton(onPressed: () {
                              showDialog(context: context, builder: (context) => AlertDialog(
                                title: const Text("คุณต้องการบันทึกบริการนี้!"),
                                actions: [
                                  ElevatedButton(onPressed: () async {
                                    Navigator.pop(context);
                                    checkStatus();
                                  }, child: const Text("ยืนยัน")),
                                  ElevatedButton(onPressed: (){
                                    Navigator.pop(context);
                                  }, child: const Text("ยกเลิก"))
                                ],
                              ));
                            }, child: const Text("บันทึก")),
                          ),
                          visible: statusbutton,
                        ),
                        const SizedBox(height: 20,),
                        const Text(' * การยกเลิกการให้บริการ * \n\n       จะทำให้รถของคุณ ถูกลบออกไปจากรายการค้นหาของระบบ \n\n ** คำเตือน ** \n\n     กรณีที่คุณต้องการปิดการให้บริการคุณ ต้องแน่ใจก่อนว่าบนรถของคุณไม่มีนักเรียน ที่ใช้บริการของคุณแล้ว '),
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
  void CheckService(bool val){
    String num_plate = getSharedPreferences.getNum_plate() ?? '';
    String Children = "";

    if(val == true){
      _ctrlReason.clear();
      setState(() {
        b!.status_bus = 1;
        print(b!.status_bus);
        status = true;
        statusbutton = true;
      });
    }
    if(val == false){
      manager.calChildrensInCar(num_plate).then((value) => {
          Children = value,
          if(Children != "0"){
            setState(() {
              b!.status_bus = 1;
              print(b!.status_bus);
              status = true;
              statusbutton = false;
            }),
            showDialog(context: context, builder: (context) => AlertDialog(
              title: const Text("คุณมียังเด็กอยู่บนรถ!"),
              actions: [
                ElevatedButton(onPressed: () {
                  Navigator.pop(context);
                }, child: const Text("ยืนยัน")),
                ElevatedButton(onPressed: (){
                  Navigator.pop(context);
                }, child: const Text("ยกเลิก"))
              ],
            )),
          }else{
            setState(() {
              b!.status_bus = 2;
              print(b!.status_bus);
              status = false;
              statusbutton = true;
            }),
          }
      });
    }
  }

  void checkStatus() {
    if(status){
      try{
        b!.reason = "";
        updateService();
      }catch(error){
        print(error);
      }
    }else{
      if(_formKey.currentState!.validate()){
        try{
            b!.reason =  _ctrlReason.text;
            print(b!.reason);
            updateService();
        }catch(error){
          print(error);
        }
      }
    }
  }

  Future updateService() async{
    String result = await manager.updateService(b!);
    if(result != "0") {
      if(b!.status_bus == 1){
        AnimatedSnackBar.rectangle(
            'สำเร็จ',
            'คุณได้เริ่มบริการแล้ว',
            type: AnimatedSnackBarType.success,
            brightness: Brightness.light,
            duration : const Duration(seconds: 8)
        ).show(
          context,
        );
        Navigator.of(context).push(
            MaterialPageRoute(
                builder: (context) => const MainPageDriver()));
      }else{
        AnimatedSnackBar.rectangle(
            'สำเร็จ',
            'คุณได้ยกเลิกบริการแล้ว',
            type: AnimatedSnackBarType.success,
            brightness: Brightness.light,
            duration : const Duration(seconds: 8)
        ).show(
          context,
        );
        Navigator.of(context).push(
            MaterialPageRoute(
                builder: (context) => const MainPageDriver()));
      }
    }else{
      AnimatedSnackBar.rectangle(
          'เกิดข้อผิดพลาด',
          'คุณไม่สามารถเปลี่ยนการให้บริการของคุณได้',
          type: AnimatedSnackBarType.error,
          brightness: Brightness.light,
          duration : const Duration(seconds: 5)
      ).show(
        context,
      );
    }
  }




}