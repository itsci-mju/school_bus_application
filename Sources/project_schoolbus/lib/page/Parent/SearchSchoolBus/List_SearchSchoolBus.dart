
import 'package:flutter/cupertino.dart';

import '../../../importer.dart';

class List_SearchSchoolBus extends StatefulWidget {
  const List_SearchSchoolBus({Key? key,required this.title}) : super(key: key);

  final String title;

  @override
  State<List_SearchSchoolBus>  createState() => _List_SearchSchoolBusState();
}

class _List_SearchSchoolBusState extends State<List_SearchSchoolBus>  {

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
    manager.getListSearch(widget.title).then((value) async => {
      setState(() {
        listRoutes = value;
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
    return Scaffold(
      appBar: AppBar(title: Text(widget.title),
        backgroundColor: Colors.amber,
      ),
      body: Container(
        alignment: Alignment.topCenter,
        padding: const EdgeInsets.all(8.0),
        child: (listRoutes == null) ? const Text("ไม่มีรายการรถ") : buildListRoute(),
      ),
    );
  }


  Widget buildListRoute() {
    if(isLoading){
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 20.0),
          child: Row(
            children: const <Widget>[
              Icon(
                CupertinoIcons.list_bullet,
                size: 30.0,
              ),
              SizedBox(
                width: 10,
              ),
              Text('ผลลัพธ์ :',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800),),
            ],
          ),
        ),

        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: listRoutes!.length,
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
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                            child: Container (
                              height: 150,
                              width: 150,
                              decoration:  BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage(listRoutes![index].bus.image_Bus),
                                      fit: BoxFit.cover)
                              ),
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
      ],
    );
  }

  void setNum_plate(String num_plate) async{
    await getSharedPreferences.setNum_plate(num_plate);
  }

}