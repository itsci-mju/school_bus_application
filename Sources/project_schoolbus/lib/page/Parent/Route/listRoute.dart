import '../../../importer.dart';

class Route_list extends StatefulWidget {
  const Route_list({Key? key}) : super(key: key);

  @override
  State<Route_list> createState() => _Route_listState();
}

class _Route_listState extends State<Route_list> {
  RouteManager manager = RouteManager();
  List<Routes>? listRoutes;
  bool isLoading = true;

  @override
  void initState() {
    refreshRoute();
    super.initState();
  }

  void refreshRoute() async {
    setState(() {
      isLoading = true;
    });
    manager.listRoute().then((value) async => {
      setState(() {
        listRoutes = value;
        isLoading = false;

      }),
    });

  }

 /* void refreshRoute() {
    setState(() {
      isLoading = true;
    });
        () async {
      await manager.listRoute();
      setState(() {
        futureRoute = manager.listRoute();
      });
    } ();
  }
*/
  @override
  Widget build(BuildContext context)  {

    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(8.0),
      child: (listRoutes == null) ? const Text("ไม่มีรายการรถ") : buildListRoute(),
    );
  }


  Widget buildListRoute() {
    return listRoutes == null ? const CircularProgressIndicator() : ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: listRoutes!.length,
              itemBuilder: (context, index) {
                //ProjectModel project = projectSnap.data![index];
                return SizedBox(
                  height: 150,
                  width: 150,
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                                child: Image.asset(
                                  'images/schoolbus.png',
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
                                      listRoutes![index].school.school_name,
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      listRoutes![index].bus.num_plate+" "+listRoutes![index].bus.province ,
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      listRoutes![index].bus.driver.firstname+" "+listRoutes![index].bus.driver.lastname,
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
                                                title: const Text("ดูรถคันนี้?"),
                                                actions: [
                                                  ElevatedButton(onPressed: () {
                                                    setNum_plate(listRoutes![index].bus.num_plate);
                                                    Navigator.pop(context);
                                                    Navigator.of(context).push(
                                                        MaterialPageRoute(
                                                            builder: (context) => const SchoolBusDetailsPage()));

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
            );

  }

  void setNum_plate(String num_plate) async{
    await getSharedPreferences.setNum_plate(num_plate);
  }
}