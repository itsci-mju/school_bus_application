
import 'package:http/http.dart' as http;
import '../importer.dart';
import '../model/ContractModel.dart';
import '../model/RequestCancelModel.dart';


class ContractManager{
  Future<List<Contract>> getListApproved(String IDCard) async {
    final response = await http.post(
      Uri.parse(Strings.url+Strings.getListApproved),
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
      var logger = Logger();
      logger.e(responseModel.toString());
      List<Contract> listContracts = (responseModel.result as List).map((item) => Contract.fromJson(item)).toList();
      logger.e(listContracts.toString());

      return listContracts;
    } else {
      throw Exception('Failed to getListApproved');
    }
  }

  Future<String> doAddContract(Contract contract) async {
    final response = await http.post(
      Uri.parse(Strings.url+Strings.requestContract),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'contract': jsonEncode(contract.toMap()),
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

  Future<List<Contract>> getListUnApproved(String IDCard) async {
    final response = await http.post(
      Uri.parse(Strings.url+Strings.getListUnApproved),
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
      var logger = Logger();
      logger.e(responseModel.toString());
      List<Contract> listContracts = (responseModel.result as List).map((item) => Contract.fromJson(item)).toList();
      logger.e(listContracts.toString());

      return listContracts;
    } else {
      throw Exception('Failed to getListUnApproved');
    }
  }

  Future<List<Contract>> getListOther(String IDCard) async {
    final response = await http.post(
      Uri.parse(Strings.url+Strings.getListOther),
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
      var logger = Logger();
      logger.e(responseModel.toString());
      List<Contract> listContracts = (responseModel.result as List).map((item) => Contract.fromJson(item)).toList();
      logger.e(listContracts.toString());

      return listContracts;
    } else {
      throw Exception('Failed to getListOther');
    }
  }

  Future<Contract> getContractDetails(String contract_ID) async {
    final response = await http.post(
      Uri.parse(Strings.url+Strings.getContractDetails),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'contract_ID': contract_ID,
      }),
    );

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      ResponseModel responseModel = ResponseModel.fromJson(jsonDecode(response.body));
      var logger = Logger();
      Map<String, dynamic> childrenMap = responseModel.toMap();
      Contract contract = Contract.fromJson(childrenMap['result']);
      logger.e(contract.toString());

      return contract;
    } else {
      throw Exception('Failed to getContractDetails');
    }
  }

  Future<List<Contract>> getContractDetailsbychildren(String childrenid) async {
    final response = await http.post(
      Uri.parse(Strings.url+Strings.getContractDetailsbychildrenid),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'childrenid': childrenid,
      }),
    );
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      ResponseModel responseModel = ResponseModel.fromJson(jsonDecode(response.body));
      var logger = Logger();
      logger.e(responseModel.toString());
      List<Contract> listContracts = (responseModel.result as List).map((item) => Contract.fromJson(item)).toList();
      logger.e(listContracts.toString());

      return listContracts;
    } else {
      throw Exception('Failed to getContractDetails');
    }
  }

  Future<String> deleteContract(String contract_ID) async {
    final response = await http.post(
      Uri.parse(Strings.url+Strings.deleteContract),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'contract_ID': contract_ID,
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
      throw Exception('Failed to deleteContract');
    }
  }

  Future<String> requestCancel(RequestCancel requestCancel) async {
    final response = await http.post(
      Uri.parse(Strings.url+Strings.requestCancel),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'requestCancel': jsonEncode(requestCancel.toMap()),
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
      throw Exception('Failed to requestCancel');
    }
  }


  //*************************** Driver ****************************

  Future<List<Contract>> driver_getListUnApproved(String num_plate) async {
    final response = await http.post(
      Uri.parse(Strings.url+Strings.driver_listUnApproved),
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
      var logger = Logger();
      logger.e(responseModel.toString());
      List<Contract> listContracts = (responseModel.result as List).map((item) => Contract.fromJson(item)).toList();
      logger.e(listContracts.toString());

      return listContracts;
    } else {
      throw Exception('Failed to getListUnApproved');
    }
  }

  Future<List<RequestCancel>> driver_requestCancel(String num_plate) async {
    final response = await http.post(
      Uri.parse(Strings.url+Strings.driver_requestCancel),
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
      var logger = Logger();
      logger.e(responseModel.toString());
      List<RequestCancel> requests = (responseModel.result as List).map((item) => RequestCancel.fromJson(item)).toList();
      logger.e(requests.toString());

      return requests;
    } else {
      throw Exception('Failed to getRequestCancel');
    }
  }

  Future<RequestCancel> driver_getrequestCancel(String request_ID) async {
    final response = await http.post(
      Uri.parse(Strings.url+Strings.driver_getRequestCancel),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'request_ID': request_ID,
      }),
    );

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      ResponseModel responseModel = ResponseModel.fromJson(jsonDecode(response.body));
      var logger = Logger();
      Map<String, dynamic> requestMap = responseModel.toMap();
      RequestCancel request = RequestCancel.fromJson(requestMap['result']);
      logger.e(request.toString());

      return request;
    } else {
      throw Exception('Failed to getRequestCancel');
    }
  }

  Future<String> approveRequestCancel(String contract_ID) async {
    final response = await http.post(
      Uri.parse(Strings.url+Strings.driver_ApproveRequestCancel),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'contract_ID': contract_ID,
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
      throw Exception('Failed to approveRequestCancel');
    }
  }

  Future<String> driver_ApproveApplication(String contract_ID,String approve_date) async {
  final response = await http.post(
    Uri.parse(Strings.url+Strings.driver_ApproveApplication),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'contract_ID': contract_ID,
      'approve_date': approve_date,
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
    throw Exception('Failed to ApproveApplication');
  }
  }

  Future<List<Contract>> driver_listChildren(String num_plate) async {
    final response = await http.post(
      Uri.parse(Strings.url+Strings.driver_listChildren),
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
      var logger = Logger();
      logger.e(responseModel.toString());
      List<Contract> listContracts = (responseModel.result as List).map((item) => Contract.fromJson(item)).toList();
      logger.e(listContracts.toString());

      return listContracts;
    } else {
      throw Exception('Failed to getListChildren');
    }
  }


  Future<List<Contract>> driver_listChildren1(String num_plate) async {
    final response = await http.post(
      Uri.parse(Strings.url+Strings.driver_listChildren1),
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
      var logger = Logger();
      logger.e(responseModel.toString());
      List<Contract> listContracts = (responseModel.result as List).map((item) => Contract.fromJson(item)).toList();
      logger.e(listContracts.toString());

      return listContracts;
    } else {
      throw Exception('Failed to getListChildren');
    }
  }

  Future<List<Contract>> driver_listChildren2(String num_plate) async {
    final response = await http.post(
      Uri.parse(Strings.url+Strings.driver_listChildren2),
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
      var logger = Logger();
      logger.e(responseModel.toString());
      List<Contract> listContracts = (responseModel.result as List).map((item) => Contract.fromJson(item)).toList();
      logger.e(listContracts.toString());

      return listContracts;
    } else {
      throw Exception('Failed to getListChildren');
    }
  }
  Future<String> driver_UnApproveApplication(String contract_ID,String approve_date) async {
    final response = await http.post(
      Uri.parse(Strings.url+Strings.driver_UnApproveApplication),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'contract_ID': contract_ID,
        'approve_date': approve_date,
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
      throw Exception('Failed to UnApproveApplication');
    }
  }

  //*************************** Driver ****************************
}