class School{
  late String school_ID;
  late String school_name;
  late String school_latitude;
  late String school_longitude;

  School(this.school_ID, this.school_name, this.school_latitude,
      this.school_longitude);

  School.fromJson(Map<String, dynamic> json)
      : school_ID = json['school_ID'],
        school_name = json['school_name'],
        school_latitude = json['school_latitude'],
        school_longitude = json['school_longitude'];

  Map<String, dynamic> toMap(){
    // JSON
    // Map<String, String> หมายถึง Map<Key, value>
    // map[key] = value
    // id = map[columnId] ซึ่ง columnId คือ key จะได้ value ออกมาเป็น id

    return{
      'school_ID': school_ID,
      'school_name': school_name,
      'school_latitude': school_latitude,
      'school_longitude': school_longitude,
    };
  }

  @override
  String toString() {
    return 'School{school_ID: $school_ID, school_name: $school_name, school_latitude: $school_latitude, school_longitude: $school_longitude}';
  }
}