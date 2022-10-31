
import '../importer.dart';

class Driver{
  late String IDCard;
  late String firstname;
  late String lastname;
  late DateTime birthday;
  late String phone;
  late String email;
  late String groupline;
  late String address;
  late String home_latitude;
  late String home_longitude;
  late String image_profile;
  late String driver_license;
  late String student_bus_license;
  late Login login;

  Driver(
      this.IDCard,
      this.firstname,
      this.lastname,
      this.birthday,
      this.phone,
      this.email,
      this.groupline,
      this.address,
      this.home_latitude,
      this.home_longitude,
      this.image_profile,
      this.driver_license,
      this.student_bus_license,
      this.login);

  Map<DateTime, dynamic> decodeMap(Map<String, dynamic> map) {
    Map<DateTime, dynamic> newMap = {};
    map.forEach((key, value) {
      newMap[DateTime.parse(key)] = map[key];
    });
    return newMap;
  }

  Driver.fromJson(Map<String, dynamic> json)
      : IDCard = json['IDCard'],
        firstname = json['firstname'],
        lastname = json['lastname'],
        birthday =   DateTime.parse(json['birthday']),
        phone = json['phone'],
        email = json['email'],
        groupline = json['groupline'],
        address = json['address'],
        home_latitude = json['home_latitude']??"",
        home_longitude = json['home_longitude']??"",
        image_profile = json['image_profile'],
        driver_license = json['driver_license'],
        student_bus_license = json['student_bus_license'],
        login = Login.fromJson(json['login']);

  Map<String, dynamic> toMap() {
    // JSON
    // Map<String, String> หมายถึง Map<Key, value>
    // map[key] = value
    // id = map[columnId] ซึ่ง columnId คือ key จะได้ value ออกมาเป็น id

    return {
      'IDCard': IDCard,
      'firstname': firstname,
      'lastname': lastname,
      'birthday': birthday.toString(),
      'phone': phone,
      'email': email,
      'groupline': groupline,
      'address': address,
      'home_latitude': home_latitude,
      'home_longitude': home_longitude,
      'image_profile': image_profile,
      'driver_license': driver_license,
      'student_bus_license': student_bus_license,
      'login': login.toMap()
    };
  }

  @override
  String toString() {
    return 'Driver{IDCard: $IDCard, firstname: $firstname, lastname: $lastname, birthday: $birthday, phone: $phone, email: $email, groupline: $groupline, address: $address, image_profile: $image_profile, driver_license: $driver_license, student_bus_license: $student_bus_license, login: $login}';
  }
}