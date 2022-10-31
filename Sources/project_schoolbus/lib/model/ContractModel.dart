
import 'dart:ffi';

import 'ChildrenModel.dart';
import 'BusStopModel.dart';

class Contract {
  late String contract_ID;
  late DateTime contract_date;
  late DateTime start_date;
  late DateTime end_date;
  late String pick_up_latitude;
  late String pick_up_longitude;
  late String school_name;
  late double euclidean;
  DateTime? approve_date;
  late int status;
  late Children children;
  late BusStop busStop;

  Contract(
      this.contract_ID,
      this.contract_date,
      this.start_date,
      this.end_date,
      this.pick_up_latitude,
      this.pick_up_longitude,
      this.school_name,
      this.euclidean,
      this.approve_date,
      this.status,
      this.children,
      this.busStop);


  Contract.fromJson(Map<String, dynamic> json)
      : contract_ID = json['contract_ID']  ?? "",
        contract_date = DateTime.parse(json['contract_date']) ,
        start_date = DateTime.parse(json['start_date']) ,
        end_date = DateTime.parse(json['end_date']) ,
        pick_up_latitude = json['pick_up_latitude'] ?? "",
        pick_up_longitude = json['pick_up_longitude']?? "",
        school_name = json['school_name']?? "",
        euclidean = json['euclidean']?? 0.0,
        approve_date = json['approve_date'] == null ? null : DateTime.parse(json['approve_date']),
        status = json['status'] ?? 0,
        children =  Children.fromJson(json['children']) ,
        busStop = BusStop.fromJson(json['busStop']);

  Map<String, dynamic> toMap() {
    // JSON
    // Map<String, String> หมายถึง Map<Key, value>
    // map[key] = value
    // id = map[columnId] ซึ่ง columnId คือ key จะได้ value ออกมาเป็น id

    return {
      'contract_ID': contract_ID,
      'contract_date': contract_date.toString(),
      'start_date': start_date.toString(),
      'end_date': end_date.toString(),
      'pick_up_latitude': pick_up_latitude,
      'pick_up_longitude': pick_up_longitude,
      'school_name': school_name,
      'euclidean': euclidean,
      'approve_date': approve_date.toString(),
      'status': status,
      'children': children.toMap(),
      'busStop': busStop.toMap(),
    };
  }

  @override
  String toString() {
    return 'Contract{contract_ID: $contract_ID, contract_date: $contract_date, start_date: $start_date, end_date: $end_date, pick_up_latitude: $pick_up_latitude, pick_up_longitude: $pick_up_longitude, school_name: $school_name, euclidean: $euclidean, approve_date: $approve_date, status: $status, children: $children, busStop: $busStop}';
  }
}