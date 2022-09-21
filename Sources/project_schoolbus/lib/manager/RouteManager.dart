import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import '../ResponseModel.dart';
import '../String.dart';
import '../model/RouteModel.dart';


class RouteManager{
  RouteManager();

  Future<String> doAddRoute(Routes routes) async {
    final response = await http.post(
      Uri.parse(Strings.url+Strings.add_Route),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'routes': jsonEncode(routes.toMap()),
      }),
    );

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      ResponseModel responseModel = ResponseModel.fromJson(jsonDecode(response.body));
      var logger = Logger();
      logger.e(responseModel.toString());
      String result = responseModel.result.toString();
      logger.e(result.toString());

      return result;
    } else {
      throw Exception('Failed to doAddContract');
    }
  }

  Future<List<Routes>> listRoute() async {
    final response = await http
        .post(Uri.parse(Strings.url+Strings.list_Route));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      ResponseModel responseModel = ResponseModel.fromJson(jsonDecode(response.body));
      var logger = Logger();
      List<Routes> listRoute = (responseModel.result as List).map((item) => Routes.fromJson(item)).toList();
      logger.e(listRoute.toString());

      return listRoute;
    } else {
      throw Exception('Failed to getlistRoute');
    }
  }

  Future<List<Routes>> getListSearch(String school_name) async {
    final response = await http.post(
      Uri.parse(Strings.url+Strings.getListSearch),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'school_name': school_name,
      }),
    );

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      ResponseModel responseModel = ResponseModel.fromJson(jsonDecode(response.body));
      var logger = Logger();
      List<Routes> listRoute = (responseModel.result as List).map((item) => Routes.fromJson(item)).toList();
      logger.e(listRoute.toString());

      return listRoute;
    } else {
      throw Exception('Failed to getlistRoute');
    }
  }

  Future<List<Routes>> getSchoolBusDetails(String num_plate) async {
    final response = await http
        .post(Uri.parse(Strings.url+Strings.getschoolbusdetails),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'num_plate': num_plate,
      }),
    );

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      ResponseModel responseModel = ResponseModel.fromJson(jsonDecode(response.body));
      List<Routes> listRoute = (responseModel.result as List).map((item) => Routes.fromJson(item)).toList();
      var logger = Logger();
      logger.e("DetailsBus : "+listRoute.toString());

      return listRoute;
    } else {
      throw Exception('Failed to getSchoolBusDetails');
    }
  }

  Future<List<Routes>> getRouteBySchoolID(String num_plate,String school_ID) async {
    final response = await http
        .post(Uri.parse(Strings.url+Strings.getRouteBySchoolID),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'num_plate': num_plate,
        'school_ID': school_ID,
      }),
    );

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      ResponseModel responseModel = ResponseModel.fromJson(jsonDecode(response.body));
      List<Routes> listRoute = (responseModel.result as List).map((item) => Routes.fromJson(item)).toList();
      var logger = Logger();
      logger.e("DetailsBus : "+listRoute.toString());

      return listRoute;
    } else {
      throw Exception('Failed to getRouteBySchoolID');
    }
  }

  Future<List<Routes>> getRouteBySchoolName(String num_plate,String school_name) async {
    final response = await http
        .post(Uri.parse(Strings.url+Strings.getRouteBySchoolName),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'num_plate': num_plate,
        'school_name': school_name,
      }),
    );

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      ResponseModel responseModel = ResponseModel.fromJson(jsonDecode(response.body));
      List<Routes> listRoute = (responseModel.result as List).map((item) => Routes.fromJson(item)).toList();
      var logger = Logger();
      logger.e("DetailsBus : "+listRoute.toString());

      return listRoute;
    } else {
      throw Exception('Failed to getRouteBySchoolName');
    }
  }

  Future<List> getCalDetails(String num_plate) async {
    final response = await http.post(
      Uri.parse(Strings.url+Strings.calDetails),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'num_plate': num_plate,
      }),
    );

    if (response.statusCode == 200) {

      ResponseModel responseModel = ResponseModel.fromJson(jsonDecode(response.body));
      var log = Logger();
      log.e(responseModel.result);
      List result = responseModel.result as List ;
      return result;
    } else {
      throw Exception('Failed to calDetails');
    }
  }
}