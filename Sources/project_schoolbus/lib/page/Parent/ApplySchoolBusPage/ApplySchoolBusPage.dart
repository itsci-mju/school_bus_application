import 'dart:ffi';

import 'package:intl/intl.dart';
import 'package:project_schoolbus/manager/ContractManager.dart';
import 'package:project_schoolbus/page/MainPage/mainDriver.dart';
import '../../../importer.dart';
import '../../../model/ContractModel.dart';
import 'BottonWidget.dart';
import 'ShowMap.dart';


class ApplySchoolBusPage extends StatefulWidget {
  const ApplySchoolBusPage({Key? key}) : super(key: key);

  @override
  State<ApplySchoolBusPage> createState() => _ApplySchoolBusState();
}

class _ApplySchoolBusState extends State<ApplySchoolBusPage> {
  var log = Logger();

  RouteManager manager = RouteManager();
  String num_plate = getSharedPreferences.getNum_plate() ?? '';
  TextEditingController Address = TextEditingController();
  String? latitude = getSharedPreferences.getLatitude() ?? '';
  String? longitude = getSharedPreferences.getLongitude() ?? '';
  String? address = getSharedPreferences.getAddress() ?? '';

  bool isLoading = true;

  DateTimeRange? dateRange;

  List<Routes>? listRoutes;
  List<String>? DropdownSchools = [];
  String? selectedSchoolValue;

  @override
  void initState() {
    getSchoolBusDetails();
    getChildrens();
    if(address != null){
      Address.text = address.toString();
    }
    super.initState();
  }

  void getSchoolBusDetails() async{
    setState(() {
      isLoading = true;
    });
    manager.getSchoolBusDetails(num_plate).then((value) => {
      listRoutes = value,
      for(int i = 0 ; i < listRoutes!.length; i++){
        DropdownSchools!.add((i+1).toString()+" : "+listRoutes![i].school.school_name)
      },
      setState(() {
        isLoading = false;
      })
    });
  }

  List<Children>? listChildrens = [];
  List<String>? DropdownChildrens = [];
  String? selectedChildrenValue;

  ChildrenManager managerChildren = ChildrenManager();
  String IDCard = getSharedPreferences.getIDCard() ?? '';


  void getChildrens() {
    setState(() {
      isLoading = true;
    });
    managerChildren.listChildrenApply(IDCard).then((value) => {
      listChildrens = value ,
      for(int i = 0 ; i < listChildrens!.length; i++){
        DropdownChildrens!.add((i+1).toString()+" : "+listChildrens![i].firstname+" "+listChildrens![i].lastname)
      },
      setState(() {
        isLoading = false;
      })
    });
  }

  List<Routes>? listRoutesBySchoolName = [];
  List<String>? DropdownRoutes = [];
  String? selectedRouteValue;

  void getRoutesBySchoolName(String schoolvalue) {
    var log = Logger();
    setState(() {
      isLoading = true;
    });
    List<String> s = schoolvalue.split(" : ");
    manager.getRouteBySchoolName(num_plate,s[1]).then((value) => {
      listRoutesBySchoolName = value ,
      DropdownRoutes!.clear(),
      for(int i = 0 ; i < listRoutesBySchoolName!.length; i++){
        DropdownRoutes!.add((i+1).toString()+" : "+listRoutesBySchoolName![i].route_details)
      },
      setState(() {
        isLoading = false;
        log.e("ddddddddddddddddd : "+DropdownRoutes.toString());
      })
    });
  }


  @override
  Widget build(BuildContext context) {
    if(isLoading){
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return listRoutes == null ? const CircularProgressIndicator() :  Scaffold(
      appBar: AppBar(title: const Text('ทำสัญญารถรับส่ง'), backgroundColor:  Colors.amber,
      ),
      body:  Container(
        decoration: const BoxDecoration(
          color: Color(0xffcfd2d1),
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
                                child: Image.network(
                                  listRoutes![0].bus.driver.image_profile,
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
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(25, 0, 25, 20),
                      child: Container(
                        padding: const EdgeInsets.only(left: 16,right: 16),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey,width: 1),
                            borderRadius: BorderRadius.circular(15)
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton2(
                            isExpanded: true,
                            hint: Text(
                              'กรุณาเลือกเด็ก: ',
                              style: TextStyle(
                                fontSize: 14,
                                color: Theme
                                    .of(context)
                                    .hintColor,
                              ),
                            ),
                            items: _addDividersAfterItems(DropdownChildrens!),
                            underline: const SizedBox(),style: const TextStyle(
                              color: Colors.black,fontSize: 16
                          ),
                            customItemsIndexes: _getDividersIndexes(),
                            customItemsHeight: 4,
                            value: selectedChildrenValue,
                            onChanged: (value) {
                              setState(() {
                                selectedChildrenValue = value as String;
                              });
                            },
                            buttonHeight: 50,
                            buttonWidth: 320,
                            itemHeight: 40,
                            itemPadding: const EdgeInsets.symmetric(horizontal: 8.0),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(25, 0, 25, 20),
                      child: Container(
                        padding: const EdgeInsets.only(left: 16,right: 16),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey,width: 1),
                            borderRadius: BorderRadius.circular(15)
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton2(
                            isExpanded: true,
                            hint: Text(
                              'กรุณาเลือกโรงเรียน: ',
                              style: TextStyle(
                                fontSize: 14,
                                color: Theme
                                    .of(context)
                                    .hintColor,
                              ),
                            ),
                            items: _addDividersAfterItems(DropdownSchools!),
                            underline: const SizedBox(),style: const TextStyle(
                              color: Colors.black,fontSize: 16
                          ),
                            customItemsIndexes: _getDividersIndexes2(),
                            customItemsHeight: 4,
                            value: selectedSchoolValue,
                            onChanged: (value) {
                              setState(() {
                                selectedSchoolValue = value as String;
                                getRoutesBySchoolName(selectedSchoolValue!);
                              });
                            },
                            buttonHeight: 50,
                            buttonWidth: 320,
                            itemHeight: 40,
                            itemPadding: const EdgeInsets.symmetric(horizontal: 8.0),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(25, 0, 25, 20),
                      child: Container(
                        padding: const EdgeInsets.only(left: 16,right: 16),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey,width: 1),
                            borderRadius: BorderRadius.circular(15)
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton2(
                            isExpanded: true,
                            hint: Text(
                              'กรุณาเลือกเส้นทาง: ',
                              style: TextStyle(
                                fontSize: 14,
                                color: Theme.of(context).hintColor,
                              ),
                            ),
                            items:  _addDividersAfterItems(DropdownRoutes!),
                            underline: const SizedBox(),style: const TextStyle(
                              color: Colors.black,fontSize: 16
                          ),
                            customItemsIndexes: _getDividersIndexes3(),
                            customItemsHeight: 4,
                            value: selectedRouteValue,
                            onChanged: (value) {
                              setState(() {
                                selectedRouteValue = value as String;
                              });
                            },
                            buttonHeight: 50,
                            buttonWidth: 320,
                            itemHeight: 40,
                            itemPadding: const EdgeInsets.symmetric(horizontal: 8.0),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment : CrossAxisAlignment.start,
                              children: [
                                const Text('วันที่เริ่มให้บริการ',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                                const SizedBox(height: 8),
                                ButtonWidget(
                                  onClicked: () => pickDateRange(context),
                                  text: getFrom(),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Icon(Icons.arrow_forward, color: Colors.black),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Column(
                              crossAxisAlignment : CrossAxisAlignment.start,
                              children: [
                                const Text('วันที่สิ้นสุดให้บริการ',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                                const SizedBox(height: 8),
                                ButtonWidget(
                                  onClicked: () => pickDateRange(context),
                                  text: getUntil(),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: 350,
                      height: 50,
                      decoration: BoxDecoration(
                        border: Border.all(width: 1.0, color: const Color(
                            0xFFC9C9C9)),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Center(
                        child: Text(ServiceTime == null ? "ยังไม่เลือกวันที่" : ServiceTime.toString()),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
                      child: ElevatedButton(
                          onPressed: () => pickTime(context),
                          child: Text(getText(),style: const TextStyle(
                            color : Colors.black,
                          ),),
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size.fromHeight(40),
                            primary: Colors.white,
                          )
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment : MainAxisAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment : CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(left: 5.0),
                                  child: Text('ที่อยู่',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 190.0),
                                  child: ElevatedButton.icon(
                                    onPressed: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) => const ShowMap()));
                                    },
                                    icon: const Icon(Icons.location_on),
                                    label: const Text(
                                      'เลือกที่อยู่',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      primary:  Colors.amber,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              width: 350,
                              decoration: BoxDecoration(
                                border: Border.all(width: 1.0, color: const Color(
                                    0xFFC9C9C9)),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 10.0),
                                  child: TextFormField(
                                    controller: Address,
                                    maxLines: 4, //or null
                                    decoration: const InputDecoration.collapsed(
                                        hintText: "กรุณากรอกที่อยู่ที่ต้องการขึ้นรถ"
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                      child: ElevatedButton(
                        onPressed: () {
                          showDialog(context: context, builder: (context) => AlertDialog(
                            title: const Text("คุณต้องการร้องขอขึ้นรถขันนี้หรือไม่!"),
                            actions: [
                              ElevatedButton(onPressed: () {
                                doApplySchoolBus();
                              }, child: const Text("Yes")),
                              ElevatedButton(onPressed: (){
                                Navigator.pop(context);
                              }, child: const Text("No"))
                            ],
                          ));
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.fromLTRB(35, 15, 35, 15),
                          primary: Colors.amber,
                        ),
                        child: const Text(
                          'ร้องขอ',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

              ),
            ),
          ),
        ),
      ),
    );
  }

  String CalAge(DateTime date){
    DateTime purchaseDate = DateTime(date.year, date.month, date.day);
    DateDuration duration;
    duration = AgeCalculator.age(purchaseDate);
    return duration.years.toString();
  }

  DateDuration? ServiceTime;

  Future pickDateRange(BuildContext context) async {
    final initialDateRange = DateTimeRange(
      start: DateTime.now().add(const Duration(hours: 24*1)),
      end: DateTime.now().add(const Duration(hours: 24 * 30)),
    );
    final newDateRange = await showDateRangePicker(
      context: context,
      firstDate: DateTime(DateTime.now().year),
      lastDate: DateTime(DateTime.now().year + 5),
      initialDateRange: dateRange ?? initialDateRange,
    );

    if (newDateRange == null) return;

    setState(() {
      dateRange = newDateRange;
      ServiceTime = AgeCalculator.age(dateRange!.start, today: dateRange!.end);
    });

  }

  String getFrom() {
    if (dateRange == null) {
      return 'เริ่มต้น';
    } else {
      return DateFormat('yyyy/MM/dd').format(dateRange!.start);
    }
  }

  String getUntil() {
    if (dateRange == null) {
      return 'สิ้นสุด';
    } else {
      return DateFormat('yyyy/MM/dd').format(dateRange!.end);
    }
  }

  //เวลา

  TimeOfDay? time;
  String? timetxt;
  String getText() {
    if (time == null) {
      return 'เลือกเวลารับขึ้นรถ';
    } else {
      final hours = time!.hour.toString().padLeft(2, '0');
      final minutes = time!.minute.toString().padLeft(2, '0');

      timetxt = "$hours:$minutes";

      return 'รับขึ้นรถเวลา : $hours:$minutes น.';
    }
  }

  Future pickTime(BuildContext context) async {
    final initialTime = TimeOfDay(hour: 9, minute: 0);
    final newTime = await showTimePicker(
      context: context,
      initialTime: time ?? initialTime,
    );

    if (newTime == null) return;

    setState(() => time = newTime);
  }
  ContractManager contractManager = ContractManager();
  Future doApplySchoolBus() async{
    try{
      DateTime now = DateTime.now();
      List<String> indexChildren = selectedChildrenValue!.split(" : ");
      List<String> indexRoute = selectedRouteValue!.split(" : ");
      Contract contract = Contract("",now,dateRange!.start,dateRange!.end, latitude!,longitude!,timetxt!,null,1,
          listChildrens![int.parse(indexChildren[0])-1],listRoutesBySchoolName![int.parse(indexRoute[0])-1]);
      print(contract.toString());
      String result = await contractManager.doAddContract(contract);
      var logger = Logger();
      await getSharedPreferences.init();
      logger.e(result);
      if(result != "0") {
        getSharedPreferences.removeLatitude();
        getSharedPreferences.removeLongitude();
        getSharedPreferences.removeAddress();
        AnimatedSnackBar.rectangle(
            'สำเร็จ',
            'คุณร้องขอขึ้นรถสำเร็จ',
            type: AnimatedSnackBarType.success,
            brightness: Brightness.light,
            duration : const Duration(seconds: 5)
        ).show(
          context,
        );
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(
                builder: (context) => MyHomePage(indexScreen: null)));
      }else{
        AnimatedSnackBar.rectangle(
            'เกิดข้อผิดพลาด',
            'เกิดข้อผิดพลาดในการร้องขอ',
            type: AnimatedSnackBarType.error,
            brightness: Brightness.light,
            duration : const Duration(seconds: 5)
        ).show(
          context,
        );
        isLoading = false;

      }
    }catch(error){
      print(error);
    }


  }


  List<DropdownMenuItem<String>> _addDividersAfterItems(List<String> items) {
    List<DropdownMenuItem<String>> _menuItems = [];
    for (var item in items) {
      _menuItems.addAll(
        [
          DropdownMenuItem<String>(
            value: item,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                item,
                style: const TextStyle(
                  fontSize: 14,
                ),
              ),
            ),
          ),
          //If it's last item, we will not add Divider after it.
          if (item != items.last)
            const DropdownMenuItem<String>(
              enabled: false,
              child: Divider(),
            ),
        ],
      );
    }
    return _menuItems;
  }

  List<int> _getDividersIndexes() {
    List<int> _dividersIndexes = [];
    for (var i = 0; i < (DropdownChildrens!.length * 2) - 1; i++) {
      //Dividers indexes will be the odd indexes
      if (i.isOdd) {
        _dividersIndexes.add(i);
      }
    }
    return _dividersIndexes;
  }


  List<int> _getDividersIndexes2() {
    List<int> _dividersIndexes = [];
    for (var i = 0; i < (DropdownSchools!.length * 2) - 1; i++) {
      //Dividers indexes will be the odd indexes
      if (i.isOdd) {
        _dividersIndexes.add(i);
      }
    }
    return _dividersIndexes;
  }


  List<int> _getDividersIndexes3() {
    List<int> _dividersIndexes = [];
    for (var i = 0; i < (DropdownRoutes!.length * 2) - 1; i++) {
      //Dividers indexes will be the odd indexes
      if (i.isOdd) {
        _dividersIndexes.add(i);
      }
    }
    return _dividersIndexes;
  }


}