import 'package:shared_preferences/shared_preferences.dart';

class getSharedPreferences {
  getSharedPreferences();
  static SharedPreferences? prefs;

  static const _keyUsername = 'username';
  static const _keyProfile = 'profile';
  static const _keyType = 'type';
  static const _keyIDCard = 'IDCard';
  static const _keyFirstname = 'firstname';
  static const _keyLastname = 'lastname';
  static const _keyIDCardChildren = 'IDCardChildren';
  static const _keyNum_plate = 'num_plate';
  static const _keyLatitude = 'Latitude';
  static const _keyLongitude = 'Longitude';
  static const _keyAddress = 'Address';
  static const _keyListRoute = 'ListRoute';
  static const _keyBus = 'Bus';
  static const _keyContractID = 'ContractID';
  static const _keyContract = 'Contract';
  static const _keyNumPage = 'NumPage';
  static const _keyRequestID = 'RequestID';
  static const _keySchoolID = 'SchoolID';
  static const _keyDeiverID = 'DeiverID';



  static Future init() async =>
      prefs = await SharedPreferences.getInstance();

  static Future setDeiverID(String username) async =>
      await prefs!.setString(_keyDeiverID, username);

  static String? getDeiverID() => prefs?.getString(_keyDeiverID);

  static Future setUsername(String username) async =>
      await prefs!.setString(_keyUsername, username);

  static String? getUsername() => prefs?.getString(_keyUsername);

  static Future setProfile(String profile) async =>
      await prefs!.setString(_keyProfile, profile);

  static String? getProfile() => prefs?.getString(_keyProfile);

  static Future setIDCard(String IDCard) async =>
      await prefs!.setString(_keyIDCard, IDCard);

  static String? getIDCard() => prefs?.getString(_keyIDCard);

  static Future setType(String type) async =>
      await prefs!.setString(_keyType, type);

  static String? getType() => prefs?.getString(_keyType);

  static Future setFirstname(String firstname) async =>
      await prefs!.setString(_keyFirstname, firstname);

  static String? getFirstname() => prefs?.getString(_keyFirstname);

  static Future setLastname(String lastname) async =>
      await prefs!.setString(_keyLastname, lastname);

  static String? getLastname() => prefs?.getString(_keyLastname);

  static Future setIDCardChildren(String IDCardChildren) async =>
      await prefs!.setString(_keyIDCardChildren, IDCardChildren);

  static String? getIDCardChildren() => prefs?.getString(_keyIDCardChildren);

  static Future setNum_plate(String num_plate) async =>
      await prefs!.setString(_keyNum_plate, num_plate);

  static String? getNum_plate() => prefs?.getString(_keyNum_plate);

  static Future setLatitude(String Latitude) async =>
      await prefs!.setString(_keyLatitude, Latitude);

  static String? getLatitude() => prefs?.getString(_keyLatitude);

  static Future removeLatitude() async =>
      await prefs!.remove(_keyLatitude);

  static Future setLongitude(String Longitude) async =>
      await prefs!.setString(_keyLongitude, Longitude);

  static String? getLongitude() => prefs?.getString(_keyLongitude);

  static Future removeLongitude() async =>
      await prefs!.remove(_keyLongitude);

  static Future setAddress(String Address) async =>
      await prefs!.setString(_keyAddress, Address);

  static String? getAddress() => prefs?.getString(_keyAddress);

  static Future removeAddress() async =>
      await prefs!.remove(_keyAddress);

  static Future setListRoute(String ListRoute) async =>
      await prefs!.setString(_keyListRoute, ListRoute);

  static String? getListRoute() => prefs?.getString(_keyListRoute);

  static Future setBus(String Bus) async =>
      await prefs!.setString(_keyBus, Bus);

  static String? getBus() => prefs?.getString(_keyBus);

  static Future setContractID(String ContractID) async =>
      await prefs!.setString(_keyContractID, ContractID);

  static String? getContractID() => prefs?.getString(_keyContractID);

  static Future setContract(String Contract) async =>
      await prefs!.setString(_keyContract, Contract);

  static String? getContract() => prefs?.getString(_keyContract);

  static Future setnumPage(int numpage) async =>
      await prefs!.setInt(_keyNumPage, numpage);

  static int? getnumPage() => prefs?.getInt(_keyNumPage);

  static Future setRequestID(String RequestID) async =>
      await prefs!.setString(_keyRequestID, RequestID);

  static String? getRequestID() => prefs?.getString(_keyRequestID);

  static Future setSchoolID(String SchoolID) async =>
      await prefs!.setString(_keySchoolID, SchoolID);

  static String? getSchoolID() => prefs?.getString(_keySchoolID);


}