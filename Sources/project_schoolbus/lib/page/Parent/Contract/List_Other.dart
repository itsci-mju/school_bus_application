import 'package:project_schoolbus/page/Parent/Contract/ContractDetailsPage.dart';

import '../../../importer.dart';
import '../../../manager/ContractManager.dart';
import '../../../model/ContractModel.dart';

class List_Other extends StatefulWidget {
  const List_Other({Key? key}) : super(key: key);

  @override
  State<List_Other> createState() => _List_OtherState();
}

class _List_OtherState extends State<List_Other> {
  ContractManager manager = ContractManager();
  List<Contract>? listOther;
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
    manager.getListOther(IDCard).then((value) async => {
      setState(() {
        listOther = value;
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
      child: (listOther == null || listOther!.isEmpty) ? const Text("ไม่มีรายการสัญญา") : buildListContract(),
    );
  }

  Widget buildListContract() {
    return Align(
      alignment: Alignment.topCenter,
      child: SingleChildScrollView(
        child:  ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: listOther!.length,
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
                              listOther![index].busStop.bus.image_Bus,
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
                                  listOther![index].children.firstname+" "+listOther![index].children.lastname,
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  listOther![index].busStop.school.school_name,
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
                                  listOther![index].busStop.bus.driver.firstname+" "+listOther![index].busStop.bus.driver.lastname,
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
                                        title: const Text("ดูรายละเอียดสัญญา ?"),
                                        actions: [
                                          ElevatedButton(onPressed: () {
                                            setContractID(listOther![index].contract_ID);
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
                                        width: 100,
                                        decoration: BoxDecoration(
                                            color: Colors.amber,
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
      ),

    );

  }

  void setContractID(String contract_ID) async{
    await getSharedPreferences.setContractID(contract_ID);
  }
}