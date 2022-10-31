import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:intl/intl.dart';
import '../../../api/firebase_api.dart';
import '../../../importer.dart';
import '../../Register/BottonWidget.dart';

class ParentProfilePage extends StatefulWidget {
  const ParentProfilePage({Key? key}) : super(key: key);

  @override
  State<ParentProfilePage> createState() => _ParentProfilePageState();
}

class _ParentProfilePageState extends State<ParentProfilePage> {
  ParentManager manager = ParentManager();
  
  String username = getSharedPreferences.getUsername() ?? '';
  String type = getSharedPreferences.getType() ?? '';
  Future<Parent>? futureprofile;

  String? latitude = getSharedPreferences.getLatitude() ?? '';
  String? longitude = getSharedPreferences.getLongitude() ?? '';

  final _formKey = GlobalKey<FormState>();
  late final _ctrlUsername = TextEditingController();
  late final _ctrlPassword = TextEditingController();
  late final _ctrlIDCard = TextEditingController();
  late final _ctrlfirstname = TextEditingController();
  late final _ctrllastname = TextEditingController();
  late final _ctrlbirthday = TextEditingController();
  late final _ctrlphone = TextEditingController();
  late final _ctrlemail = TextEditingController();
  late final _ctrllineid = TextEditingController();
  late final _ctrladdress = TextEditingController();
  late final _ctrlimageprofile = TextEditingController();
  bool isLoading = true;
  UploadTask? task;
  File? file;
  @override
  void initState() {
    getProfile();
    super.initState();
  }

  Parent? parent;

  void getProfile() {
    manager.getParent(username,type).then((value) => {
      setState(() {
        parent = value;
        _ctrlUsername.text = parent!.login.username;
        _ctrlPassword.text = parent!.login.password;
        _ctrlIDCard.text = parent!.IDCard;
        _ctrlfirstname.text = parent!.firstname;
        _ctrllastname.text = parent!.lastname;
        _ctrlbirthday.text = DateFormat('yyyy/MM/dd').format(parent!.birthday);
        _ctrlphone.text = parent!.phone;
        _ctrlemail.text = parent!.email;
        _ctrllineid.text = parent!.lineID;
        _ctrladdress.text = parent!.address;
        _ctrlimageprofile.text = parent!.image_profile;
        isLoading = false;
      }),
    });

  }

  static const double height = 10;

  @override
  Widget build(BuildContext context) {
    final fileName = file != null ? basename(file!.path) : '';
    if(isLoading){
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return Scaffold(
      appBar: AppBar(title: const Text('ParentProfilePage page'),
      ),
      body: Center(
        child: Container(
                padding: const EdgeInsets.fromLTRB(30, 25, 30, 8),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      const Text(
                        'แก้ไขข้อมูลส่วนตัว',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 40,
                        ),
                      ),

                      Container (
                        height: 200,
                        width: 200,
                        decoration:  BoxDecoration(
                            border: Border.all(
                              color: Colors.amber,
                              width: 5,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                            image: DecorationImage(
                                image: NetworkImage(_ctrlimageprofile.text),
                                fit: BoxFit.cover)
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    controller: _ctrlUsername,
                                    readOnly: true,
                                    validator: (value) {
                                      String pettern = r'^[\d\w]{8,16}$';
                                      RegExp usernameRex = RegExp(pettern);
                                      if (value == null || value.isEmpty) {
                                        return 'กรุณากรอกชื่อผู้ใช้';
                                      }else if(!usernameRex.hasMatch(value.toString())){
                                        return 'กรุณากรอกชื่อผู้ใช้ สามารถประกอบด้วยภาษาอังกฤษ และ ตัวเลข 8 หลัก ไม่เกิน 16 หลัก';
                                      }
                                      return null;
                                    },
                                    maxLines: 1,
                                    decoration: InputDecoration(
                                      labelText: 'ชื่อผู้ใช้',
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
                                    controller: _ctrlPassword,
                                    validator: (value) {
                                      RegExp PasswordRex = RegExp (r"[a-zA-Z0-9]{8,16}$");
                                      if (value == null || value.isEmpty) {
                                        return 'กรุณากรอกรหัสผ่าน';
                                      }else if(!PasswordRex.hasMatch(value.toString())){
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
                              controller: _ctrlIDCard,
                              readOnly: true,
                              validator: (value) {
                                RegExp IDCardRex = RegExp (r"(\d{13})");

                                if (value == null || value.isEmpty) {
                                  return 'กรุณากรอกรหัสบัตรประชาชน';
                                }else if(!IDCardRex.hasMatch(value.toString())){
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
                                      RegExp fnameRex = RegExp (r"([a-zA-Zก-์]{2,30})");

                                      if (value == null || value.isEmpty) {
                                        return 'กรุณากรอกชื่อ';
                                      }else if(!fnameRex.hasMatch(value.toString())){
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
                                      RegExp lnameRex = RegExp (r"([a-zA-Zก-์]{2,30})");
                                      if (value == null || value.isEmpty) {
                                        return 'กรุณากรอกนามสกุล';
                                      }else if(!lnameRex.hasMatch(value.toString())){
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
                                            borderRadius: BorderRadius.circular(10)
                                        )
                                    ),
                                    onTap: () async{
                                      DateTime? date = DateTime(1900);
                                      FocusScope.of(context).requestFocus(new FocusNode());
                                      date = await showDatePicker(
                                          context: context,
                                          initialDate:DateTime.now(),
                                          firstDate:DateTime(1900),
                                          lastDate: DateTime.now());

                                      if(date != null){
                                        setState(() {
                                          _ctrlbirthday.text = DateFormat('yyyy/MM/dd').format(date!);
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
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.deny(RegExp('.-')),
                                    ],
                                    validator: (value) {
                                      RegExp phoneRex = RegExp (r"(\d{10})");

                                      if (value == null || value.isEmpty) {
                                        return 'กรุณากรอกหมายเลขโทรศัพท์';
                                      }else if(!phoneRex.hasMatch(value.toString())){
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
                              validator: (value) {
                                RegExp mailRex = RegExp (r"^([a-z0-9]+(?:[._-][a-z0-9]+)*)@([a-z0-9]+(?:[.-][a-z0-9]+)*\.[a-z]{2,})$");
                                if (value == null || value.isEmpty) {
                                  return 'กรุณากรอกอีเมล';
                                }else if(!mailRex.hasMatch(value.toString())){
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
                              controller: _ctrllineid,
                              validator: (value) {
                                RegExp lineRex = RegExp (r"^[a-z\d\.\-\_]{2,30}$");
                                if (value == null || value.isEmpty) {
                                  return 'กรุณากรอก LineID';
                                }else if(!lineRex.hasMatch(value.toString())){
                                  return 'กรุณากรอก LineID ให้ถูกต้อง';
                                }
                                return null;
                              },
                              maxLines: 1,
                              decoration: InputDecoration(
                                prefixIcon: const Icon(Icons.person),
                                labelText: 'LineID',
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
                                RegExp lineRex = RegExp (r"^[\w\W\d\.\-\_]{2,70}$");
                                if (value == null || value.isEmpty) {
                                  return 'กรุณากรอกที่อยู่';
                                }else if(!lineRex.hasMatch(value.toString())){
                                  return 'กรุณากรอกที่อยู่ ให้ถูกต้อง';
                                }
                                return null;
                              },
                              maxLines: 1,
                              decoration: InputDecoration(
                                prefixIcon: const Icon(Icons.home),
                                labelText: 'ที่อยู่',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: height,
                            ),
                            ButtonWidget(
                              text: 'อัปโหลดรูปภาพประจำตัว',
                              icon: Icons.photo,
                              onClicked: selectFile ,
                            ),
                            const SizedBox(
                              height: height,
                            ),
                            Center(
                                child: file == null || file == ''
                                    ? Container(
                                    child: Text("")) //image: NetworkImage(_ctrlimageprofile.text),fit: BoxFit.cover)
                                    : Image.file(file!,height: 150,width: 150,fit: BoxFit.cover)),

                            const SizedBox(
                              height: height,
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(60, 0, 60, 0),

                              child: Row(
                                children: [
                                  ElevatedButton(
                                    onPressed: ()  async {
                                      await uploadFile();
                                      editProfile(context);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      padding: const EdgeInsets.fromLTRB(30, 15, 35, 15),
                                    ),
                                    child: const Text(
                                      'บันทึก',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) => MyHomePage(indexScreen: null,)));
                                    },
                                    style: ElevatedButton.styleFrom(
                                      padding: const EdgeInsets.fromLTRB(35, 15, 30, 15),
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
              )
      ),
    );
  }
  
  Future editProfile(BuildContext context) async {
    if(_formKey.currentState!.validate()){
      try{
        List<String> s = _ctrlbirthday.text.split("/");
        DateTime b = DateTime(int.parse(s[0]), int.parse(s[1]), int.parse(s[2]));
        Parent parent = Parent(_ctrlIDCard.text,_ctrlfirstname.text,_ctrllastname.text,b,_ctrlphone.text,
            _ctrlemail.text,_ctrllineid.text,_ctrladdress.text,latitude!,longitude!,_ctrlimageprofile.text
            ,Login(_ctrlUsername.text,_ctrlPassword.text,1));
        String result = await manager.editProfile(parent);
        var logger = Logger();
        await getSharedPreferences.init();
        logger.e(result);
        if(result != "0") {
          getSharedPreferences.removeLongitude();
          getSharedPreferences.removeLatitude();
          AnimatedSnackBar.rectangle(
              'สำเร็จ',
              'แก้ไขข้อมูลสำเร็จ',
              type: AnimatedSnackBarType.success,
              brightness: Brightness.light,
              duration : const Duration(seconds: 5)
          ).show(
            context,
          );
          Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (context) => MyHomePage(indexScreen: null,)));
        }else{
          AnimatedSnackBar.rectangle(
              'เกิดข้อผิดพลาด',
              'ไม่สามารถแก้ไขข้อมูลได้',
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
  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false,
        type: FileType.custom,
        allowedExtensions: ['jpg','png','jpeg']);

    if (result == null) return;
    final path = result.files.single.path!;

    setState(() => file = File(path));
  }

  Future uploadFile() async {
    if (file == null) return;

    final fileName = basename(file!.path);
    final destination = 'PareantProfile/$fileName';

    task = FirebaseApi.uploadFile(destination, file!);
    setState(() {});

    if (task == null) return;

    final snapshot = await task!.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();
    _ctrlimageprofile.text = urlDownload;
    print('Download-Link: $urlDownload');

  }
}