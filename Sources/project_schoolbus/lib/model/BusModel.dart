
import '../importer.dart';

class Bus{
  late String num_plate;
  late String province;
  late String brand;
  late DateTime purchase_date;
  late int seats_amount;
  late String bus_latitude;
  late String bus_longitude;
  late int status_bus;
  late String reason;
  late String image_Bus;
  late Driver driver;




  Bus(
      this.num_plate,
      this.province,
      this.brand,
      this.purchase_date,
      this.seats_amount,
      this.bus_latitude,
      this.bus_longitude,
      this.status_bus,
      this.reason,
      this.image_Bus,
      this.driver);

  Bus.fromJson(Map<String, dynamic> json)
      : num_plate = json['num_plate'],
        province = json['province'],
        brand = json['brand'],
        purchase_date = DateTime.parse(json['purchase_date']),
        seats_amount = json['seats_amount'],
        bus_latitude = json['bus_latitude'],
        bus_longitude = json['bus_longitude'],
        status_bus = json['status_bus'],
        reason = json['reason'],
        image_Bus = json['image_Bus'],
        driver = Driver.fromJson(json['driver']);

  Map<String, dynamic> toMap() {
    // JSON
    // Map<String, String> หมายถึง Map<Key, value>
    // map[key] = value
    // id = map[columnId] ซึ่ง columnId คือ key จะได้ value ออกมาเป็น id

    return {
      'num_plate': num_plate,
      'province': province,
      'brand': brand,
      'purchase_date': purchase_date.toString(),
      'seats_amount': seats_amount,
      'bus_latitude': bus_latitude,
      'bus_longitude': bus_longitude,
      'status_bus': status_bus,
      'reason': reason,
      'image_Bus': image_Bus,
      'driver': driver.toMap()
    };
  }

  @override
  String toString() {
    return 'Bus{num_plate: $num_plate, province: $province, brand: $brand, purchase_date: $purchase_date, seats_amount: $seats_amount, bus_latitude: $bus_latitude, bus_longitude: $bus_longitude, status_bus: $status_bus, image_Bus: $image_Bus, driver: $driver}';
  }
  
}