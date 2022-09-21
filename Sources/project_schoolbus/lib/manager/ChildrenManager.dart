
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'dart:convert';

import '../ResponseModel.dart';
import '../String.dart';
import '../model/ChildrenModel.dart';

class ChildrenManager{
  ChildrenManager();

  Future<List<Children>> listChildrenByParentId(String parentId) async  {
    final response = await http.post(
      Uri.parse(Strings.url+Strings.list_childrenbyParentId),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'parentId': parentId,
      }),
    );
    if (response.statusCode == 200) {
      var logger = Logger();
      ResponseModel responseModel = ResponseModel.fromJson(jsonDecode(response.body));
      List<Children> listchildren = (responseModel.result as List).map((item) => Children.fromJson(item)).toList();
      logger.e("ProfileChildren : "+listchildren.toString());
      return listchildren;
    } else {
      throw Exception('Failed to get listchildren.');
    }
  }

  Future<List<Children>> listChildrenApply(String parentId) async  {
    final response = await http.post(
      Uri.parse(Strings.url+Strings.list_childrenApply),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'parentId': parentId,
      }),
    );
    if (response.statusCode == 200) {
      var logger = Logger();
      ResponseModel responseModel = ResponseModel.fromJson(jsonDecode(response.body));
      List<Children> listchildren = (responseModel.result as List).map((item) => Children.fromJson(item)).toList();
      logger.e("ProfileChildren : "+listchildren.toString());
      return listchildren;
    } else {
      throw Exception('Failed to get listchildren.');
    }
  }

  Future<Children> getChildrenById(String IDCard) async  {
    final response = await http.post(
      Uri.parse(Strings.url+Strings.getProfileChildren),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'IDCard': IDCard,
      }),
    );
    if (response.statusCode == 200) {
      ResponseModel responseModel = ResponseModel.fromJson(jsonDecode(response.body));
      Map<String, dynamic> childrenMap = responseModel.toMap();
      Children children = Children.fromJson(childrenMap['result']);
      var logger = Logger();
      logger.e("ProfileChildren : "+children.toString());
      return children;
    } else {
      throw Exception('Failed to get children.');
    }
  }

  Future<String> DeleteChildrenById(String IDCard) async  {
    var logger = Logger();
    final response = await http.post(
      Uri.parse(Strings.url+Strings.deletechildrenbyId),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'IDCard': IDCard,
      }),
    );
    logger.e(response.body);
    if (response.statusCode == 200) {
      ResponseModel responseModel = ResponseModel.fromJson(jsonDecode(response.body));

      String result = responseModel.result.toString();
      logger.e(result);

      return result;
    } else {
      throw Exception('Failed to get listchildren.');
    }
  }

  Future<String> editChildrenById(Children children) async  {
    var logger = Logger();
    final response = await http.post(
      Uri.parse(Strings.url+Strings.editChildren),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'children': jsonEncode(children.toMap()),
      }),
    );
    logger.e(response.body);
    if (response.statusCode == 200) {
      ResponseModel responseModel = ResponseModel.fromJson(jsonDecode(response.body));

      String result = responseModel.result.toString();
      logger.e(result);

      return result;
    } else {
      throw Exception('Failed to get listchildren.');
    }
  }

  Future<String> addChildren(Children children) async  {
    var logger = Logger();
    final response = await http.post(
      Uri.parse(Strings.url+Strings.addChildren),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'children': jsonEncode(children.toMap()),
      }),
    );
    logger.e(response.body);
    if (response.statusCode == 200) {
      ResponseModel responseModel = ResponseModel.fromJson(jsonDecode(response.body));

      String result = responseModel.result.toString();
      logger.e(result);

      return result;
    } else {
      throw Exception('Failed to addChildren.');
    }
  }

}
