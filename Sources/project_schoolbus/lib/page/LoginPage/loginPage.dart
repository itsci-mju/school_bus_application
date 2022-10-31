
// ignore_for_file: non_constant_identifier_names

import 'package:project_schoolbus/LineNotify.dart';
import 'package:project_schoolbus/manager/DriverManager.dart';
import 'package:project_schoolbus/page/Driver/HomePage/HomeDriverPage.dart';
import 'package:project_schoolbus/page/LoginPage/Linenoti.dart';
import 'package:project_schoolbus/page/Register/BottonWidget.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../importer.dart';
import '../MainPage/mainChidren.dart';
import '../MainPage/mainDriver.dart';
import '../Parent/SearchSchoolBus/SearchPage.dart';
import '../Register/RegisterPage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'Linenoti.dart';



class LoginPage extends StatefulWidget{
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();

}

class _LoginPageState extends State<LoginPage> {

  final TextEditingController _ctrlUsername = TextEditingController();
  final TextEditingController _ctrlPassword = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isPasswordVisible = false;
  bool isUsernameValid = true;
  bool isLoginButtonEnabled = false;
  bool isLoading = false;
  late final Linenoti? linenoti = new Linenoti() ;

  late final void Function(String) callback;

  @override
  Widget build(BuildContext context) {

    return AbsorbPointer(
        absorbing: isLoading,
        child: Scaffold(
          backgroundColor: Colors.white,
          body: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Builder(
              builder: (ctx) => Center(
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Align(
                      child: Container(
                          alignment: Alignment.center,
                          width: 500,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(25, 25, 25, 0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    children: <Widget>[

                                      const SizedBox(height: 0),
                                      SizedBox(
                                        height: 280,
                                        child: Image.asset(
                                          "images/Logo2001.png",
                                        ),
                                      ),
                                      const SizedBox(height: 0),
                                      Container(
                                        padding: const EdgeInsets.only(
                                          top: 25,
                                          bottom: 30,
                                          left: 20,
                                          right: 20,
                                        ),


                                        child: Column(
                                          children: [
                                          Align(
                                            alignment: Alignment.centerLeft,
                                              child: Container(
                                                child: const Text(
                                                    'เข้าสู่ระบบ',
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                      fontWeight: FontWeight.w900,
                                                      color: getColors.textColor,
                                                      fontSize: 28,fontFamily: 'Kanit'
                                                    ),
                                                  )
                                              )
                                           ,),

                                            const SizedBox(height: 20),
                                            returnUsernameTextFormField(),
                                            const SizedBox(height: 13),
                                            returnPasswordTextFormField(),
                                           /* const SizedBox(height: 6),
                                            returnForgotPasswordButton(),*/
                                            const SizedBox(height: 10),
                                            Container(
                                              height: 50,
                                              width: 400,
                                              constraints: const BoxConstraints(maxHeight: 60),
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(5),
                                                  gradient: LinearGradient(
                                                      colors: [
                                                        Colors.amber,
                                                        Colors.yellow
                                                        //add more colors
                                                      ]),

                                              ),
                                              child: ElevatedButton(
                                                  style: ElevatedButton.styleFrom(
                                                    primary: Colors.transparent,
                                                    onSurface: Colors.transparent,
                                                    shadowColor: Colors.transparent,
                                                    //make color or elevated button transparent
                                                  ),
                                                  onPressed: () {
                                                    doLogin();
                                                  }, child: isLoading ? Row(
                                                    children: const [
                                                      CircularProgressIndicator(color: Colors.white),
                                                      SizedBox(width: 24),Text('รอสักครู่...', style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight: FontWeight.w700,
                                                        fontSize: 17,
                                                      )),
                                                    ],
                                                  ): const Text("เข้าสู่ระบบ" , style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w700,
                                                fontSize: 17,
                                              ),) ),
                                            ),
    /* InkWell(
                                              child: Container(
                                                width: 200,
                                                height: 80,
                                                alignment: Alignment.center,
                                                child: const Text('Example 1'),
                                              ),
                                              onTap: () async {
                                                await linenoti!.send(message: 'สวัสดี ครับ ทดสอบ');
                                              })
                                          ,*/
                                            const SizedBox(height: 30),
                                            returnRegisterBorderButton(),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10  +

                                            MediaQuery.of(context).viewPadding.bottom,
                                      ),

                                    ],
                                  ),
                                ),
                              ])

                      ),
                    ),
                  ),

                ),
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                      builder: (context) =>
                          SearchPage()));
            },
            backgroundColor: Colors.green,
            child: const Icon(Icons.search),
          ),

        ));
  }

  void ProgressSchoolBus() async{
    if(isLoading) return;
    setState(() => isLoading = true);
    await Future.delayed(const Duration(seconds: 5));
    setState(() => isLoading = false);
  }

  Widget returnUsernameTextFormField() {
    return TextFormField(
      validator: (value) {
        if(value!.isEmpty){
          return 'กรุณากรอกชื่อผู้ใช้งาน!!';
        }
      },
      controller: _ctrlUsername,
      decoration: InputDecoration(
          fillColor: Colors.white70,
          filled: true,
          labelText: 'ชื่อผู้ใช้งาน',
          //helperText: 'กรุณากรอก username เป็นภาษาอังกฤษ',
          prefixIcon: const Icon(Icons.person),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0))),
    );
  }


  Widget returnPasswordTextFormField() {
    return TextFormField(
      controller: _ctrlPassword,
      validator: (value) {
        if(value!.isEmpty){
          return 'กรุณากรอกรหัสผ่าน!!';
        }
      },
      obscureText: !isPasswordVisible,
      decoration: InputDecoration(
        fillColor: Colors.white70,
        filled: true,
        labelText: 'รหัสผ่าน',
        prefixIcon: const Padding(
          padding: EdgeInsets.only(top: 0),
          child: Icon(
            Icons.lock,
          ),
        ),
        suffixIcon: IconButton(
          icon: Icon(
            // Based on passwordVisible state choose the icon
            isPasswordVisible
                ? Icons.visibility
                : Icons.visibility_off,
            color: Theme.of(context).primaryColorDark,
          ),
          onPressed: () {
            setState(() {
              isPasswordVisible = !isPasswordVisible;
            });
          },
        ),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0)),
      ),
    );
  }



  LoginManager loginManager = LoginManager();
  Future doLogin() async {
    setState(() => isLoading = true);
    if(_formKey.currentState!.validate()){
      try{
        String result = await loginManager.doLogin(_ctrlUsername.text, _ctrlPassword.text);
        var logger = Logger();
        await getSharedPreferences.init();
        logger.e(result);
        if(result != "0") {
          ResponseModel responseModel = await loginManager.getProfileByUsername(_ctrlUsername.text, _ctrlPassword.text, result);
          logger.e(responseModel);
          Map<String, dynamic> userMap = responseModel.toMap();
          if(result == "1"){
            Parent parentprofile = Parent.fromJson(userMap['result']);
            String json = jsonEncode(parentprofile.toMap());
            await getSharedPreferences.setUsername(parentprofile.login.username);
            await getSharedPreferences.setType(result);
            await getSharedPreferences.setProfile(json);
            await getSharedPreferences.setIDCard(parentprofile.IDCard);
            await getSharedPreferences.setFirstname(parentprofile.firstname);
            await getSharedPreferences.setLastname(parentprofile.lastname);
            isLoading = false;
            AnimatedSnackBar.rectangle(
                'เข้าสู่ระบบสำเร็จ',
                'ยินดีต้อนรับ : '+parentprofile.login.username,
                type: AnimatedSnackBarType.success,
                brightness: Brightness.light,
                duration : const Duration(seconds: 8)
            ).show(
              context,
            );

            Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                    builder: (context) => MyHomePage(indexScreen: null,)));
          }else if(result == "2"){

            Children childrenprofile = Children.fromJson(userMap['result']);
            String json = jsonEncode(responseModel.result);
            await getSharedPreferences.setUsername(childrenprofile.login.username);
            await getSharedPreferences.setType(result);
            await getSharedPreferences.setProfile(json);
            await getSharedPreferences.setIDCard(childrenprofile.IDCard);
            await getSharedPreferences.setFirstname(childrenprofile.firstname);
            await getSharedPreferences.setLastname(childrenprofile.lastname);
            isLoading = false;
            AnimatedSnackBar.rectangle(
                'เข้าสู่ระบบสำเร็จ',
                'ยินดีต้อนรับ : '+childrenprofile.login.username,
                type: AnimatedSnackBarType.success,
                brightness: Brightness.light,
                duration : const Duration(seconds: 8)
            ).show(
              context,
            );

            Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                    builder: (context) => const MainPageChidren(indexScreen: null,)));
          }else if(result == "3"){
            Driver driverProfile = Driver.fromJson(userMap['result']);
            String json = jsonEncode(driverProfile.toMap());
            await getSharedPreferences.setProfile(json);
            await getSharedPreferences.setIDCard(driverProfile.IDCard);

            DriverManager driverManager = DriverManager();
            Bus busdetails = await driverManager.getBusDetails(driverProfile.IDCard);
            String json2 = jsonEncode(busdetails.toMap());
            await getSharedPreferences.setBus(json2);
            await getSharedPreferences.setNum_plate(busdetails.num_plate);
            isLoading = false;
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                    builder: (context) => const MainPageDriver()));
          }
        }else{
          setState(() => isLoading = false);
          AnimatedSnackBar.rectangle(
            'เกิดข้อผิดพลาด',
            'ชื่อผู้ใช้หรือรหัสผิด',
            type: AnimatedSnackBarType.error,
            brightness: Brightness.light,
            duration : const Duration(seconds: 5)
          ).show(
            context,
          );


        }
      }catch(error){
        print(error);
      }
    }
  }

  Widget returnRegisterBorderButton() {
    return RichText(
      text: TextSpan(
        children: [
          const TextSpan(
            text: "หากไม่มีบัญชีกรุณา  ",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: getColors.textSecondaryColor,
              fontSize: 16,
              fontFamily: 'Kanit'
            ),
          ),
          TextSpan(
            text: 'สมัครสมาชิก',
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => MainRegister()));
              },
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.amber,
              fontSize: 16,
                fontFamily: 'Kanit'
            ),
          ),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget returnForgotPasswordButton() {
    return Align(
      alignment: Alignment.centerRight,
      child: InkWell(
        onTap: _forgotPasswordAction,
        child: const Padding(
          padding: EdgeInsets.all(4),
          child: Text(
            'Forgot password?',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: getColors.textColor,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }
  void _forgotPasswordAction() {
    Navigator.of(context).push(
        MaterialPageRoute(
            builder: (context) => MainRegister()));
  }

}