
import 'package:flutter/cupertino.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import '../../../importer.dart';
import '../Driver/Activity/ActivityPage.dart';
import '../Driver/Children/ChildrenPage.dart';
import '../Driver/Contract/ApplicationPage.dart';
import '../Driver/HomePage/HomeDriverPage.dart';
import '../Driver/Profile/MenuProfilePage.dart';
import '../LoginPage/loginPage.dart';


class MainPageDriver extends StatefulWidget {
  const MainPageDriver( {Key? key}) : super(key: key);

  @override
  State<MainPageDriver> createState() => _MainRegisterState();
}

class _MainRegisterState extends State<MainPageDriver>{

  int _currentIndex = 0;



  final screens = [
    HomePageDriver(),
    Driver_Children(),
    ActivityPage(),
    ApplicationPage(),
    MenuProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[_currentIndex],
      bottomNavigationBar: SalomonBottomBar(
      currentIndex: _currentIndex,
      onTap: (i) => setState(() => _currentIndex = i),
      items: [
        /// Home
        SalomonBottomBarItem(
          icon: const Icon(CupertinoIcons.home),
          title: const Text("หน้าแรก" ,style:TextStyle( fontFamily: 'Kanit'),),
          selectedColor: Color(0xffe3a510),
        ),

        /// Children
        SalomonBottomBarItem(
          icon: Icon(Icons.child_care),
          title: Text("รายการเด็ก",style:TextStyle( fontFamily: 'Kanit')),
          selectedColor: Color(0xffe3a510),
        ),

        /// Activity
        SalomonBottomBarItem(
          icon: Icon(Icons.airline_seat_recline_extra),
          title: Text("การขึ้นลงรถ",style:TextStyle( fontFamily: 'Kanit')),
          selectedColor: Color(0xffe3a510),
        ),

        /// Contract
        SalomonBottomBarItem(
          icon: const ImageIcon(
            AssetImage("images/application_icon.png"),
          ),
          title: Text("รายการสัญญา",style:TextStyle( fontFamily: 'Kanit')),
          selectedColor: Color(0xffe3a510),
        ),

        /// Profile
        SalomonBottomBarItem(
          icon: Icon(CupertinoIcons.person),
          title: Text("โปรไฟล์",style:TextStyle( fontFamily: 'Kanit')),
          selectedColor: Color(0xffe3a510),
        ),
      ],
    ),
    );
  }
}


