import 'package:flutter/cupertino.dart';

import '../../../importer.dart';
import '../HomePage/appbar.dart';

class ChildrenPage extends StatefulWidget {
  const ChildrenPage({Key? key}) : super(key: key);

  @override
  _ChildrenPageState createState() => _ChildrenPageState();
}

class _ChildrenPageState extends State<ChildrenPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children:  [
              SchoolbusAppBarPage(),
              Padding(
                padding: const EdgeInsets.only(left: 20.0,right: 20.0,top: 10.0),
                child: Row(
                  children: const <Widget>[
                    Icon(
                      CupertinoIcons.list_bullet,
                      size: 30.0,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text('รายการบุตร :',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800),),
                    Spacer(),

                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width * 1.5,
                width: MediaQuery.of(context).size.width * 2,
                child: AnimationLimiter(
                    child: ListView.builder(
                      itemCount: 1,
                      itemBuilder: (BuildContext context, int index) {
                        return AnimationConfiguration.staggeredList(
                          position: index,
                          duration: const Duration(milliseconds: 375),
                          child: const SlideAnimation(
                            verticalOffset: 50.0,
                            child: FadeInAnimation(
                              child: Children_list(),

                            ),
                          ),
                        );
                      },
                    )
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}