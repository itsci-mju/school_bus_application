
import 'package:project_schoolbus/model/BusModel.dart';
import 'package:project_schoolbus/model/SchoolModel.dart';

class Routes{
  late String route_ID;
  late String route_details;
  late String route_mapURL;
  late Bus bus;
  late School school;

  Routes(this.route_details, this.route_mapURL,this.school);

  Routes.fromJson(Map<String, dynamic> json)
      : route_ID = json['route_ID'],
        route_details = json['route_details'],
        route_mapURL = json['route_mapURL'],
        bus = Bus.fromJson(json['bus']),
        school = School.fromJson(json['school']);

  Map<String, dynamic> toMap(){
    // JSON
    // Map<String, String> หมายถึง Map<Key, value>
    // map[key] = value
    // id = map[columnId] ซึ่ง columnId คือ key จะได้ value ออกมาเป็น id
    return{
      'route_ID': route_ID,
      'route_details': route_details,
      'route_mapURL': route_mapURL,
      'bus': bus.toMap(),
      'school': school.toMap(),
    };
  }

  @override
  String toString() {
    return 'Route{route_ID: $route_ID, route_details: $route_details, route_mapURL: $route_mapURL, bus: $bus, school: $school}';
  }
}