import 'package:intl/intl.dart';
import 'package:project_schoolbus/importer.dart';
import '../../AlertDialog.dart';
import '../../Driver/HomePage/light_colors.dart';
import '../../Register/BottonWidget.dart';
import 'ChildrenPage.dart';
import 'package:path/path.dart';
import 'package:flutter/cupertino.dart';
import 'package:project_schoolbus/api/firebase_api.dart';
class AddChildrenPage extends StatefulWidget {
  const AddChildrenPage({Key? key}) : super(key: key);

  @override
  State<AddChildrenPage> createState() => _AddChildrenPageState();
}

class _AddChildrenPageState extends State<AddChildrenPage> {
  static const double height = 10;
  String parentId = getSharedPreferences.getIDCard() ?? '';
  final _formKey = GlobalKey<FormState>();
  final _ctrlUsername = TextEditingController();
  final _ctrlPassword = TextEditingController();
  final _ctrlIDCard = TextEditingController();
  final _ctrlfirstname = TextEditingController();
  final _ctrllastname = TextEditingController();
  final _ctrlbirthday = TextEditingController();
  final _ctrlphone = TextEditingController();
  final _ctrlemail = TextEditingController();
  final _ctrllineid = TextEditingController();
  final _ctrlimageprofile = TextEditingController();
  final _ckfilename = TextEditingController();
  final _ctrlschool_name = TextEditingController();
  bool isLoading = false;

  UploadTask? task;
  File? file;

  String profile = getSharedPreferences.getProfile() ?? '';
  Parent? p;

  @override
  void initState() {
    mapProfileParent();
    super.initState();
  }

  void mapProfileParent(){
    Map<String, dynamic> map = jsonDecode(profile);
    p = Parent.fromJson(map);
  }

  @override
  Widget build(BuildContext context) {
    final fileName = file != null ? basename(file!.path) : '';
    _ckfilename.text = fileName;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          title: const Text("เพิ่มบุตร"),
          toolbarHeight: 60,
          shape: const RoundedRectangleBorder()),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 8),
        child: SingleChildScrollView(
          child: SizedBox(
            child: Card(

              child: Padding(
                padding: EdgeInsets.fromLTRB(20, 10, 10, 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[

                    const Text(
                      'เพิ่มบุตร',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 40,
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
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(13),
                            ],
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
                                        initialDate:DateTime(DateTime.now().year-5),
                                        firstDate:DateTime(1900),
                                        lastDate: DateTime(DateTime.now().year-5));

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
                                      return 'กรุณากรอกหมายเลขโทรศัพท์';
                                    }else if(!phoneRex.hasMatch(value.toString())){
                                      return 'กรุณากรอกหมายเลขโทรศัพท์ ด้วยตัวเลข 10 หลัก!';
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
                                  child: const Text("กรุณาอัปโหลดรูปภาพประจำตัวบุตร"))
                                  : Image.file(file!,height: 150,width: 150,fit: BoxFit.cover)),
                          const SizedBox(
                            height: height,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 45.0),
                            child: Row(
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    showDialog(context: context, builder: (context) => AlertDialog(
                                      title: const Text("คุุณแน่ใจหรือมั้ยที่จะเพิ่ม บุตรข้าสู่ระบบ"),
                                      actions: [
                                        ElevatedButton(onPressed: ()  {
                                          doAddChildren(context);
                                        }, child: const Text("แน่ใจ")),
                                        ElevatedButton(onPressed: (){
                                          Navigator.pop(context);
                                        }, child: const Text("ยกเลิก"))
                                      ],
                                    ));

                                  },
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                                  ),
                                  child: const Text(
                                    'เพิ่มสมาชิก',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    onCancelClick( context);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.fromLTRB(40, 15, 35, 15),
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
                  ]
                  )
              )
            )
            ,
          ),
        ),
      ),
    );
  }

  void onCancelClick(BuildContext context){
    Navigator.of(context).push(
        MaterialPageRoute(
            builder: (context) => MyHomePage(indexScreen: 3,)));
  }
  AlertDialogApp alertDialogApp =AlertDialogApp();
  ChildrenManager manager = ChildrenManager();
  Future doAddChildren(BuildContext context) async {

    if(_formKey.currentState!.validate()){
      if( file == null){
        alertDialogApp.showAlertDialog(context, 'กรุณาอัปโหลดรูปภาพประจำตัว');
      }else{
        try{
          await uploadFile();
          List<String> s = _ctrlbirthday.text.split("/");
          DateTime b = DateTime(int.parse(s[0]), int.parse(s[1]), int.parse(s[2]));
          Children children = Children(_ctrlIDCard.text,_ctrlfirstname.text,_ctrllastname.text,b,_ctrlphone.text,
              _ctrlemail.text,_ctrllineid.text,_ctrlschool_name.text,_ctrlimageprofile.text,p!,Login(_ctrlUsername.text,_ctrlPassword.text,2));
          String result = await manager.addChildren(children);
          var logger = Logger();
          await getSharedPreferences.init();
          logger.e(result);
          if(result != "0") {
            AnimatedSnackBar.rectangle(
                'สำเร็จ',
                'คุณเพิ่มเด็กสำเร็จ',
                type: AnimatedSnackBarType.success,
                brightness: Brightness.light,
                duration : const Duration(seconds: 5)
            ).show(
              context,
            );
            Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context) => MyHomePage(indexScreen: null)));
          }else{
            AnimatedSnackBar.rectangle(
                'เกิดข้อผิดพลาด',
                'เกิดข้อผิดพลาดในการเพิ่มเด็ก',
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
    final destination = 'ChildrenProfile/$fileName';

    task = FirebaseApi.uploadFile(destination, file!);
    setState(() {});

    if (task == null) return;

    final snapshot = await task!.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();
    _ctrlimageprofile.text = urlDownload;
    print('Download-Link: $urlDownload');

  }

}