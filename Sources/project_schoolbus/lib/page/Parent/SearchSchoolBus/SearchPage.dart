import 'dart:async';

import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import '../../../manager/SchoolManager.dart';
import '../../../model/SchoolModel.dart';
import '../../LoginPage/loginPage.dart';
import 'List_SearchSchoolBus.dart';
import '../../../importer.dart';
class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  SearchPageState createState() => SearchPageState();
}

class SearchPageState extends State<SearchPage> {
  String Firstname = getSharedPreferences.getFirstname() ?? '';
  List<School> schools = [];
  String query = '';
  Timer? debouncer;
  final controller = TextEditingController();
  SchoolManager manager = SchoolManager();

  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  void dispose() {
    debouncer?.cancel();
    super.dispose();
  }

  void debounce(
      VoidCallback callback, {
        Duration duration = const Duration(milliseconds: 1000),
      }) {
    if (debouncer != null) {
      debouncer!.cancel();
    }
    debouncer = Timer(duration, callback);
  }

  Future init() async {
    final schools = await manager.listSchool(query);
    setState(() => this.schools = schools);
  }

  @override
  Widget build(BuildContext context) {
    final styleActive = TextStyle(color: Colors.black);
    final styleHint = TextStyle(color: Colors.black54);
    final style = query.isEmpty ? styleHint : styleActive;
    return Scaffold(
      appBar: AppBar(
        // The search area here
          backgroundColor: Colors.amber,
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () {
                      if(Firstname != ""){
                        Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => const  MyHomePage(indexScreen: null,)));
                      }else{
                        Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => const LoginPage()));
                      }

              }
          ),
          title:
            Container(
            width: double.infinity,
            height: 40,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(5)),
            child: Center(
              child: TextField(
                controller: controller,
                onChanged: searchSchool,
                decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: query.isNotEmpty ? GestureDetector(
                        child: IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            controller.clear();
                            searchSchool('');
                            FocusScope.of(context).requestFocus(FocusNode());
                          },
                        )) : null,
                    hintText: 'Search...',
                    hintStyle: style,
                    border: InputBorder.none),
              ),
            ),
          )
      ),

      body: Column(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: schools.length,
                itemBuilder: (context, index) {
                  final school = schools[index];
                  return buildSchool(school);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future searchSchool(String query) async => debounce(() async {
    final schools = await manager.listSchool(query);
    if (!mounted) return;
    setState(() {
      this.query = query;
      this.schools = schools;
    });
  });

  Widget buildSchool(School school) {
    return ListTile(
        title: Text(school.school_name),
        onTap:(){
          Navigator.push(context, PageTransition(type: PageTransitionType.rightToLeft, duration : const Duration(milliseconds: 150),reverseDuration : const Duration(milliseconds: 150),
              child: List_SearchSchoolBus(title: school.school_name,)));
        }
      );
  }
}