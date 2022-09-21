import 'package:flutter/cupertino.dart';
import 'package:project_schoolbus/page/Parent/HomePage/toggleContract.dart';
import 'package:project_schoolbus/page/Parent/Route/listRoute.dart';

import '../../../importer.dart';
import '../SearchSchoolBus/SearchPage.dart';
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {
  String profile = getSharedPreferences.getProfile() ?? '';

  @override
  void initState() {
    getProfile();
    super.initState();
  }

  void getProfile(){
    var log = Logger();
    Map<String, dynamic> map = jsonDecode(profile);
    Parent p = Parent.fromJson(map);
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children:  [
                  SchoolbusAppBarPage(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10.0),
                    child:Row(
                      children: <Widget>[
                        const Icon(
                          CupertinoIcons.list_bullet,
                          size: 30.0,
                        ),
                        const SizedBox(width: 10,),
                        const Text('รายการสัญญา :',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w800),),
                        const Spacer(),
                        InkWell(
                            hoverColor: Colors.black,
                          child: const Padding(
                            padding: EdgeInsets.fromLTRB(10, 10, 8, 10),
                            child: Icon(Icons.search),
                          ),
                          onTap: (){
                            Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) =>  SearchPage()));
                          },
                          borderRadius: BorderRadius.circular(20.0)
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                      ],
                    ),
                  ),
                SizedBox(
                  height: MediaQuery.of(context).size.height*0.74,
                  width: 400,
                  child: const ToggleContract()
                ),
              ],
            ),
          ),
        ),

      );
  }
}
