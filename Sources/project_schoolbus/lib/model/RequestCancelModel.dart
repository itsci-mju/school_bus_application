import 'ContractModel.dart';

class RequestCancel {
  late String request_ID;
  late DateTime request_date;
  DateTime? approve_date;
  late String reason;
  late int status_request;
  late Contract contract;

  RequestCancel(this.request_ID, this.request_date, this.approve_date,
      this.reason, this.status_request, this.contract);

  RequestCancel.fromJson(Map<String, dynamic> json)
      : request_ID = json['request_ID'],
        request_date = DateTime.parse(json['request_date']),
        approve_date = json['approve_date'] == null ?  null : DateTime.parse(json['approve_date']),
        reason = json['reason'],
        status_request = json['status_request'],
        contract = Contract.fromJson(json['contract']);


  Map<String, dynamic> toMap() {
    // JSON
    // Map<String, String> หมายถึง Map<Key, value>
    // map[key] = value
    // id = map[columnId] ซึ่ง columnId คือ key จะได้ value ออกมาเป็น id

    return {
      'request_ID': request_ID,
      'request_date': request_date.toString(),
      'approve_date': approve_date.toString(),
      'reason': reason,
      'status_request': status_request,
      'contract': contract.toMap(),
    };
  }

  @override
  String toString() {
    return 'RequestCancel{request_ID: $request_ID, request_date: $request_date, approve_date: $approve_date, reason: $reason, status_request: $status_request, contract: $contract}';
  }
}
