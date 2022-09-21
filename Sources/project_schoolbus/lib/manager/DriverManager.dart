

import 'package:http/http.dart' as http;

import '../importer.dart';


class DriverManager{

  Future<String> doRegisrerDriver(Bus bus) async {
    final response = await http.post(
      Uri.parse(Strings.url+Strings.RegisterDriver),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'bus': jsonEncode(bus.toMap()),
      }),
    );

    if (response.statusCode == 200) {

      ResponseModel responseModel = ResponseModel.fromJson(jsonDecode(response.body));
      String result = responseModel.result.toString();
      return result;
    } else {
      throw Exception('Failed to RegisterDriver');
    }
  }

  Future<Driver> getProfileDriver(String IDCard) async {
    final response = await http.post(
      Uri.parse(Strings.url+Strings.getProfileDriver),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'IDCard': IDCard,
      }),
    );

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      ResponseModel responseModel = ResponseModel.fromJson(jsonDecode(response.body));
      Map<String, dynamic> driverMap = responseModel.toMap();
      Driver driver = Driver.fromJson(driverMap['result']);
      var logger = Logger();
      logger.e("ProfileDriver : "+driver.toString());

      return driver;
    } else {
      throw Exception('Failed to get Driver');
    }
  }

  Future<String> editProfileDriver(Bus bus) async {
    final response = await http.post(
      Uri.parse(Strings.url+Strings.editProfileDriver),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'bus': jsonEncode(bus.toMap()),
      }),
    );

    if (response.statusCode == 200) {

      ResponseModel responseModel = ResponseModel.fromJson(jsonDecode(response.body));
      String result = responseModel.result.toString();
      return result;
    } else {
      throw Exception('Failed to EditProfileDriver');
    }
  }

  Future<Bus> getBusDetails(String driverId) async {
    final response = await http.post(
      Uri.parse(Strings.url+Strings.getBusdetailsByDriverId),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'driverId': driverId,
      }),
    );

    if (response.statusCode == 200) {
      ResponseModel responseModel = ResponseModel.fromJson(jsonDecode(response.body));
      var log = Logger();
      Map<String, dynamic> busMap = responseModel.toMap();
      Bus bus = Bus.fromJson(busMap['result']);
      log.e("ข้อมูลรถ : "+bus.toString());
      return bus;
    } else {
      throw Exception('Failed to getBusDetails');
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

  Future<String> calChildrensInCar(String num_plate) async {
    final response = await http.post(
      Uri.parse(Strings.url+Strings.calChildrensInCar),
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
      String result = responseModel.result.toString() ;
      log.e(result);
      return result;
    } else {
      throw Exception('Failed to calChildrensInCar');
    }
  }

  Future<String> updateService(Bus bus) async {
    final response = await http.post(
      Uri.parse(Strings.url+Strings.updateService),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'bus': jsonEncode(bus.toMap()),
      }),
    );

    if (response.statusCode == 200) {

      ResponseModel responseModel = ResponseModel.fromJson(jsonDecode(response.body));
      String result = responseModel.result.toString();
      return result;
    } else {
      throw Exception('Failed to UpdateService');
    }
  }

  Future<String> updateBuslocation(Bus bus) async {
    final response = await http.post(
      Uri.parse(Strings.url+Strings.Busupdatelocation),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'bus': jsonEncode(bus.toMap()),
      }),
    );

    if (response.statusCode == 200) {

      ResponseModel responseModel = ResponseModel.fromJson(jsonDecode(response.body));
      String result = responseModel.result.toString();
      return result;
    } else {
      throw Exception('Failed to updateBuslocation');
    }
  }

  Future<String> updatelocationbus(Bus bus) async {
    final response = await http.post(
      Uri.parse(Strings.url+Strings.updateService),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'bus': jsonEncode(bus.toMap()),
      }),
    );

    if (response.statusCode == 200) {

      ResponseModel responseModel = ResponseModel.fromJson(jsonDecode(response.body));
      String result = responseModel.result.toString();
      return result;
    } else {
      throw Exception('Failed to UpdateService');
    }
  }

}