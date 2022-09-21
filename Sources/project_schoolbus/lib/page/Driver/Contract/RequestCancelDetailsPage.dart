import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:project_schoolbus/manager/ContractManager.dart';
import 'package:project_schoolbus/model/RequestCancelModel.dart';
import 'package:project_schoolbus/page/Parent/Contract/RequestCancelPage.dart';

import '../../../importer.dart';
import '../../../model/ContractModel.dart';

class RequestCancelDetailsPage extends StatefulWidget {
  const RequestCancelDetailsPage({Key? key}) : super(key: key);

  @override
  State<RequestCancelDetailsPage> createState() => _RequestCancelDetailsState();
}

class _RequestCancelDetailsState extends State<RequestCancelDetailsPage> {
  final f = DateFormat('yyyy-MM-dd');

  @override
  void initState() {
    getContractDetails();
    super.initState();
  }

  bool isLoading = true;
  RequestCancel? request;
  String request_ID = getSharedPreferences.getRequestID() ?? '';
  ContractManager manager = ContractManager();
  void getContractDetails() {
    manager.driver_getrequestCancel(request_ID).then((value) => {
      setState(() {
        request = value;
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
          title: const Text("RequestCancelDetails Page"),
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
                'รายละเอียดขอยกเลิกสัญญา',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: Row(
                  children: [
                    Text(
                      request!.contract.children.firstname,
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(width: 35.0,),
                    Text(
                      request!.contract.children.lastname,
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10.0,),
              const Text(
                'โรงเรียน',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 10.0,),
              Text(
                request!.contract.routes.school.school_name,
                style: const TextStyle(
                  fontSize: 20,
                ),
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
                            f.format(request!.contract.contract_date),
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
                          Text(request!.contract.approve_date == null ? 'ยังไม่ได้อนุมัติ': f.format(request!.contract.approve_date!),
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
                            f.format(request!.contract.start_date),
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
                            f.format(request!.contract.end_date),
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
                crossAxisAlignment : CrossAxisAlignment.start,
                children: [
                  const Text(
                    'เหตุผล',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    request!.reason,
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20.0,),
              Row(
                children: [
                  ElevatedButton(
                      onPressed: (){
                        saveContract();
                        Navigator.push(context, PageTransition(type: PageTransitionType.rightToLeft, duration : const Duration(milliseconds: 150),reverseDuration : const Duration(milliseconds: 150),
                            child: const RequestCancelPage()));
                      },
                      child: Text('อนุมัติ')
                  ),
                  ElevatedButton(
                      onPressed: (){},
                      child: Text('ย้อนกลับ')
                  ) ,
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }

  void saveContract() async{
    await getSharedPreferences.setContract(jsonEncode(request!.contract.toMap()));
  }

  String CalAge(DateTime date){
    DateTime purchaseDate = DateTime(date.year, date.month, date.day);
    DateDuration duration;
    duration = AgeCalculator.age(purchaseDate);
    return "อายุ : "+duration.years.toString()+" ปี";
  }

}
