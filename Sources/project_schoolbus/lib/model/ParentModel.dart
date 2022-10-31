import 'package:project_schoolbus/model/LoginModel.dart';

class Parent {
  late String IDCard;
  late String firstname;
  late String lastname;
  late DateTime birthday;
  late String phone;
  late String email;
  late String lineID;
  late String address;
  late String home_latitude;
  late String home_longitude;
  late String image_profile;
  late Login login;

  Parent(
      this.IDCard,
      this.firstname,
      this.lastname,
      this.birthday,
      this.phone,
      this.email,
      this.lineID,
      this.address,
      this.home_latitude,
      this.home_longitude,
      this.image_profile,
      this.login);

   Parent.fromJson(Map<String, dynamic> json)
      : IDCard = json['IDCard'],
        firstname = json['firstname'],
        lastname = json['lastname'],
        birthday = DateTime.parse(json['birthday']),
        phone = json['phone'],
        email = json['email'],
        lineID = json['lineID'],
        address = json['address'],
        home_latitude = json['home_latitude']??'',
        home_longitude = json['home_longitude']??'',
        image_profile = json['image_profile'],
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
      'lineID': lineID,
      'address': address,
      'home_latitude': home_latitude,
      'home_longitude': home_longitude,
      'image_profile': image_profile,
      'login': login.toMap(),
    };
  }

  @override
  String toString() {
    return 'Parent{IDCard: $IDCard, firstname: $firstname, lastname: $lastname, birthday: $birthday, phone: $phone, email: $email, lineID: $lineID, address: $address, home_latitude: $home_latitude, home_longitude: $home_longitude, image_profile: $image_profile, login: $login}';
  }
}
