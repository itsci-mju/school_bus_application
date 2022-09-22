import 'package:flutter/cupertino.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import '../../../importer.dart';
import '../Chidren/HomePageChidren.dart';
import '../LoginPage/loginPage.dart';
class MainPageChidren extends StatefulWidget {
  const MainPageChidren({Key? key,required this.indexScreen}) : super(key: key);

  final int? indexScreen;

  @override
  State<MainPageChidren> createState() => _MainChidrenState();
}

class _MainChidrenState extends State<MainPageChidren>{

  int _currentIndex = 0;

  final screens = [
    HomePageChidren(),

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[_currentIndex],
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: _currentIndex,
        onTap: (index) => index == 1 ? checkLogout() : setState(() => _currentIndex = index),
        items: [
          /// Home
          SalomonBottomBarItem(
            icon: const Icon(CupertinoIcons.home),
            title: const Text("หน้าแรก",style:TextStyle( fontFamily: 'Kanit')),
            selectedColor: Color(0xffe3a510),
          ),
          /// Profile
          SalomonBottomBarItem(
            icon: Icon(Icons.logout),
            title: Text("ออกจากระบบ",style:TextStyle( fontFamily: 'Kanit')),
            selectedColor: Color(0xffe3a510),
          ),
        ],
      ),
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