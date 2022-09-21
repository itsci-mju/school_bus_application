import 'package:flutter/cupertino.dart';
import 'package:project_schoolbus/page/Driver/Profile/ProfileDriverPage.dart';
import 'package:project_schoolbus/page/Driver/UpdateService/UpdateServicePage.dart';
import '../../../importer.dart';

import '../../LoginPage/loginPage.dart';

class MenuProfilePage extends StatefulWidget {
  const MenuProfilePage({Key? key}) : super(key: key);



  @override
  State<MenuProfilePage> createState() => _MenuProfilePageState();

}

class _MenuProfilePageState extends State<MenuProfilePage> {

  String profile = getSharedPreferences.getProfile() ?? '';
  String bus = getSharedPreferences.getBus() ?? '';
  Driver? d;
  Bus? b;

  @override
  void initState() {
    getProfile();
    super.initState();
  }

  void getProfile(){
    Map<String, dynamic> map = jsonDecode(profile);
    Map<String, dynamic> map2 = jsonDecode(bus);
    d = Driver.fromJson(map);
    b = Bus.fromJson(map2);
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(0, 60, 0, 25),
          child: Text('โปรไฟล์',style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 40,
          ),),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.network(
                d!.image_profile,
                width: 150,
              ),

              const SizedBox(height: 20,),
              Center(
                child: Container(
                  width: 350,
                  decoration: BoxDecoration(
                    border: Border.all(width: 1.5, color: const Color(
                        0xFFC9C9C9)),
                  ),
                ),
              ),
              const SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                  child: InkWell(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        mainAxisAlignment : MainAxisAlignment.spaceAround,
                        children: const [
                          Icon(CupertinoIcons.person,size: 35.0),
                          SizedBox(width: 30,),
                          Text('ข้อมูลส่วนตัว',style: TextStyle(
                            fontSize: 20,
                          ),),
                          Spacer(),
                          Icon(Icons.arrow_forward_ios,size: 25.0),
                        ],
                      ),
                    ),
                    borderRadius: BorderRadius.circular(20.0),
                    onTap: (){
                      Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => ProfileDriverPage()));
                    },
                  ),
                ),
              const SizedBox(height: 20),
              Center(
                child: Container(
                  width: 350,
                  decoration: BoxDecoration(
                    border: Border.all(width: 1.5, color: const Color(
                        0xFFC9C9C9)),
                  ),
                ),
              ),
              const SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                child: InkWell(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisAlignment : MainAxisAlignment.spaceAround,
                      children: const [
                        Icon(CupertinoIcons.nosign,size: 35.0),
                        SizedBox(width: 30,),
                        Text('ยกเลิกการให้บริการ',style: TextStyle(
                          fontSize: 20,
                        ),),
                        Spacer(),
                        Icon(Icons.arrow_forward_ios,size: 25.0),
                      ],
                    ),
                  ),
                  borderRadius: BorderRadius.circular(20.0),
                  onTap: (){
                    Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => UpdateServicePage()));
                  },
                ),
              ),
              Center(
                child: Container(
                  width: 350,
                  decoration: BoxDecoration(
                    border: Border.all(width: 1.5, color: const Color(
                        0xFFC9C9C9)),
                  ),
                ),
              ),
              const SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                child: InkWell(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisAlignment : MainAxisAlignment.spaceAround,
                      children: const [
                        Icon(Icons.logout,size: 35.0),
                        SizedBox(width: 30,),
                        Text('ออกจากระบบ',style: TextStyle(
                          fontSize: 20,
                        ),),
                        Spacer(),
                        Icon(Icons.arrow_forward_ios,size: 25.0),
                      ],
                    ),
                  ),
                  borderRadius: BorderRadius.circular(20.0),
                  onTap: (){
                    checkLogout();
                  },
                ),
              ),
            ],
          ),
      ],
    );
  }
  void checkLogout() {
    showDialog(context: context, builder: (context) => AlertDialog(
      title: const Text("คุณต้องการออกจากระบบ?"),
      actions: [
        ElevatedButton(onPressed: () async {
          await getSharedPreferences.init();
          await getSharedPreferences.prefs!.clear();
          Navigator.pop(context);
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => LoginPage()));
        }, child: const Text("ยืนยัน")),
        ElevatedButton(onPressed: (){
          Navigator.pop(context);
        }, child: const Text("ยกเลิก"))
      ],
    ));

  }


}