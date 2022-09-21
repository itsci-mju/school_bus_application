import 'package:project_schoolbus/page/Register/RegisterDriverPage.dart';
import '../../importer.dart';

class MainRegister extends StatefulWidget {
  const MainRegister({Key? key}) : super(key: key);

  @override
  State<MainRegister> createState() => _MainRegisterState();
}

class _MainRegisterState extends State<MainRegister> with SingleTickerProviderStateMixin {

  TabController? _tabController;

  int _selectedTab = 0;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(vsync: this, length: 2);

    _tabController!.addListener((){
      if (!_tabController!.indexIsChanging){
        setState(() {
          _selectedTab = _tabController!.index;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: const Text("หน้าสมัครสมาชิก"),
        toolbarHeight: 60,
        shape: const RoundedRectangleBorder(
              borderRadius:  BorderRadius.only(
                  bottomRight: Radius.circular(5),
                  bottomLeft: Radius.circular(5))
        )

      ),
      backgroundColor: Colors.white,
      body: DefaultTabController(
          length: 2,
          child: Column(
            children: <Widget>[
              Material(
                color: Colors.white,
                child: TabBar(

                  unselectedLabelColor: Colors.grey,
                  labelColor: Colors.amber,
                  indicatorColor: Colors.white,
                  controller: _tabController,
                  labelPadding: const EdgeInsets.all(0.0),
                  tabs: [
                    _getTab(0,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(Icons.person),
                            SizedBox(width: 10,),
                            Text('ผู้ปกครอง',style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w800),)
                          ],
                        )
                    ),
                    _getTab(1,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(Icons.directions_bus),
                            SizedBox(width: 10,),
                            Text('คนขับรถ',style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w800),)
                          ],
                        )
                    ),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: _tabController,
                  children: [
                    RegisterParentPage(),
                    RegisterDriverPage(),
                  ],
                ),
              ),
            ],
          )),
    );
  }


  _getTab(index, child) {
    return Tab(
      child: SizedBox.expand(
        child: Container(
          child: child,
          decoration: BoxDecoration(
              color:
              (_selectedTab == index ? Colors.white : Colors.grey.shade300),
              borderRadius: _generateBorderRadius(index)),
        ),
      ),
    );
  }

  _generateBorderRadius(index) {
    if ((index + 1) == _selectedTab) {
      return const BorderRadius.only(bottomRight: Radius.circular(10.0));
    }else if ((index - 1) == _selectedTab) {
      return const BorderRadius.only(bottomLeft: Radius.circular(10.0));
    }else {
      return BorderRadius.zero;
    }
  }
}