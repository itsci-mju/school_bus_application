import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:project_schoolbus/manager/ContractManager.dart';
import 'package:project_schoolbus/model/RequestCancelModel.dart';
import 'package:project_schoolbus/page/Parent/Contract/RequestCancelPage.dart';

import '../../../ShowMarker.dart';
import '../../../importer.dart';
import '../../../model/ContractModel.dart';
import '../HomePage/light_colors.dart';
import 'package:project_schoolbus/mapUnits.dart';

class Driver_ChildrenProfilePage extends StatefulWidget {
  const Driver_ChildrenProfilePage({Key? key}) : super(key: key);

  @override
  State<Driver_ChildrenProfilePage> createState() =>
      _ChildrenDetailsPageState();
}

class _ChildrenDetailsPageState extends State<Driver_ChildrenProfilePage> {
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
    manager.getContractDetails(contrac_ID).then((value) => {
          setState(() {
            contract = value;
            isLoading = false;
          }),
        });
  }
  int selectedTabIndex = 0;
   List<Widget>? widgets;
  @override
  Widget build(BuildContext context) {
    DateTime dateTime ;
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }else{
       dateTime = contract!.children.birthday;
       widgets = [ShowMarker(latitude: double.parse(contract!.pick_up_latitude) ,longitude: double.parse(contract!.pick_up_longitude),title: 'จุดรับของ '+ contract!.children.firstname +" "+contract!.children.lastname,)];
    }
    return Scaffold(
      backgroundColor: LightColors.kLightYellow2,
      appBar: AppBar(

          title: const Text("รายละเอียดสัญญาเด็ก"),
          toolbarHeight: 60,
          shape: const RoundedRectangleBorder()),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 30, 10, 0),

        child: SingleChildScrollView(

            child: SizedBox(
          height: MediaQuery.of(context).size.width * 1.80,
          width: MediaQuery.of(context).size.width * 2,
          child: Card(
            child: Padding(
              padding: EdgeInsets.fromLTRB(20, 10, 10, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'รายละเอียดเด็ก',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Image.network(
                    contract!.children.image_profile,
                    width: 150,
                    alignment: Alignment.center,
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    contract!.children.firstname +
                        "   " +
                        contract!.children.lastname,
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    CalAge(dateTime),
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  const Text(
                    'โรงเรียน',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    contract!.routes.school.school_name,
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Column(
                    children: [
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                          const SizedBox(
                            width: 60.0,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'วันที่อนุมัติ',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              Text(
                                contract!.approve_date == null
                                    ? 'ยังไม่ได้อนุมัติ'
                                    : f.format(contract!.approve_date!),
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
                  const SizedBox(
                    height: 10.0,
                  ),
                  Column(
                    children: [
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                          const SizedBox(
                            width: 35.0,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                  const SizedBox(
                    height: 10.0,
                  ),
                  const Text(
                    'รายละเอียดผู้ปกครอง',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'ผู้ปกครอง :',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                            ),
                          ),
                          Text(
                            contract!.children.parent.firstname +
                                " " +
                                contract!.children.parent.lastname,
                            style: const TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 40.0,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'เบอร์โทร :',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                            ),
                          ),
                          Text(
                            contract!.children.parent.phone,
                            style: const TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    children: [
                      const Align(
                        child: Text(
                          'จุดรับขึ้นรถ :',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                          ),
                        ),
                        alignment: Alignment.topLeft,
                      ),
                      Align(
                        child: InkWell(
                          child: Text(' ดูแมพ' ,style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                          ),),
                          onTap: ()  {
                            mapUnits.openMap(double.parse( contract!.pick_up_latitude),double.parse(contract!.pick_up_longitude));
                          },
                        ),
                      )
                    ],
                  )
                 ,
                  const SizedBox(
                    height: 10.0,
                  ),
                   Text(
                     contract!.children.parent.address,
                    style: TextStyle(
                      fontSize: 17,
                    ),
                  ),
                ],
              ),
            ),
          ),
        )),
      ),
    );
  }

  void saveContract() async {
    await getSharedPreferences.setContract(jsonEncode(contract!.toMap()));
  }

  String CalAge(DateTime date) {
    DateTime purchaseDate = DateTime(date.year, date.month, date.day);
    DateDuration duration;
    duration = AgeCalculator.age(purchaseDate);
    return "อายุ : " + duration.years.toString() + " ปี";
  }
}
