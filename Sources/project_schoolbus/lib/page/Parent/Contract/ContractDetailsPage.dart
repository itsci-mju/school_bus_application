

import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:project_schoolbus/manager/ContractManager.dart';
import 'package:project_schoolbus/page/Parent/Contract/RequestCancelPage.dart';
import 'package:project_schoolbus/mapUnits.dart';
import '../../../importer.dart';
import '../../../model/ContractModel.dart';

class ContractDetailsPage extends StatefulWidget {
  const ContractDetailsPage({Key? key}) : super(key: key);

  @override
  State<ContractDetailsPage> createState() => _ContractDetailsState();
}

class _ContractDetailsState extends State<ContractDetailsPage> {
  final f = DateFormat('yyyy-MM-dd');

  @override
  void initState() {
    getContractDetails();
    super.initState();
  }

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

  @override
  Widget build(BuildContext context) {
    if(isLoading){
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return Scaffold(

      appBar: AppBar(
          title: const Text("รายละเอียดสัญญา"),
          toolbarHeight: 60,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(30),
                  bottomLeft: Radius.circular(30)))),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment : CrossAxisAlignment.start,
            children: [
              const Text(
                'รายละเอียดสัญญา',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: Row(
                  children: [
                    Text(
                      contract!.children.firstname,
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(width: 35.0,),
                    Text(
                      contract!.children.lastname,
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(width: 35.0,),
                     Text(CalAge(contract!.children.birthday),
                        style: const TextStyle(
                        fontSize: 20,
                      ),
                     ),
                  ],
                ),
              ),
              const SizedBox(height: 10.0,),
              Row(children: [
                const Text(
                  'เบอร์โทร ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                SizedBox(width: 10.0,),
                Text(
                  contract!.children.phone,
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                ),
              ],),
              Row(children: [
                const Text(
                  'โรงเรียน',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                SizedBox(width: 35.0,),
                Text(
                  contract!.routes.school.school_name,
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                ),
              ],),
              const SizedBox(height: 10.0,),
              Row(
                children: [
                  Text(
                    'จุดรับขึ้นรถ',
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(width: 10.0,),
                  InkWell(
                    child: Container(
                      padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                      child: Text('ดูแผนที่',
                          style: const TextStyle(
                        fontSize: 20,
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
                      mapUnits.openMap(double.parse( contract!.pick_up_latitude),double.parse(contract!.pick_up_longitude));

                    },
                  ),
                ],
              ),
              const SizedBox(height: 10.0,),
              Column(
                children: [
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment : CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'วันที่ทำสัญญา',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          Text(
                            f.format(contract!.contract_date),
                            style: const TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(width: 60.0,),
                      Column(
                        crossAxisAlignment : CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'วันที่อนุมัติ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          Text(contract!.approve_date == null ? 'ยังไม่ได้อนุมัติ': f.format(contract!.approve_date!),
                            style: const TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),

                    ],
                  ),

                ],
              ),
              const SizedBox(height: 10.0,),
              Column(
                children: [
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment : CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'วันที่เริ่มให้บริการ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          Text(
                            f.format(contract!.start_date),
                            style: const TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 35.0,),
                      Column(
                        crossAxisAlignment : CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'วันที่สิ้นสุดสัญญา',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          Text(
                            f.format(contract!.end_date),
                            style: const TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 10.0,),
              const Text(
                'รายละเอียดรถรับส่ง',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 10.0,),
              Row(
                children: [
                  Column(
                    crossAxisAlignment : CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'ทะเบียนรถ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                      ),
                      Text(
                        contract!.routes.bus.num_plate+" "+contract!.routes.bus.province,
                        style: const TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 10.0,),
              Row(
                crossAxisAlignment : CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment : CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'ยี่ห้อ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                      ),
                      Text(
                        contract!.routes.bus.brand,
                        style: const TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 20.0,),
                  Column(
                    children: [
                      const Text(
                        'อายุการใช้งาน',
                        style: TextStyle(
                          fontSize: 17,
                        ),
                      ),
                      Text(
                        f.format(contract!.routes.bus.purchase_date),
                        style: const TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 10.0,),
              const Text(
                'รายละเอียดคนขับรถรับส่ง',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 10.0,),
              Row(
                children: [
                  Column(
                    crossAxisAlignment : CrossAxisAlignment.start,
                    children: [
                      Text(
                        contract!.routes.bus.driver.firstname+" "+contract!.routes.bus.driver.lastname,
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 10.0,),
                      Row(
                        children: [
                          Text(
                            CalAge(contract!.routes.bus.driver.birthday),
                            style: const TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(width: 20.0,),
                          Text(
                            "เบอร์โทร : "+contract!.routes.bus.driver.phone,
                            style: const TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              contract!.status == 2 ?
              Center(
                child: ElevatedButton(
                  onPressed: (){
                    Navigator.push(context, PageTransition(type: PageTransitionType.rightToLeft, duration : const Duration(milliseconds: 150),reverseDuration : const Duration(milliseconds: 150),
                        child: const RequestCancelPage()));
                  }, child: Text('ส่งคำขอยกเลิกสัญญา'),
                ),
              ) :const SizedBox(height: 10.0,),
            ],
          ),

        ),
      ),
    );
  }

  void saveContract() async{
    await getSharedPreferences.setContract(jsonEncode(contract!.toMap()));
  }

  String CalAge(DateTime date){
    DateTime purchaseDate = DateTime(date.year, date.month, date.day);
    DateDuration duration;
    duration = AgeCalculator.age(purchaseDate);
    return "อายุ : "+duration.years.toString()+" ปี";
  }

}
