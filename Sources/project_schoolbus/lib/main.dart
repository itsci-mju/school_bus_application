
import 'package:project_schoolbus/page/Parent/ChildrenPage/AddChildren.dart';
import 'package:project_schoolbus/page/Parent/ChildrenPage/ChildrenPage.dart';
import 'package:project_schoolbus/page/Parent/ParentProfilePage/ParentProfilePage.dart';
import 'package:project_schoolbus/page/LoginPage/loginPage.dart';
import 'package:project_schoolbus/importer.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.amber,
          fontFamily: 'Kanit'
      ),

      home: const LoginPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key,required this.indexScreen}) : super(key: key);

  final int? indexScreen;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentIndex = 0;
  final screens = [
    HomePage(),
    ParentProfilePage(),
    ChildrenPage(),
    AddChildrenPage(),
  ];
  UploadTask? task;
  File? file;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: screens[currentIndex],
        bottomNavigationBar: BottomNavigationBar(
            unselectedItemColor: Colors.white,
            currentIndex: currentIndex,
            onTap: (index) => index == 4 ? checkLogout() : setState(() => currentIndex = index),
            items:const [
              BottomNavigationBarItem(icon: Icon(Icons.home),
                label: 'Home',
                backgroundColor: Colors.amber,
              ),
              BottomNavigationBarItem(icon: Icon(Icons.person),
                label: 'Profile',
                backgroundColor: Colors.amber,
              ),
              BottomNavigationBarItem(icon: Icon(Icons.child_care),
                label: 'Children',
                backgroundColor: Colors.amber,
              ),
              BottomNavigationBarItem(icon: Icon(Icons.add),
                label: 'AddChildren',
                backgroundColor: Colors.amber,
              ),
              BottomNavigationBarItem(icon: Icon(Icons.logout),
                label: 'Logout',
                backgroundColor: Colors.amber,
              )
            ]
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
  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);

    if (result == null) return;
    final path = result.files.single.path!;

    setState(() => file = File(path));
  }

}
