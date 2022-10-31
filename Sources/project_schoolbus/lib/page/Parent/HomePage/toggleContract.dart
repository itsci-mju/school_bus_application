
import '../../../importer.dart';
import '../Contract/List_Contract.dart';
import '../Contract/List_Other.dart';

class ToggleContract extends StatefulWidget {
  const ToggleContract({Key? key}) : super(key: key);

  @override
  State<ToggleContract> createState() => _ToggleContractState();
}

class _ToggleContractState extends State<ToggleContract> with SingleTickerProviderStateMixin {

  TabController? _tabController;

  int _selectedTab = 0;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(vsync: this, length: 3);

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
    return DefaultTabController(
          length: 3,
          child: Column(
            children: <Widget>[
              Material(
                color: Colors.grey.shade300,
                child: TabBar(
                  unselectedLabelColor: Colors.grey,
                  labelColor: const Color(0xffe3a510),
                  indicatorColor: Colors.white,
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
                            Text('อนุมัติแล้ว',style: TextStyle(
                                fontSize: 16,
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
                            Text('รออนุมัติ',style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w800),)
                          ],
                        )
                    ),
                    _getTab(2,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            ImageIcon(
                              AssetImage("images/application_icon.png"),
                            ),
                            SizedBox(width: 10,),
                            Text('อื่นๆ',style: TextStyle(
                                fontSize: 16,
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
                  children: const [
                    List_ContractApproved(),
                    List_ContractUnApproved(),
                    List_Other(),
                  ],
                ),
              ),
            ],
          )
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