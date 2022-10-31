import 'package:intl/intl.dart';
import 'package:project_schoolbus/page/Driver/Profile/ImageDialog.dart';
import 'package:project_schoolbus/page/MainPage/mainDriver.dart';
import 'package:project_schoolbus/page/Register/BottonWidget.dart';
import 'package:flutter/cupertino.dart';
import '../../../importer.dart';
import '../../../manager/DriverManager.dart';
import '../HomePage/light_colors.dart';
import 'package:path/path.dart';
import 'package:project_schoolbus/api/firebase_api.dart';

class ProfileDriverPage extends StatefulWidget {
  @override
  _DriverPersonalState createState() => _DriverPersonalState();
}

class _DriverPersonalState extends State<ProfileDriverPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _ctrlUsername = TextEditingController();
  final TextEditingController _ctrlPassword = TextEditingController();
  final _ctrlIDCard = TextEditingController();
  final _ctrlfirstname = TextEditingController();
  final _ctrllastname = TextEditingController();
  final _ctrlbirthday = TextEditingController();
  final _ctrlphone = TextEditingController();
  final _ctrlemail = TextEditingController();
  final _ctrlgroupline = TextEditingController();
  final _ctrladdress = TextEditingController();
  final _ctrlimageprofile = TextEditingController();
  final _ctrlnum_plate = TextEditingController();
  final _ctrlprovince = TextEditingController();
  final _ctrlbrand = TextEditingController();
  final _ctrlpurchase_date = TextEditingController();
  final _ctrlseats_amount = TextEditingController();
  final _ctrldriver_license = TextEditingController();
  final _ctrlstudent_bus_license = TextEditingController();
  final _ctrlimage_Bus = TextEditingController();
  final _ctrlrRoute_mapURL = TextEditingController();

  String? latitude = getSharedPreferences.getLatitude() ?? '';
  String? longitude = getSharedPreferences.getLongitude() ?? '';

  UploadTask? task;
  File? file1;
  File? file2;
  File? file3;
  File? file4;
  bool isLoading = true;
  static const double height = 10;

  @override
  void initState() {
    getProfile();
    super.initState();
  }

  Driver? driver;
  Bus? bus;

  void getProfile() {
    String IDCard = getSharedPreferences.getIDCard() ?? '';
    DriverManager driverManager = DriverManager();

    driverManager.getProfileDriver(IDCard).then((value) => {
      driver = value,
      _ctrlUsername.text = driver!.login.username,
      _ctrlPassword.text = driver!.login.password,
      _ctrlIDCard.text = driver!.IDCard,
      _ctrlfirstname.text = driver!.firstname,
      _ctrllastname.text = driver!.lastname,
      _ctrlbirthday.text =
          DateFormat('yyyy/MM/dd').format(driver!.birthday),
      _ctrlphone.text = driver!.phone,
      _ctrlemail.text = driver!.email,
      _ctrlgroupline.text = driver!.groupline,
      _ctrladdress.text = driver!.address,
      _ctrlimageprofile.text = driver!.image_profile,
      _ctrldriver_license.text = driver!.driver_license,
      _ctrlstudent_bus_license.text = driver!.student_bus_license,
      driverManager.getBusDetails(IDCard).then((value) => {
        bus = value,
        _ctrlnum_plate.text = bus!.num_plate,
        _ctrlprovince.text = bus!.province,
        _ctrlbrand.text = bus!.brand,
        _ctrlpurchase_date.text =
            DateFormat('yyyy/MM/dd').format(bus!.purchase_date),
        _ctrlseats_amount.text = bus!.seats_amount.toString(),
        _ctrlimage_Bus.text = bus!.image_Bus,
        setState(() {
          isLoading = false;
        }),
      }),
    });
  }

  @override
  Widget build(BuildContext context) {
    final fileName = file1 != null ? basename(file1!.path) :'' ;
    final fileCar = file2 != null ? basename(file2!.path) : '';
    final fileP1 = file3 != null ? basename(file3!.path) : '';
    final fileP2 = file4 != null ? basename(file4!.path) : '';


    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text("ข้อมูลส่วนตัว"),
        toolbarHeight: 60,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(10),
                bottomLeft: Radius.circular(10))),
        backgroundColor: LightColors.kDarkYellow,
      ),
      body: Container(
        color: LightColors.kLightYellow2,
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 8),
        child: Container(
          color: Colors.white,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(
                    height: 15,
                  ),
                  const Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'ข้อมูลส่วนตัว',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 23,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    height: 150,
                    width: 150,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(driver!.image_profile),
                            fit: BoxFit.cover)),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                readOnly: true,
                                controller: _ctrlUsername,
                                validator: (value) {
                                  String pettern = r'^[\d\w]{8,16}$';
                                  RegExp usernameRex = RegExp(pettern);
                                  if (value == null || value.isEmpty) {
                                    return 'กรุณากรอกชื่อผู้ใช้';
                                  } else if (!usernameRex
                                      .hasMatch(value.toString())) {
                                    return 'กรุณากรอกชื่อผู้ใช้ สามารถประกอบด้วยภาษาอังกฤษ และ ตัวเลข 8 หลัก ไม่เกิน 16 หลัก';
                                  }
                                  return null;
                                },
                                maxLines: 1,
                                decoration: InputDecoration(
                                  labelText: 'ชื่อผู้ใช่้',
                                  prefixIcon: const Icon(Icons.person),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: TextFormField(
                                readOnly: true,
                                controller: _ctrlPassword,
                                validator: (value) {
                                  RegExp PasswordRex =
                                  RegExp(r"[a-zA-Z0-9]{8,16}$");
                                  if (value == null || value.isEmpty) {
                                    return 'กรุณากรอกรหัสผ่าน';
                                  } else if (!PasswordRex.hasMatch(
                                      value.toString())) {
                                    return 'กรุณากรอกรหัสผ่าน สามารถประกอบด้วยภาษาอังกฤษ และ ตัวเลข 8 หลัก ไม่เกิน 16 หลัก';
                                  }
                                  return null;
                                },
                                maxLines: 1,
                                obscureText: true,
                                decoration: InputDecoration(
                                  labelText: 'รหัสผ่าน',
                                  prefixIcon: const Icon(Icons.lock),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: height,
                        ),
                        TextFormField(
                          readOnly: true,
                          controller: _ctrlIDCard,
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(13),
                          ],
                          validator: (value) {
                            RegExp IDCardRex = RegExp(r"(\d{13})");

                            if (value == null || value.isEmpty) {
                              return 'กรุณากรอกรหัสบัตรประชาชน';
                            } else if (!IDCardRex.hasMatch(value.toString())) {
                              return 'กรุณากรอกรหัสประจำตัวประชาชน ด้วยตัวเลข 13 หลัก!';
                            }
                            return null;
                          },
                          maxLines: 1,
                          decoration: InputDecoration(
                            labelText: 'รหัสบัตรประชาชน',
                            prefixIcon: const Icon(Icons.subtitles),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: height,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: _ctrlfirstname,
                                validator: (value) {
                                  RegExp fnameRex =
                                  RegExp(r"([a-zA-Zก-์]{2,30})");

                                  if (value == null || value.isEmpty) {
                                    return 'กรุณากรอกชื่อ';
                                  } else if (!fnameRex
                                      .hasMatch(value.toString())) {
                                    return 'กรุณากรอกชื่อ เป็นภาษาไทยหรือภาษาอังกฤษ ตั้งแต่ 2 หลัก!';
                                  }
                                  return null;
                                },
                                maxLines: 1,
                                decoration: InputDecoration(
                                  labelText: 'ชื่อ',
                                  prefixIcon: const Icon(Icons.person),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: TextFormField(
                                controller: _ctrllastname,
                                validator: (value) {
                                  RegExp lnameRex =
                                  RegExp(r"([a-zA-Zก-์]{2,30})");
                                  if (value == null || value.isEmpty) {
                                    return 'กรุณากรอกนามสกุล';
                                  } else if (!lnameRex
                                      .hasMatch(value.toString())) {
                                    return 'กรุณากรอกนามสกุล เป็นภาษาไทยหรือภาษาอังกฤษ ตั้งแต่ 2 หลัก!';
                                  }
                                  return null;
                                },
                                maxLines: 1,
                                decoration: InputDecoration(
                                  labelText: 'นามสกุล',
                                  prefixIcon: const Icon(Icons.person),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: height,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: _ctrlbirthday,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'กรุณากรอกวันเกิด';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                    labelText: "วันเกิด",
                                    hintText: "2000/11/21",
                                    prefixIcon: const Icon(Icons.date_range),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                        BorderRadius.circular(10))),
                                onTap: () async {
                                  DateTime? date = DateTime(1900);
                                  FocusScope.of(context)
                                      .requestFocus(new FocusNode());
                                  date = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(1900),
                                      lastDate: DateTime.now());

                                  if (date != null) {
                                    setState(() {
                                      _ctrlbirthday.text =
                                          DateFormat('yyyy/MM/dd')
                                              .format(date!);
                                    });
                                  }
                                },
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: TextFormField(
                                controller: _ctrlphone,
                                keyboardType: TextInputType.phone,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.digitsOnly,
                                  LengthLimitingTextInputFormatter(10),
                                ],
                                validator: (value) {
                                  RegExp phoneRex = RegExp(r"(\d{10})");

                                  if (value == null || value.isEmpty) {
                                    return 'กรุณากรอกหมายเลขโทรศัพท์';
                                  } else if (!phoneRex
                                      .hasMatch(value.toString())) {
                                    return 'กรุณากรอกหมายเลขโทรศัพท์ ด้วยตัวเลข 13 หลัก!';
                                  }
                                  return null;
                                },
                                maxLines: 1,
                                decoration: InputDecoration(
                                  labelText: 'หมายเลขโทรศัพท์',
                                  prefixIcon: const Icon(Icons.phone_android),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: height,
                        ),
                        TextFormField(
                          controller: _ctrlemail,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            RegExp mailRex = RegExp(
                                r"^([a-z0-9]+(?:[._-][a-z0-9]+)*)@([a-z0-9]+(?:[.-][a-z0-9]+)*\.[a-z]{2,})$");
                            if (value == null || value.isEmpty) {
                              return 'กรุณากรอกอีเมล';
                            } else if (!mailRex.hasMatch(value.toString())) {
                              return 'กรุณากรอกอีเมล ให้ถูกต้อง';
                            }
                            return null;
                          },
                          maxLines: 1,
                          decoration: InputDecoration(
                            labelText: 'อีเมล',
                            prefixIcon: const Icon(Icons.email),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: height,
                        ),
                        TextFormField(
                          controller: _ctrlgroupline,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your GroupLine';
                            }
                            return null;
                          },
                          maxLines: 1,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.person),
                            labelText: 'GroupLine (link)',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: height,
                        ),
                        TextFormField(
                          controller: _ctrladdress,
                          validator: (value) {
                            RegExp lineRex = RegExp(r"^[\w\W\d\.\-\_]{2,70}$");
                            if (value == null || value.isEmpty) {
                              return 'กรุณากรอกที่อยู่';
                            } else if (!lineRex.hasMatch(value.toString())) {
                              return 'กรุณากรอกที่อยู่ ให้ถูกต้อง';
                            }
                            return null;
                          },
                          maxLines: 2,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.home),
                            labelText: 'Address',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: height,
                        ),
                        const Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'รูปภาพประจำตัว',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                        ButtonWidget(
                          text: 'อัปโหลดรูปภาพประจำตัว',
                          icon: Icons.photo,
                          onClicked: selectFileProfile,
                        ),
                        Center(
                            child: file1 == null
                                ? Container(
                                child: Text(""))
                                : Image.file(file1!,height: 150,width: 150,fit: BoxFit.cover)),

                        const SizedBox(
                          height: height,
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        const Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'ข้อมูลรถ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 23,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Align(
                          child: Image.network(
                            bus!.image_Bus,
                            width: 150,
                          ),
                          alignment: Alignment.center,
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: _ctrlnum_plate,
                                validator: (value) {
                                  RegExp plateRex = RegExp(r"^[ก-ฮ\d]{0,7}$");
                                  if (value == null || value.isEmpty) {
                                    return 'กรุณากรอกหมายเลขทะเบียนรถของท่าน';
                                  } else if (!plateRex
                                      .hasMatch(value.toString())) {
                                    return 'กรุณากรอกหมายเลขทะเบียนรถของท่าน ให้ถูกต้อง';
                                  }
                                  return null;
                                },
                                maxLines: 1,
                                decoration: InputDecoration(
                                  labelText: 'หมายเลขทะเบียนรถ',
                                  prefixIcon: const Icon(Icons.directions_bus),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: TextFormField(
                                controller: _ctrlprovince,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'กรุณากรอกจังหวัดของรถท่าน';
                                  }
                                  return null;
                                },
                                maxLines: 1,
                                decoration: InputDecoration(
                                  labelText: 'จังหวัด',
                                  prefixIcon: const Icon(Icons.directions_bus),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: height,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: _ctrlbrand,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'กรุณากรอกยี่ห้อของรถท่าน';
                                  }
                                  return null;
                                },
                                maxLines: 1,
                                decoration: InputDecoration(
                                  labelText: 'ยี่ห้อรถ',
                                  prefixIcon: const Icon(Icons.directions_bus),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: TextFormField(
                                controller: _ctrlseats_amount,
                                keyboardType: TextInputType.number,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'กรุณากรอกจำนวนที่นั่งในรถท่านที่สามารถบรรจุได้';
                                  }
                                  return null;
                                },
                                maxLines: 1,
                                decoration: InputDecoration(
                                  labelText: 'จำนวนที่นั่ง',
                                  prefixIcon: const Icon(Icons.event_seat),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: height,
                        ),
                        TextFormField(
                          controller: _ctrlpurchase_date,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'กรุณากรอกวันที่ท่านรื้อรถ';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              labelText: "วันที่ท่านรื้อรถ",
                              hintText: "2000/11/21",
                              prefixIcon: const Icon(Icons.date_range),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          onTap: () async {
                            DateTime? date = DateTime(1900);
                            FocusScope.of(context)
                                .requestFocus(new FocusNode());
                            date = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1900),
                                lastDate: DateTime.now());

                            if (date != null) {
                              setState(() {
                                _ctrlpurchase_date.text =
                                    DateFormat('yyyy/MM/dd').format(date!);
                              });
                            }
                          },
                        ),
                        const SizedBox(
                          height: height,
                        ),
                        const Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'รูปบัตรอณถญาตขับรถยนต์ส่วนบุคคล',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              margin:
                              const EdgeInsets.only(left: 10, right: 10),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Material(
                                    child: InkWell(
                                      splashColor: Colors.grey,
                                      onTap: () => showDialog(
                                          context: context, builder: (_) =>  ImageDialog(driver!.driver_license)),
                                      child: Container(
                                        height: 50,
                                        width: 150,
                                        child: Center(
                                          child: Text(
                                            "ดูรูป",
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.grey),
                                          ),
                                        ),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.circular(10),
                                          border: Border.all(
                                              color: Colors.grey, width: 1),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Material(
                                    child: InkWell(
                                      splashColor: Colors.grey,
                                      onTap: () => selectFile1(),
                                      child: Container(
                                        height: 50,
                                        width: 150,
                                        child: Center(
                                          child: Text(
                                            "อัปโหลดรูป",
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.grey),
                                          ),
                                        ),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.circular(10),
                                          border: Border.all(
                                              color: Colors.grey, width: 1),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        Center(
                            child: file3 == null
                                ? Container(
                                child: Text(""))
                                : Image.file(file3!,height: 150,width: 150,fit: BoxFit.cover)),
                        const SizedBox(
                          height: height,
                        ),
                        const Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'รูปใบอณุาตขับขี่รถรับส่ง',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),

                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              margin:
                              const EdgeInsets.only(left: 10, right: 10),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Material(
                                    child: InkWell(
                                      splashColor: Colors.grey,
                                      onTap: () => showDialog(
                                          context: context, builder: (_) =>  ImageDialog(driver!.student_bus_license)),
                                      child: Container(
                                        height: 50,
                                        width: 150,
                                        child: Center(
                                          child: Text(
                                            "ดูรูป",
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.grey),
                                          ),
                                        ),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.circular(10),
                                          border: Border.all(
                                              color: Colors.grey, width: 1),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Material(
                                    child: InkWell(
                                      splashColor: Colors.grey,
                                      onTap: () => selectFile2(),
                                      child: Container(
                                        height: 50,
                                        width: 150,
                                        child: Center(
                                          child: Text(
                                            "อัปโหลดรูป",
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.grey),
                                          ),
                                        ),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.circular(10),
                                          border: Border.all(
                                              color: Colors.grey, width: 1),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        Center(
                            child: file4 == null
                                ? Container(
                                child: Text(""))
                                : Image.file(file4!,height: 150,width: 150,fit: BoxFit.cover)),
                        const SizedBox(
                          height: height,
                        ),

                        const Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'รูปรถยนต์',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),

                        ButtonWidget(
                          text: 'อัปโหลดรูปรถยนต์',
                          icon: Icons.photo,
                          onClicked: selectFileCar,
                        ),
                        Center(
                            child: file2 == null
                                ? Container(
                                child: Text(""))
                                : Image.file(file2!,height: 150,width: 150,fit: BoxFit.cover)),
                        const SizedBox(
                          height: height,
                        ),

                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 25.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        title:
                                        const Text("คุณต้องการที่แก้ไขใช่หรือไม ?"),
                                        actions: [
                                          ElevatedButton(
                                              onPressed: () async {
                                                await uploadFile1();
                                                await uploadFile2();
                                                await uploadFile3();
                                                await uploadFile4();
                                                editProfile(context);
                                              },
                                              child: const Text("ตกลง")),
                                          ElevatedButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: const Text("ยกเลิก"))
                                        ],
                                      ));
                                },
                                style: ElevatedButton.styleFrom(
                                  padding:
                                  const EdgeInsets.fromLTRB(40, 15, 40, 15),
                                ),
                                child: const Text(
                                  'บันทึก',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 30,
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  onCancelClick(context);
                                },
                                style: ElevatedButton.styleFrom(
                                  padding:
                                  const EdgeInsets.fromLTRB(40, 15, 40, 15),
                                ),
                                child: const Text(
                                  'ยกเลิก',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  DriverManager manager = DriverManager();
  Future editProfile(BuildContext context) async {
    if(_formKey.currentState!.validate()){
      try{
        List<String> s = _ctrlbirthday.text.split("/");
        DateTime b = DateTime(int.parse(s[0]), int.parse(s[1]), int.parse(s[2]));
        List<String> s2 = _ctrlbirthday.text.split("/");
        DateTime p = DateTime(int.parse(s2[0]), int.parse(s2[1]), int.parse(s2[2]));
        Driver driver = Driver(_ctrlIDCard.text,_ctrlfirstname.text,_ctrllastname.text,b,_ctrlphone.text,
            _ctrlemail.text,_ctrlgroupline.text,_ctrladdress.text,latitude!,longitude!,_ctrlimageprofile.text,_ctrldriver_license.text,_ctrlstudent_bus_license.text
            ,Login(_ctrlUsername.text,_ctrlPassword.text,3));
        Bus bus = Bus(_ctrlnum_plate.text,_ctrlprovince.text,_ctrlbrand.text,p,int.parse(_ctrlseats_amount.text),"","",_ctrlrRoute_mapURL.text,1,"",_ctrlimage_Bus.text,driver);
        String result = await manager.editProfileDriver(bus);
        var logger = Logger();
        await getSharedPreferences.init();
        logger.e(result);
        if(result != "0") {
          String json = jsonEncode(driver.toMap());
          await getSharedPreferences.setProfile(json);
          String json2 = jsonEncode(bus.toMap());
          await getSharedPreferences.setBus(json2);
          AnimatedSnackBar.rectangle(
              'สำเร็จ',
              'คุณแก้ไขสำเร็จ',
              type: AnimatedSnackBarType.success,
              brightness: Brightness.light,
              duration : const Duration(seconds: 5)
          ).show(
            context,
          );
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                  builder: (context) => const MainPageDriver()));
        }else{
          AnimatedSnackBar.rectangle(
              'เกิดข้อผิดพลาด',
              'เกิดข้อผิดพลาดในการแก้ไขข้อมูล',
              type: AnimatedSnackBarType.error,
              brightness: Brightness.light,
              duration : const Duration(seconds: 5)
          ).show(
            context,
          );
          isLoading = false;

        }
      }catch(error){
        print(error);
      }
    }
  }

  void onCancelClick(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const MainPageDriver()));
  }


  Future selectFileProfile() async {
    final result = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        type: FileType.custom,
        allowedExtensions: ['jpg', 'png', 'jpeg']);

    if (result == null) return;
    final path = result.files.single.path!;

    setState(() => file1 = File(path));

  }

  Future selectFileCar() async {
    final result = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        type: FileType.custom,
        allowedExtensions: ['jpg', 'png', 'jpeg']);

    if (result == null) return;
    final path = result.files.single.path!;

    setState(() => file2 = File(path));

  }

  Future selectFile1() async {
    final result = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        type: FileType.custom,
        allowedExtensions: ['jpg', 'png', 'jpeg']);

    if (result == null) return;
    final path = result.files.single.path!;

    setState(() => file3 = File(path));

  }

  Future selectFile2() async {
    final result = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        type: FileType.custom,
        allowedExtensions: ['jpg', 'png', 'jpeg']);

    if (result == null) return;
    final path = result.files.single.path!;

    setState(() => file4 = File(path));

  }

  Future uploadFile1() async {
    if (file1 == null) return;

    final fileName = basename(file1!.path);
    final destination = 'DriverProfile/$fileName';

    task = FirebaseApi.uploadFile(destination, file1!);
    setState(() {});

    if (task == null) return;

    final snapshot = await task!.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();

    print('Download-Link: $urlDownload');
    _ctrlimageprofile.text = urlDownload;
  }

  Future uploadFile2() async {
    if (file2 == null) return;

    final fileName = basename(file2!.path);
    final destination = 'CarProfile/$fileName';

    task = FirebaseApi.uploadFile(destination, file2!);
    setState(() {});

    if (task == null) return;

    final snapshot = await task!.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();

    print('Download-Link: $urlDownload');
    _ctrlimage_Bus.text = urlDownload;
  }

  Future uploadFile3() async {
    if (file3 == null) return;

    final fileName = basename(file3!.path);
    final destination = 'driver_license/$fileName';

    task = FirebaseApi.uploadFile(destination, file3!);
    setState(() {});

    if (task == null) return;

    final snapshot = await task!.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();

    print('Download-Link: $urlDownload');
    _ctrldriver_license.text = urlDownload;
  }

  Future uploadFile4() async {
    if (file4 == null) return;

    final fileName = basename(file4!.path);
    final destination = 'student_bus_license/$fileName';

    task = FirebaseApi.uploadFile(destination, file4!);
    setState(() {});

    if (task == null) return;

    final snapshot = await task!.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();

    print('Download-Link: $urlDownload');
    _ctrlstudent_bus_license.text = urlDownload;
  }
}
