
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import '../model/ParentModel.dart';
import '../ResponseModel.dart';
import 'package:http/http.dart' as http;
import '../String.dart';
import '../model/LoginModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginManager {
  LoginManager();

  Future<String> doLogin(String username,String password) async {
    final response = await http.post(
        Uri.parse(Strings.url+Strings.verifyLogin),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'username': username,
          'password': password,
        }),
    );

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      ResponseModel responseModel = ResponseModel.fromJson(jsonDecode(response.body));
      String result = responseModel.result.toString();
      return result;
    } else {
      throw Exception('Failed to Login');
    }
  }

  Future<ResponseModel> getProfileByUsername(String username,String password,String type) async {
    final response = await http.post(
      Uri.parse(Strings.url+Strings.getProfileByUsername),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': username,
        'password': password,
        'type': type,
      }),
    );

    if (response.statusCode == 200) {
      ResponseModel responseModel = ResponseModel.fromJson(jsonDecode(response.body));

      return responseModel;
    } else {
      throw Exception('Failed to getProfile');
    }
  }
}