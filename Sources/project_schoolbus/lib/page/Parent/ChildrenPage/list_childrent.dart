
import 'package:project_schoolbus/importer.dart';

class Children_list extends StatefulWidget {
  const Children_list({Key? key}) : super(key: key);

  @override
  State<Children_list> createState() => _Children_listState();
}

class _Children_listState extends State<Children_list> {

  ChildrenManager manager = ChildrenManager();
  String IDCard = getSharedPreferences.getIDCard() ?? '';
  List<Children>? listchildren;
  String? result;
  bool isLoading = true;

  @override
  void initState() {
    refreshChildren();
    super.initState();
  }

  void refreshChildren() {
    setState(() {
      isLoading = true;
    });
    manager.listChildrenByParentId(IDCard).then((value) => {
        setState(() {
          listchildren = value;
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
        child: (listchildren == null) ? const Text("ไม่มีรายการบุตร") : buildListChildren(),
    );
  }

  Widget buildListChildren() {
    return Container(
            child: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: listchildren!.length,
              itemBuilder: (context, index) {
                //ProjectModel project = projectSnap.data![index];
                return SizedBox(
                  height: MediaQuery.of(context).size.height*0.2,
                  width:  MediaQuery.of(context).size.width*1,
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,

                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                                child: Image.network(
                                  listchildren![index].image_profile,
                                  width: 100.0,
                                  height: 100.0,
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
                                      listchildren![index].firstname +" "+listchildren![index].lastname,
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      CalAge(listchildren![index].birthday)
                                      ,
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      'เบอร์โทร : '+listchildren![index].phone,
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
                                                  title: const Text("คุณแน่ใจหรือไม่ที่ ต้องการลบเด็กคนนี้ออก!"),
                                                  actions: [
                                                    ElevatedButton(onPressed: () {
                                                      manager.DeleteChildrenById(listchildren![index].IDCard).then((value) => {
                                                        result = value,
                                                        if(result == "1"){
                                                          ScaffoldMessenger.of(context).showSnackBar(
                                                              const SnackBar(content: Text('ลบสำเร็จ')))
                                                        }else if (result == "2"){
                                                          ScaffoldMessenger.of(context).showSnackBar(
                                                              const SnackBar(content: Text('เกิดข้อผิดพลาด')))
                                                        },

                                                        refreshChildren(),
                                                        Navigator.pop(context),


                                                      });

                                                    }, child: const Text("ลบ")),
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
                                                    'ลบ',
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              width : 20,
                                            ),
                                            InkWell(
                                              onTap: (){
                                                showDialog(context: context, builder: (context) => AlertDialog(
                                                  title: const Text("คุณต้องการแก้ไขข้อมูลของเด็กหรือไม่"),
                                                  actions: [
                                                    ElevatedButton(onPressed: () {
                                                      setChildrenID(listchildren![index].IDCard);
                                                      Navigator.pop(context);
                                                      Navigator.of(context).push(
                                                          MaterialPageRoute(
                                                              builder: (context) => const ChildrenProfilePage()));

                                                    }, child: const Text("ต้องการ")),
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
                                                    color: Color(0xffa3d064),
                                                    borderRadius:
                                                    BorderRadius.circular(5)),
                                                child: const Center(
                                                  child: Text(
                                                    'แก้ไข',
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

  String CalAge(DateTime date){
    DateTime purchaseDate = DateTime(date.year, date.month, date.day);
    DateDuration duration;
    duration = AgeCalculator.age(purchaseDate);
    return "อายุ : "+duration.years.toString()+" ปี";
  }

  void setChildrenID(String IDCardChildren) async{
    await getSharedPreferences.setIDCardChildren(IDCardChildren);
  }
}
