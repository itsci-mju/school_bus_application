
import 'ParentModel.dart';
import 'LoginModel.dart';

class Children {
  late String IDCard;
  late String firstname;
  late String lastname;
  late DateTime birthday;
  late String phone;
  late String email;
  late String lineID;
  late String school_name;
  late String image_profile;
  late Parent parent;
  late Login login;

  Children(
      this.IDCard,
      this.firstname,
      this.lastname,
      this.birthday,
      this.phone,
      this.email,
      this.lineID,
      this.school_name,
      this.image_profile,
      this.parent,
      this.login);

  Children.fromJson(Map<String, dynamic> json)
      : IDCard = json['IDCard'],
        firstname = json['firstname'],
        lastname = json['lastname'],
        birthday =  DateTime.parse(json['birthday']),
        phone = json['phone'],
        email = json['email'],
        lineID = json['lineID'],
        school_name = json['school_name'],
        image_profile = json['image_profile'],
        parent = Parent.fromJson(json['parent']),
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
      'school_name': school_name,
      'image_profile': image_profile,
      'parent': parent.toMap(),
      'login': login.toMap(),
    };
  }

  @override
  String toString() {
    return 'Children{IDCard: $IDCard, firstname: $firstname, lastname: $lastname, birthday: $birthday, phone: $phone, email: $email, lineID: $lineID, school_name: $school_name, image_profile: $image_profile, parent: $parent, login: $login}';
  }
}