import 'package:flutter/cupertino.dart';

import '../../../importer.dart';
import '../HomePage/light_colors.dart';
import 'List_Children.dart';

class Driver_Children extends StatefulWidget {
  const Driver_Children({Key? key}) : super(key: key);

  @override
  State<Driver_Children>  createState() => _Driver_ChildrenState();
}

class _Driver_ChildrenState extends State<Driver_Children>  {

  @override
  Widget build(BuildContext context)  {
    return Scaffold(
      appBar: AppBar(title: const  Text('รายการเด็ก :',
        style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700),),
        backgroundColor: Colors.amber,
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height*1,
          color: LightColors.kLightYellow,
          alignment: Alignment.topCenter,
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: const [
                  SizedBox(width: 5,),
                  Icon(
                    CupertinoIcons.list_bullet,
                    size: 30.0,
                  ),
                  SizedBox(width: 10,),
                ],
              ),
              const SizedBox(height: 5,),
              List_ChildrenDriver(),
            ],
          ),
        ),
      ),
    );
  }
}