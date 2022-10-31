import 'package:flutter/cupertino.dart';

import '../../../importer.dart';
import '../../../manager/ContractManager.dart';
import '../../../model/ContractModel.dart';
import 'ChildrenDetailsPage.dart';

class List_ChildrenDriver extends StatefulWidget {
  const List_ChildrenDriver({Key? key}) : super(key: key);

  @override
  _List_ChildrenDriverState createState() => _List_ChildrenDriverState();
}

class _List_ChildrenDriverState extends State<List_ChildrenDriver> {
  ContractManager manager = ContractManager();
  List<Contract>? listChildren;
  bool isLoading = true;

  String num_plate = getSharedPreferences.getNum_plate() ?? '';

  @override
  void initState() {
    refreshContract();
    super.initState();
  }

  void refreshContract() async {
    setState(() {
      isLoading = true;
    });
    manager.driver_listChildren(num_plate).then((value) async => {
      setState(() {
        listChildren = value;
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
      child: (listChildren == null || listChildren!.isEmpty) ? const Text("ไม่มีรายการเด็ก") : buildListContract(),
    );
  }

  Widget buildListContract() {
    return Align(
      alignment: Alignment.topCenter,
      child:SingleChildScrollView(
        child: ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: listChildren!.length,
          itemBuilder: (context, index) {
            //ProjectModel project = projectSnap.data![index];
            return SizedBox(
              height:  MediaQuery.of(context).size.width*0.55,
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
                          const Text(
                            'รายละเอียดเด็ก',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w800),
                          ),

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
                              listChildren![index].children.image_profile,
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
                                  listChildren![index].children.firstname+" "+listChildren![index].children.lastname,
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  listChildren![index].busStop.school.school_name,
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
                                  listChildren![index].busStop.bus.driver.firstname+" "+listChildren![index].busStop.bus.driver.lastname,
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: InkWell(
                                    onTap: (){
                                      showDialog(context: context, builder: (context) => AlertDialog(
                                        title: const Text("ดูรายละเอียดเด็กคนนี้ ?"),
                                        actions: [
                                          ElevatedButton(onPressed: () {
                                            setContractID(listChildren![index].contract_ID);
                                            Navigator.pop(context);
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) => const Driver_ChildrenProfilePage()));

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
                                        width: 100,
                                        decoration: BoxDecoration(
                                            color: Color(0xff3399cc),
                                            borderRadius:
                                            BorderRadius.circular(5)),
                                        child: const Center(
                                          child: Text(
                                            'ดูข้อมูล',
                                            style: TextStyle(
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
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
      ) ,
    );

  }

  void setContractID(String contract_ID) async{
    await getSharedPreferences.setContractID(contract_ID);
  }
}