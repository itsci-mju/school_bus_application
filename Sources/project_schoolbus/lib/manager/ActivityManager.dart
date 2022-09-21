import 'package:http/http.dart' as http;
import '../importer.dart';
import '../model/ActivityModel.dart';

class ActivityManager{
  ActivityManager();
  Future<String> doAddActivity(Activity activity) async {
    print(activity.contract.toString());
    final response = await http.post(
      Uri.parse(Strings.url+Strings.add_activity),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'activity': jsonEncode(activity.toMap()),
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
      throw Exception('Failed to doAddActivity');
    }
  }

  Future<List<Activity>> listActivitytime1() async  {
    final response = await http.post(
      Uri.parse(Strings.url+Strings.listActivitytime1),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode == 200) {
      var logger = Logger();
      ResponseModel responseModel = ResponseModel.fromJson(jsonDecode(response.body));
      List<Activity> listActivity= (responseModel.result as List).map((item) => Activity.fromJson(item)).toList();
      logger.e("ProfileActivity: "+listActivity.toString());
      return listActivity;
    } else {
      throw Exception('Failed to get listActivity.');
    }
  }

  Future<List<Activity>> getlistActivityById(String contract_ID) async {
    final response = await http.post(
      Uri.parse(Strings.url + Strings.activitylistById),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'contract_ID': contract_ID,
      }),
    );
    if (response.statusCode == 200) {
      var logger = Logger();
      ResponseModel responseModel = ResponseModel.fromJson(jsonDecode(response.body));
      List<Activity> listActivity= (responseModel.result as List).map((item) => Activity.fromJson(item)).toList();
      logger.e("ProfileActivity: "+listActivity.toString());
      return listActivity;
    } else {
      throw Exception('Failed to get listActivity.');
    }
  }

  Future<List<Activity>> listActivitytime2() async  {
    final response = await http.post(
      Uri.parse(Strings.url+Strings.listActivitytime2),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode == 200) {
      var logger = Logger();
      ResponseModel responseModel = ResponseModel.fromJson(jsonDecode(response.body));
      List<Activity> listActivity= (responseModel.result as List).map((item) => Activity.fromJson(item)).toList();
      logger.e("ProfileActivity: "+listActivity.toString());
      return listActivity;
    } else {
      throw Exception('Failed to get listActivity.');
    }
  }

  Future<List<Activity>> listActivitytimeday1() async  {
    final response = await http.post(
      Uri.parse(Strings.url+Strings.activitylistday),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode == 200) {
      var logger = Logger();
      ResponseModel responseModel = ResponseModel.fromJson(jsonDecode(response.body));
      List<Activity> listActivity= (responseModel.result as List).map((item) => Activity.fromJson(item)).toList();
      logger.e("ProfileActivity: "+listActivity.toString());
      return listActivity;
    } else {
      throw Exception('Failed to get listActivity.');
    }
  }

  Future<String> editActivity(Activity activity) async  {
    var logger = Logger();
    final response = await http.post(
      Uri.parse(Strings.url+Strings.updateactivity),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'activity': jsonEncode(activity.toMap()),
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

}