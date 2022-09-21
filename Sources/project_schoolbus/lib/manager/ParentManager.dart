
import 'dart:convert';

import 'package:logger/logger.dart';

import '../model/ParentModel.dart';
import '../ResponseModel.dart';
import 'package:http/http.dart' as http;

import '../String.dart';

class ParentManager{
  ParentManager();
  Future<List<Parent>> listparent() async {
    final response = await http
        .get(Uri.parse(Strings.url+Strings.list_parent));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      ResponseModel responseModel = ResponseModel.fromJson(jsonDecode(response.body));
      List<Parent> listparent = (responseModel.result as List).map((item) => Parent.fromJson(item)).toList();
      var logger = Logger();
      logger.e(listparent.toString());

      return listparent;
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<String> doRegisrer(Parent parent) async {
    final response = await http.post(
      Uri.parse(Strings.url+Strings.RegisterParent),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'parent': jsonEncode(parent.toMap()),
      }),
    );

    if (response.statusCode == 200) {

      ResponseModel responseModel = ResponseModel.fromJson(jsonDecode(response.body));
      String result = responseModel.result.toString();
      return result;
    } else {
      throw Exception('Failed to Register');
    }
  }

  Future<Parent> getParent(String username,String type) async {
    final response = await http.post(
      Uri.parse(Strings.url+Strings.getProfileByUsername),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': username,
        'type': type,
      }),
    );

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      ResponseModel responseModel = ResponseModel.fromJson(jsonDecode(response.body));
      Map<String, dynamic> parentMap = responseModel.toMap();
      Parent parent = Parent.fromJson(parentMap['result']);
      var logger = Logger();
      logger.e("ProfileParent : "+parent.toString());

      return parent;
    } else {
      throw Exception('Failed to get Parent');
    }
  }

  Future<String> editProfile(Parent parent) async {
    final response = await http.post(
      Uri.parse(Strings.url+Strings.editParent),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'parent': jsonEncode(parent.toMap()),
      }),
    );

    if (response.statusCode == 200) {

      ResponseModel responseModel = ResponseModel.fromJson(jsonDecode(response.body));
      String result = responseModel.result.toString();
      return result;
    } else {
      throw Exception('Failed to EditProfile');
    }
  }

}



