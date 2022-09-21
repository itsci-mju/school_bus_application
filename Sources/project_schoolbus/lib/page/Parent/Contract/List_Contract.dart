import 'package:project_schoolbus/page/Parent/ActivityPageP/viewActivitypage.dart';
import 'package:project_schoolbus/page/Parent/Contract/ContractDetailsPage.dart';

import '../../../importer.dart';
import '../../../manager/ContractManager.dart';
import '../../../model/ContractModel.dart';
import 'ViewLocation.dart';

class List_ContractApproved extends StatefulWidget {
  const List_ContractApproved({Key? key}) : super(key: key);

  @override
  State<List_ContractApproved> createState() => _List_ContractApprovedState();
}

class _List_ContractApprovedState extends State<List_ContractApproved> {
  ContractManager manager = ContractManager();
  List<Contract>? listApproved;
  List<Contract>? listUnapproved;
  bool isLoading = true;

  String IDCard = getSharedPreferences.getIDCard() ?? '';

  @override
  void initState() {
    refreshContract();
    super.initState();
  }

  void refreshContract() async {
    setState(() {
      isLoading = true;
    });
    manager.getListApproved(IDCard).then((value) async => {
      setState(() {
        listApproved = value;
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
      padding: const EdgeInsets.only(bottom: 150.0),
      child: (listApproved == null || listApproved!.isEmpty) ? const Text("ไม่มีรายการสัญญา") : buildListContract(),
    );
  }

  Widget buildListContract() {
    return Align(
      alignment: Alignment.topCenter,
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: listApproved!.length,
        itemBuilder: (context, index) {
          //ProjectModel project = projectSnap.data![index];
          return SizedBox(
            height: MediaQuery.of(context).size.height*0.28,
            width:  MediaQuery.of(context).size.width*1,
            child: InkWell(
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Text(
                            'รายละเอียดสัญญา',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w800),
                          ),
                          const Spacer(),
                          InkWell(
                            child: Image.asset(
                              'images/btn_base.png',
                              width: 40.0,
                              height: 40.0,
                              fit: BoxFit.cover,

                            ),
                            onTap: () async {
                              String url = listApproved![index].routes.bus.driver.groupline;
                              var urllaunchable = await canLaunch(url);
                              if(urllaunchable){
                                await launch(url);
                              }else{
                                print("URL can't be launched.");
                              }
                            },
                          )
                          ,
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                            child: Container (
                              height: 150,
                              width: 150,
                              decoration:  BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage(listApproved![index].routes.bus.image_Bus),
                                      fit: BoxFit.cover)
                              ),
                            ),
                            /*  Image.network(
                            listApproved![index].routes.bus.image_Bus,
                            width: 100.0,
                            height: 100.0,
                            fit: BoxFit.cover,
                          ),*/
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
                                  listApproved![index].children.firstname+" "+listApproved![index].children.lastname,
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  listApproved![index].routes.school.school_name,
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                const Text(
                                  'รายละเอียดคนขับรถ',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w800),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  listApproved![index].routes.bus.driver.firstname+" "+listApproved![index].routes.bus.driver.lastname,
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: InkWell(
                                        onTap: (){
                                          showDialog(context: context, builder: (context) => AlertDialog(
                                            title: const Text("ดูการขึ้นรถ ?"),
                                            actions: [
                                              ElevatedButton(onPressed: () {
                                                setContractID(listApproved![index].contract_ID);
                                                Navigator.pop(context);
                                                Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                        builder: (context) => const viewActivitypage()));

                                              }, child: const Text("ดู")),
                                              ElevatedButton(onPressed: (){
                                                Navigator.pop(context);
                                              }, child: const Text("ยกเลิก"))
                                            ],
                                          ));
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                          child: Container(
                                            height: 35,
                                            width: 75,
                                            decoration: BoxDecoration(
                                                color: Colors.amber[600],
                                                borderRadius:
                                                BorderRadius.circular(5)),
                                            child: const Center(
                                              child: Text(
                                                'การขึ้นรถ',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),

                                    )
                                    ,
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: InkWell(
                                        onTap: (){
                                          showDialog(context: context, builder: (context) => AlertDialog(
                                            title: const Text("ดูรายละเอียดสัญญา ?"),
                                            actions: [
                                              ElevatedButton(onPressed: () {
                                                setContractID(listApproved![index].contract_ID);
                                                Navigator.pop(context);
                                                Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                        builder: (context) => const ContractDetailsPage()));

                                              }, child: const Text("ดู")),
                                              ElevatedButton(onPressed: (){
                                                Navigator.pop(context);
                                              }, child: const Text("ยกเลิก"))
                                            ],
                                          ));
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                          child: Container(
                                            height: 35,
                                            width: 75,
                                            decoration: BoxDecoration(
                                                color: Colors.amber[600],
                                                borderRadius:
                                                BorderRadius.circular(5)),
                                            child: const Center(
                                              child: Text(
                                                'ดู',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),

                                    )
                                  ],
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
              onTap: (){
                setdriverid(listApproved![index].routes.bus.driver.IDCard);
                Navigator.pop(context);
                Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => const ViewLocation()));
              },
            )
          );
        },
      ),
    );

  }

  void setContractID(String contract_ID) async{
    await getSharedPreferences.setContractID(contract_ID);
  }
  void setdriverid(String id) async{
    await getSharedPreferences.setDeiverID(id);
  }
}


class List_ContractUnApproved extends StatefulWidget {
  const List_ContractUnApproved({Key? key}) : super(key: key);

  @override
  State<List_ContractUnApproved> createState() => _List_ContractUnApprovedState();
}

class _List_ContractUnApprovedState extends State<List_ContractUnApproved> {
  ContractManager manager = ContractManager();
  List<Contract>? listUnapproved;
  bool isLoading = true;

  String IDCard = getSharedPreferences.getIDCard() ?? '';

  @override
  void initState() {
    refreshContract();
    super.initState();
  }

  void refreshContract() async {
    setState(() {
      isLoading = true;
    });
    manager.getListUnApproved(IDCard).then((value) async => {
      setState(() {
        listUnapproved = value;
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
      padding: const EdgeInsets.only(bottom: 150.0),
      child: (listUnapproved == null || listUnapproved!.isEmpty) ? const Text("ไม่มีรายการสัญญา") : buildListRoute(),
    );
  }


  Widget buildListRoute() {
    return Align(
      alignment : Alignment.topCenter,
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: listUnapproved!.length,
        itemBuilder: (context, index) {
          //ProjectModel project = projectSnap.data![index];
          return SizedBox(
            height: MediaQuery.of(context).size.height*0.28,
            width:  MediaQuery.of(context).size.width*1,
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: const [
                        Text(
                          'รายละเอียดสัญญา',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w800),
                        ),
                        Spacer(),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                          child: Image.network(
                            listUnapproved![index].routes.bus.image_Bus,
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
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                listUnapproved![index].children.firstname+" "+listUnapproved![index].children.lastname,
                                style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                listUnapproved![index].routes.school.school_name,
                                style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              const Text(
                                'รายละเอียดคนขับรถ',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w800),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                listUnapproved![index].routes.bus.driver.firstname+" "+listUnapproved![index].routes.bus.driver.lastname,
                                style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: Row(
                                  children: [
                                    InkWell(
                                      onTap: (){
                                        showDialog(context: context, builder: (context) => AlertDialog(
                                          title: const Text("ดูรายละเอียดสัญญา ?"),
                                          actions: [
                                            ElevatedButton(onPressed: () {
                                              setContractID(listUnapproved![index].contract_ID);
                                              Navigator.pop(context);
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) => const ContractDetailsPage()));

                                            }, child: const Text("ดู")),
                                            ElevatedButton(onPressed: (){
                                              Navigator.pop(context);
                                            }, child: const Text("ยกเลิก"))
                                          ],
                                        ));
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 0.0),
                                        child: Container(
                                          height: 35,
                                          width: 100,
                                          decoration: BoxDecoration(
                                              color: Color(0xffa3d064),
                                              borderRadius:
                                              BorderRadius.circular(5)),
                                          child: const Center(
                                            child: Text(
                                              'ดู',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 10.0,),
                                    InkWell(
                                      onTap: (){
                                        showDialog(context: context, builder: (context) => AlertDialog(
                                          title: const Text("ต้องการยกเลิกการร้องขอ ?"),
                                          actions: [
                                            ElevatedButton(onPressed: () {
                                              Navigator.pop(context);
                                              deleteContract(listUnapproved![index].contract_ID);
                                              refreshContract();
                                            }, child: const Text("ยืนยัน")),
                                            ElevatedButton(onPressed: (){
                                              Navigator.pop(context);
                                            }, child: const Text("ยกเลิก"))
                                          ],
                                        ));
                                      },
                                      child: Container(
                                        height: 35,
                                        width: 100,
                                        decoration: BoxDecoration(
                                            color: Color(0xffed4145),
                                            borderRadius:
                                            BorderRadius.circular(5)),
                                        child: const Center(
                                          child: Text(
                                            'ยกเลิก',
                                            style: TextStyle(
                                                color: Colors.white),
                                          ),
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
          );
        },
      ),
    );

  }

  Future<void> deleteContract(String contract_ID) async{
   String result = await manager.deleteContract(contract_ID);
   if(result == "1"){
     ScaffoldMessenger.of(context).showSnackBar(
         const SnackBar(content: Text('ลบสำเร็จ')));
   }else if (result == "0"){
     ScaffoldMessenger.of(context).showSnackBar(
         const SnackBar(content: Text('เกิดข้อผิดพลาด')));
   }
  }

  void setContractID(String contract_ID) async{
    await getSharedPreferences.setContractID(contract_ID);
  }

}