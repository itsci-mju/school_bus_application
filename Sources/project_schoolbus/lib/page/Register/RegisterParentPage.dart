import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:project_schoolbus/page/LoginPage/loginPage.dart';
import 'package:project_schoolbus/api/firebase_api.dart';
import '../../../importer.dart';
import '../AlertDialog.dart';
import '../Register/BottonWidget.dart';
import 'package:path/path.dart';
import 'package:flutter/cupertino.dart';

class RegisterParentPage extends StatefulWidget{

  @override
  _RegisterParentPageState createState() => _RegisterParentPageState();

}

class _RegisterParentPageState extends State<RegisterParentPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _ctrlUsername = TextEditingController();
  final TextEditingController _ctrlPassword = TextEditingController();
  final _ctrlIDCard = TextEditingController();
  final _ctrlfirstname = TextEditingController();
  final _ctrllastname = TextEditingController();
  final _ctrlbirthday = TextEditingController();
  final _ctrlphone = TextEditingController();
  final _ctrlemail = TextEditingController();
  final _ctrllineid = TextEditingController();
  final _ctrladdress = TextEditingController();
  final _ctrlimageprofile = TextEditingController();
  final _ckfilename = TextEditingController();
  bool isLoading = false;
  static const double height = 10;


  UploadTask? task;
  File? file;

  @override
  Widget build(BuildContext context) {
    final fileName = file != null ? basename(file!.path) : '';
    _ckfilename.text = fileName;
    return Scaffold(
      body: Container(
          padding: const EdgeInsets.fromLTRB(30, 25, 30, 8),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  'สมัครสมาชิก',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),

                ),
                const Text(
                  'ผู้ปกครอง',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),

                ),
                const SizedBox(
                  height: 30,
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
                              validator: (value) {
                                String pettern = r'^[\d\w]{8,16}$';
                                RegExp usernameRex = RegExp(pettern);
                                if (value == null || value.isEmpty) {
                                   alertDialogApp.showAlertDialog(context, 'กรุณากรอกชื่อผู้ใช้');
                                   return 'กรุณากรอกชื่อผู้ใช้ให้ถูกต้อง';
                                }else if(!usernameRex.hasMatch(value.toString())){
                                  alertDialogApp.showAlertDialog(context, 'กรุณากรอกชื่อผู้ใช้ สามารถประกอบด้วยภาษาอังกฤษ และ ตัวเลข 8 หลัก ไม่เกิน 16 หลัก');
                                  return 'กรุณากรอกชื่อผู้ใช้ให้ถูกต้อง';
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
                                  alertDialogApp.showAlertDialog(context, 'กรุณากรอกรหัสผ่าน');
                                  return 'กรุณากรอกรหัสผ่าน';
                                }else if(!PasswordRex.hasMatch(value.toString())){
                                  alertDialogApp.showAlertDialog(context, 'กรุณากรอกรหัสผ่าน สามารถประกอบด้วยภาษาอังกฤษ และ ตัวเลข 8 หลัก ไม่เกิน 16 หลัก');
                                  return 'กรุณากรอกรหัสผ่าน';
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
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(13),
                        ],
                        validator: (value) {
                          RegExp IDCardRex = RegExp (r"(\d{13})");

                          if (value == null || value.isEmpty) {
                            alertDialogApp.showAlertDialog(context, 'กรุณากรอกรหัสบัตรประชาชน');
                            return 'กรุณากรอกรหัสบัตรประชาชน';
                          }else if(!IDCardRex.hasMatch(value.toString())){
                            alertDialogApp.showAlertDialog(context, 'กรุณากรอกรหัสประจำตัวประชาชน ด้วยตัวเลข 13 หลัก!');
                            return 'กรุณากรอกรหัสบัตรประชาชน';
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
                                  alertDialogApp.showAlertDialog(context, 'กรุณากรอกชื่อ');
                                  return 'กรุณากรอกชื่อ';
                                }else if(!fnameRex.hasMatch(value.toString())){
                                  alertDialogApp.showAlertDialog(context, 'กรุณากรอกชื่อ เป็นภาษาไทยหรือภาษาอังกฤษ ตั้งแต่ 2 หลัก!');
                                  return 'กรุณากรอกชื่อ';
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
                                  alertDialogApp.showAlertDialog(context, 'กรุณากรอกนามสกุล');
                                  return 'กรุณากรอกนามสกุล';
                                }else if(!lnameRex.hasMatch(value.toString())){
                                  alertDialogApp.showAlertDialog(context, 'กรุณากรอกนามสกุล เป็นภาษาไทยหรือภาษาอังกฤษ ตั้งแต่ 2 หลัก!');
                                  return 'กรุณากรอกนามสกุล';
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
                                  alertDialogApp.showAlertDialog(context, 'กรุณากรอกวันเกิด');
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
                                    initialDate:DateTime(DateTime.now().year-20),
                                    firstDate:DateTime(1900),
                                    lastDate: DateTime(DateTime.now().year-20));

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
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly,
                                LengthLimitingTextInputFormatter(10),
                              ],
                              validator: (value) {
                                RegExp phoneRex = RegExp (r"(\d{10})");

                                if (value == null || value.isEmpty) {
                                  alertDialogApp.showAlertDialog(context, 'กรุณากรอกหมายเลขโทรศัพท์');
                                  return 'กรุณากรอกหมายเลขโทรศัพท์';
                                }else if(!phoneRex.hasMatch(value.toString())){
                                  alertDialogApp.showAlertDialog(context, 'กรุณากรอกหมายเลขโทรศัพท์ ด้วยตัวเลข 13 หลัก!');
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
                          RegExp mailRex = RegExp (r"^([a-z0-9]+(?:[._-][a-z0-9]+)*)@([a-z0-9]+(?:[.-][a-z0-9]+)*\.[a-z]{2,})$");
                          if (value == null || value.isEmpty) {
                            alertDialogApp.showAlertDialog(context, 'กรุณากรอกอีเมล');
                            return 'กรุณากรอกอีเมล';
                          }else if(!mailRex.hasMatch(value.toString())){
                            alertDialogApp.showAlertDialog(context, 'กรุณากรอกอีเมล ให้ถูกต้อง');
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
                            alertDialogApp.showAlertDialog(context, 'กรุณากรอก LineID');
                          return 'กรุณากรอก LineID';
                          }else if(!lineRex.hasMatch(value.toString())){
                            alertDialogApp.showAlertDialog(context, 'กรุณากรอก LineID ให้ถูกต้อง');
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
                            alertDialogApp.showAlertDialog(context, 'กรุณากรอกที่อยู่');
                            return 'กรุณากรอกที่อยู่';
                          }else if(!lineRex.hasMatch(value.toString())){
                            alertDialogApp.showAlertDialog(context, 'กรุณากรอกที่อยู่ ให้ถูกต้อง');
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
                              margin: const EdgeInsets.only(top: 10),
                              child: const Text("กรุณาอัปโหลดรูปภาพประจำตัว"))
                              : Image.file(file!,height: 150,width: 150,fit: BoxFit.cover)),

                      const SizedBox(
                        height: height,
                      ),
                      ElevatedButton(onPressed: () {
                          doRegister(context);
                      },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.fromLTRB(100, 15, 100, 15),
                        ),

                        child: isLoading ? Row(
                          children: const [
                            CircularProgressIndicator(color: Colors.white),
                            SizedBox(width: 24),Text('รอสักครู่...', style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 17,
                            )),
                          ],
                        ): const Text(
                          'สมัครสมาชิก',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: height,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      );
  }

  void onSignInClick(BuildContext context){
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(
            builder: (context) => const LoginPage()));
  }

  ParentManager manager = ParentManager();
  AlertDialogApp alertDialogApp =AlertDialogApp();
  Future doRegister(BuildContext context) async {
    setState(() => isLoading = true);
    if(_formKey.currentState!.validate()){
      if(file == null){
        alertDialogApp.showAlertDialog(context, 'กรุณาอัปโหลดรูปภาพประจำตัว');
      }else{
      try{
        await uploadFile();
        List<String> s = _ctrlbirthday.text.split("/");
        DateTime b = DateTime(int.parse(s[0]), int.parse(s[1]), int.parse(s[2]));
        Parent parent = Parent(_ctrlIDCard.text,_ctrlfirstname.text,_ctrllastname.text,b,_ctrlphone.text,
            _ctrlemail.text,_ctrllineid.text,_ctrladdress.text,_ctrlimageprofile.text
            ,Login(_ctrlUsername.text,_ctrlPassword.text,"1"));
        String result = await manager.doRegisrer(parent);
        var logger = Logger();
        await getSharedPreferences.init();
        logger.e(result);
        if(result != "0")  {

          isLoading = false;
          AnimatedSnackBar.rectangle(
              'สำเร็จ',
              'คุณสมัครสมาชิกสำเร็จ',
              type: AnimatedSnackBarType.success,
              brightness: Brightness.light,
              duration : const Duration(seconds: 5)
          ).show(
            context,
          );
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                  builder: (context) => LoginPage()));
        }else{
          AnimatedSnackBar.rectangle(
              'เกิดข้อผิดพลาด',
              'เกิดข้อผิดพลาดในการสมัครสมาชิก',
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
    }else{
      setState(() => isLoading = false);
    }

  }

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false,
        type: FileType.custom,
        allowedExtensions: ['jpg','png','jpeg']);

    if (result == null) return;
    final path = result.files.single.path!;

    setState(() => file = File(path));
    _ckfilename.text = result.toString();
  }

  Future uploadFile() async {
    if (file == null) return;

    final fileName = basename(file!.path);
    final file_extension = fileName.split(".").last;
    final name = _ctrlUsername.text+"_Profile"+"."+file_extension;
    final destination = 'PareantProfile/$name';

    task = FirebaseApi.uploadFile(destination, file!);
    setState(() {});

    if (task == null) return;

    final snapshot = await task!.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();
    _ctrlimageprofile.text = urlDownload;
    print('Download-Link: $urlDownload');

  }


}