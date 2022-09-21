import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:http/http.dart';

class Linenoti {
static const String _url = 'https://script.google.com/macros/s/AKfycbxGprjn3lpBAxt0aiCI8gP3kiWJYhrJNz7wVh_cpWEV0H90WwgCZKSloEHgMF8lhE0j/exec?';
  String? token = 'zv8SICxBxw4gIl8g9i3Y9imqWGmV7WxBm9CCwgalQS5';
  String? messagefrom = 'MJU SchoolBus';

  Linenoti();

  send({required String message,}) async {
  final response = await http
      .get(Uri.parse(_url+"lntoken="+token!+"&messagefrom="+messagefrom!+"&message="+message));
  
}

}