

import 'package:http/http.dart' as http;
import '../importer.dart';


class SchoolManager{

  Future<List<School>> listSchool(String query) async {
    final response = await http
        .post(Uri.parse(Strings.url+Strings.getlistSchool));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      ResponseModel responseModel = ResponseModel.fromJson(jsonDecode(response.body));
      var logger = Logger();
      List<School> listSchool = (responseModel.result as List).map((item) => School.fromJson(item)).toList();
      logger.e(listSchool.toString());


      return listSchool.map((json) => School.fromJson(json.toMap())).where((school) {
        final school_name = school.school_name;
        final searchtxt = query;

        return school_name.contains(searchtxt);
      }).toList();

    } else {
      throw Exception('Failed to getlistSchool');
    }
  }

  Future<School> getSchool(String school_ID) async {
    final response = await http.post(
      Uri.parse(Strings.url+Strings.getSchool),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'school_ID': school_ID,
      }),
    );

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      ResponseModel responseModel = ResponseModel.fromJson(jsonDecode(response.body));
      Map<String, dynamic> schoolMap = responseModel.toMap();
      School school = School.fromJson(schoolMap['result']);
      var logger = Logger();
      logger.e("School : "+school.toString());

      return school;
    } else {
      throw Exception('Failed to get School');
    }
  }

  Future<List<School>> listSchoolDriver() async {
    final response = await http
        .post(Uri.parse(Strings.url+Strings.getlistSchool));

    if (response.statusCode == 200) {
      ResponseModel responseModel = ResponseModel.fromJson(jsonDecode(response.body));
      List<School> listSchool = (responseModel.result as List).map((item) => School.fromJson(item)).toList();
      var logger = Logger();
      logger.e(listSchool.toString());

      return listSchool;
    } else {
      throw Exception('Failed to load data List School');
    }
  }

}