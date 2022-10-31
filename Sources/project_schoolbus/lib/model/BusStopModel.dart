
import 'package:project_schoolbus/model/BusModel.dart';
import 'package:project_schoolbus/model/SchoolModel.dart';

class BusStop{
  late String bus_stop_ID;
  DateTime? stop_time;
  late String bus_stop_latitude;
  late String bus_stop_longitude;
  late Bus bus;
  late School school;

  BusStop(this.stop_time, this.bus_stop_longitude,this.school);

  BusStop.fromJson(Map<String, dynamic> json)
      : bus_stop_ID = json['bus_stop_ID'],
        stop_time = json['stop_time'] == null ? null : DateTime.parse(json['stop_time']),
        bus_stop_latitude = json['bus_stop_latitude']??"",
        bus_stop_longitude = json['bus_stop_longitude']??"",
        bus = Bus.fromJson(json['bus']),
        school = School.fromJson(json['school']);

  Map<String, dynamic> toMap(){
    // JSON
    // Map<String, String> หมายถึง Map<Key, value>
    // map[key] = value
    // id = map[columnId] ซึ่ง columnId คือ key จะได้ value ออกมาเป็น id
    return{
      'bus_stop_ID': bus_stop_ID,
      'stop_time': stop_time,
      'bus_stop_latitude': bus_stop_latitude,
      'bus_stop_longitude': bus_stop_longitude,
      'bus': bus.toMap(),
      'school': school.toMap(),
    };
  }

  @override
  String toString() {
    return 'BusStop{bus_stop_ID: $bus_stop_ID, stop_time: $stop_time, bus_stop_latitude: $bus_stop_latitude, bus_stop_longitude: $bus_stop_longitude, bus: $bus, school: $school}';
  }
}