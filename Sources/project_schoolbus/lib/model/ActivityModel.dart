import '../importer.dart';
import 'ContractModel.dart';

class Activity{
  late String activity_ID ;
  late String get_up_latitude ;
  late String get_up_longitude ;
  late String get_up_time ;
  late String get_off_latitude ;
  late String get_off_longitude;
  late String get_off_time  ;
  late String reason ;
  late int time_of_date ;
  late String status_children ;
  late Contract contract ;

  Activity(
      this.activity_ID,
      this.get_up_latitude,
      this.get_up_longitude,
      this.get_up_time,
      this.get_off_latitude,
      this.get_off_longitude,
      this.get_off_time,
      this.reason,
      this.time_of_date,
      this.status_children,
      this.contract);

  Activity.fromJson(Map<String, dynamic> json)
      : activity_ID = json['activity_ID'],
        get_up_latitude = json['get_up_latitude'],
        get_up_longitude = json['get_up_longitude'],
        get_up_time = json['get_up_time'],
        get_off_latitude = json['get_off_latitude'],
        get_off_longitude = json['get_off_longitude'],
        get_off_time = json['get_off_time'],
        reason = json['reason'],
        time_of_date = json['time_of_date'],
        status_children = json['status_children'],
        contract = Contract.fromJson(json['Contract_contract_ID']);

  Map<String, dynamic> toMap() {
    // JSON
    // Map<String, String> หมายถึง Map<Key, value>
    // map[key] = value
    // id = map[columnId] ซึ่ง columnId คือ key จะได้ value ออกมาเป็น id

    return {
      'activity_ID': activity_ID,
      'get_up_latitude': get_up_latitude,
      'get_up_longitude': get_up_longitude,
      'get_up_time': get_up_time,
      'get_off_latitude': get_off_latitude,
      'get_off_longitude': get_off_longitude,
      'get_off_time': get_off_time,
      'reason': reason,
      'time_of_date': time_of_date,
      'status_children': status_children,
      'Contract_contract_ID': contract==null?null :contract.toMap()
    };
  }

  @override
  String toString() {
    return 'Activity{activity_ID: $activity_ID, get_up_latitude: $get_up_latitude, get_up_longitude: $get_up_longitude, get_up_time: $get_up_time, get_off_latitude: $get_off_latitude, get_off_longitude: $get_off_longitude, get_off_time: $get_off_time, reason: $reason, time_of_date: $time_of_date, status_children: $status_children, contract: $contract}';
  }
}