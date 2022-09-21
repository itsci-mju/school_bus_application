import 'package:project_schoolbus/page/Register/RegisterDriverPage.dart';
import '../../../importer.dart';
import '../HomePage/light_colors.dart';
import 'List_Application.dart';
import 'List_RequestCancel.dart';


class ApplicationPage extends StatefulWidget {
  const ApplicationPage({Key? key}) : super(key: key);

  @override
  State<ApplicationPage> createState() => _ApplicationState();
}

class _ApplicationState extends State<ApplicationPage> with SingleTickerProviderStateMixin {

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
          title: const Text("Application Page"),
          toolbarHeight: 60,
          automaticallyImplyLeading: false,
          shape: const RoundedRectangleBorder(
              borderRadius:  BorderRadius.only(
                  bottomRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10))
          ),
        backgroundColor: Colors.amber,

      ),
      backgroundColor: LightColors.kLightYellow,
      body: DefaultTabController(
          length: 2,
          child: Column(
            children: <Widget>[
              Material(
                color: Colors.grey.shade300,
                child: TabBar(
                  unselectedLabelColor: Colors.grey,
                  labelColor: const Color(0xff3399cc),
                  indicatorColor: Colors.black,
                  controller: _tabController,
                  labelPadding: const EdgeInsets.all(0.0),
                  tabs: [
                    _getTab(0,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            ImageIcon(
                              AssetImage("images/application_icon.png"),
                            ),
                            SizedBox(width: 10,),
                            Text('Application',style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w800),)
                          ],
                        )
                    ),
                    _getTab(1,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            ImageIcon(
                              AssetImage("images/application_icon.png"),
                            ),
                            SizedBox(width: 10,),
                            Text('RequestCancel',style: TextStyle(
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
                    SizedBox(
                      height: MediaQuery.of(context).size.height*0.74,
                      width: 400,
                      child: const ListApplication()
                    ),
                    SizedBox(
                        height: MediaQuery.of(context).size.height*0.74,
                        width: 400,
                        child: const ListRequestCancel()
                    ),
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