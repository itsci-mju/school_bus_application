import 'package:geolocator/geolocator.dart';
import 'package:project_schoolbus/api/firebase_api.dart';
import 'package:intl/intl.dart';
import 'package:project_schoolbus/manager/DriverManager.dart';
import 'package:project_schoolbus/page/LoginPage/loginPage.dart';
import 'package:project_schoolbus/page/Register/BottonWidget.dart';
import '../../manager/SchoolManager.dart';
import '../AlertDialog.dart';
import '../Register/BottonWidget.dart';
import 'package:path/path.dart';
import '../../importer.dart';
import 'package:flutter/cupertino.dart';

import 'mapsegi.dart';
class RegisterDriverPage extends StatefulWidget{

  @override
  _RegisterDriverPageState createState() => _RegisterDriverPageState();

}

class _RegisterDriverPageState extends State<RegisterDriverPage> {

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
  final _ctrlnum_plate = TextEditingController();
  final _ctrlprovince = TextEditingController();
  final _ctrlbrand = TextEditingController();
  final _ctrlpurchase_date = TextEditingController();
  final _ctrlseats_amount = TextEditingController();
  final _ctrlimageprofile = TextEditingController();
  final _ctrldriver_license = TextEditingController();
  final _ctrlstudent_bus_license = TextEditingController();
  final _ctrlimage_Bus = TextEditingController();
  final _croundshcool = TextEditingController();
  final _crounddetail = TextEditingController();
  final _ctrlrRoute_mapURL = TextEditingController();
  TextEditingController Address = TextEditingController();

  final imageprofile = TextEditingController();
  final driver_license = TextEditingController();
  final student_bus_license = TextEditingController();
  final image_Bus = TextEditingController();
  SchoolManager Smanager = SchoolManager();


  @override
  void initState() {
    getlistSchool();
    super.initState();
  }

  List<School>? listSchool = [];
  List<String>? DropdownSchool = [];
  String? selectedSchoolValue;
  List<BusStop>? listaroute = [];

  void getlistSchool()  {
    var log = Logger();

    Smanager.listSchoolDriver().then((value) => {
      listSchool = value,
      for(int i = 0 ; i < listSchool!.length; i++){
        DropdownSchool!.add((i+1).toString()+" : "+listSchool![i].school_name)
      },
      log.e("ddddddddddddddddd : "+DropdownSchool.toString()),
      setState(() {
        isLoading = false;
      }),
    });
  }

  int index = 1;

  bool isLoading = false;

  UploadTask? task;
  File? file1;
  File? file2;
  File? file3;
  File? file4;
  static const double height = 10;

  List<Widget> _cardList = [];

  String? latitude = getSharedPreferences.getLatitude() ?? '';
  String? longitude = getSharedPreferences.getLongitude() ?? '';

  Widget _card(BuildContext context,String shcool,String round,String rounddetail) {
    return Column(
        children: [
          index > 1
              ?const SizedBox(
            height: height,
          ):const SizedBox(
            height: 0,
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              "????????????????????????????????? "+index.toString(),
              style:const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
          const SizedBox(
            height: height,
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              shcool.split(" : ")[1],
              style:const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
          const SizedBox(
            height: height,
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              round,
              style:const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
          const SizedBox(
            height: height,
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              rounddetail,
              style:const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ],
      );

  }

  List<DropdownMenuItem<String>> _addDividersAfterItems(List<String> items) {
    List<DropdownMenuItem<String>> _menuItems = [];
    for (var item in items) {
      _menuItems.addAll(
        [
          DropdownMenuItem<String>(
            value: item,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                item,
                style: const TextStyle(
                  fontSize: 14,
                ),
              ),
            ),
          ),
          //If it's last item, we will not add Divider after it.
          if (item != items.last)
            const DropdownMenuItem<String>(
              enabled: false,
              child: Divider(),
            ),
        ],
      );
    }
    return _menuItems;
  }

  List<int> _getDividersIndexes() {
    List<int> _dividersIndexes = [];
    for (var i = 0; i < (DropdownSchool!.length * 2) - 1; i++) {
      if (i.isOdd) {
        _dividersIndexes.add(i);
      }
    }
    return _dividersIndexes;
  }

  @override
  Widget build(BuildContext context) {
    final fileName = file1 != null ? basename(file1!.path) : '';
    final fileCar = file2 != null ? basename(file2!.path) : '';
    final fileP1 = file3 != null ? basename(file3!.path) : '';
    final fileP2 = file4 != null ? basename(file4!.path) : '';
    _ctrlimageprofile.text = fileName;
    _ctrlimage_Bus.text = fileCar;
    _ctrldriver_license.text = fileP1;
    _ctrlstudent_bus_license.text = fileP2;




    return Scaffold(
      body: Container(
        padding: const EdgeInsets.fromLTRB(30, 25, 30, 8),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: const [
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      '?????????????????????????????????',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,

                      ),
                    ),
                  ),
                  Text(
                    '?????????????????????',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: height,
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment : MainAxisAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment : CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(left: 5.0),
                                  child: Text('?????????????????????',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 190.0),
                                  child: ElevatedButton.icon(
                                    onPressed: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) => const ShowMap()));
                                    },
                                    icon: const Icon(Icons.location_on),
                                    label: const Text(
                                      '????????????????????????????????????',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      primary:  Colors.amber,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              width: 350,
                              decoration: BoxDecoration(
                                border: Border.all(width: 1.0, color: const Color(
                                    0xFFC9C9C9)),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 10.0),
                                  child: TextFormField(
                                    readOnly: true,
                                    controller: Address,
                                    maxLines: 4, //or null
                                    decoration: const InputDecoration.collapsed(
                                        hintText: "????????????????????????????????????????????????????????????????????????????????????????????????"
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _ctrlUsername,
                            validator: (value) {
                              String pettern = r'^[\d\w]{8,16}$';
                              RegExp usernameRex = RegExp(pettern);
                              if (value == null || value.isEmpty) {
                                return '?????????????????????????????????????????????????????????';
                              }else if(!usernameRex.hasMatch(value.toString())){
                                return '????????????????????????????????????????????????????????? ?????????????????????????????????????????????????????????????????????????????? ????????? ?????????????????? 8 ???????????? ????????????????????? 16 ????????????';
                              }
                              return null;
                            },
                            maxLines: 1,
                            decoration: InputDecoration(
                              labelText: '??????????????????????????????',
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
                                return '???????????????????????????????????????????????????';
                              }else if(!PasswordRex.hasMatch(value.toString())){
                                return '??????????????????????????????????????????????????? ?????????????????????????????????????????????????????????????????????????????? ????????? ?????????????????? 8 ???????????? ????????????????????? 16 ????????????';
                              }
                              return null;
                            },
                            maxLines: 1,
                            obscureText: true,
                            decoration: InputDecoration(
                              labelText: '????????????????????????',
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
                          return '????????????????????????????????????????????????????????????????????????';
                        }else if(!IDCardRex.hasMatch(value.toString())){
                          return '???????????????????????????????????????????????????????????????????????????????????? ?????????????????????????????? 13 ????????????!';
                        }
                        return null;
                      },
                      maxLines: 1,
                      decoration: InputDecoration(
                        labelText: '?????????????????????????????????????????????',
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
                              RegExp fnameRex = RegExp (r"([a-zA-Z???-???]{2,30})");

                              if (value == null || value.isEmpty) {
                                return '???????????????????????????????????????';
                              }else if(!fnameRex.hasMatch(value.toString())){
                                return '??????????????????????????????????????? ??????????????????????????????????????????????????????????????????????????? ????????????????????? 2 ????????????!';
                              }
                              return null;
                            },
                            maxLines: 1,
                            decoration: InputDecoration(
                              labelText: '????????????',
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
                              RegExp lnameRex = RegExp (r"([a-zA-Z???-???]{2,30})");
                              if (value == null || value.isEmpty) {
                                return '????????????????????????????????????????????????';
                              }else if(!lnameRex.hasMatch(value.toString())){
                                return '???????????????????????????????????????????????? ??????????????????????????????????????????????????????????????????????????? ????????????????????? 2 ????????????!';
                              }
                              return null;
                            },
                            maxLines: 1,
                            decoration: InputDecoration(
                              labelText: '?????????????????????',
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
                                return '????????????????????????????????????????????????';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                labelText: "?????????????????????",
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
                            keyboardType: TextInputType.phone,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(10),
                            ],
                            validator: (value) {
                              RegExp phoneRex = RegExp (r"(\d{10})");

                              if (value == null || value.isEmpty) {
                                return '????????????????????????????????????????????????????????????????????????';
                              }else if(!phoneRex.hasMatch(value.toString())){
                                return '???????????????????????????????????????????????????????????????????????? ?????????????????????????????? 13 ????????????!';
                              }
                              return null;
                            },
                            maxLines: 1,
                            decoration: InputDecoration(
                              labelText: '?????????????????????????????????????????????',
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
                          return '??????????????????????????????????????????';
                        }else if(!mailRex.hasMatch(value.toString())){
                          return '?????????????????????????????????????????? ??????????????????????????????';
                        }
                        return null;
                      },
                      maxLines: 1,
                      decoration: InputDecoration(
                        labelText: '???????????????',
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
                        RegExp lineRex = RegExp (r"^[\w\W\d\.\-\_]{2,70}$");
                        if (value == null || value.isEmpty) {
                          return '????????????????????????????????????????????????';
                        }else if(!lineRex.hasMatch(value.toString())){
                          return '???????????????????????????????????????????????? ??????????????????????????????';
                        }
                        return null;
                      },
                      maxLines: 2,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.home),
                        labelText: '?????????????????????',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: height,
                    ),
                    ButtonWidget(
                      text: '???????????????????????????????????????????????????????????????',
                      icon: Icons.photo,
                      onClicked: selectFileProfile ,
                    ),
                    const SizedBox(
                      height: height,
                    ),
                    Center(
                        child: file1 == null
                            ? Container(
                            margin: EdgeInsets.only(top: 10),
                            child: Text("??????????????????????????????????????????????????????????????????????????????"))
                            : Image.file(file1!,height: 150,width: 150,fit: BoxFit.cover)),

                    const SizedBox(
                      height: height,
                    ),

                    const Divider(
                        height: 10,
                        thickness: 2,

                        color: Colors.amber
                    ),

                    const Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        '????????????????????????',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 23,
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
                            controller: _ctrlnum_plate,
                            validator: (value) {
                              RegExp plateRex = RegExp (r"^[???-???\d]{0,7}$");
                              if (value == null || value.isEmpty) {
                                return '????????????????????????????????????????????????????????????????????????????????????????????????';
                              }else if(!plateRex.hasMatch(value.toString())){
                                return '???????????????????????????????????????????????????????????????????????????????????????????????? ??????????????????????????????';
                              }
                              return null;

                            },
                            maxLines: 1,
                            decoration: InputDecoration(
                              labelText: '????????????????????????????????????????????????',
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
                                return '???????????????????????????????????????????????????????????????????????????';
                              }
                              return null;
                            },
                            maxLines: 1,
                            decoration: InputDecoration(
                              labelText: '?????????????????????',
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
                                return '????????????????????????????????????????????????????????????????????????';
                              }
                              return null;
                            },
                            maxLines: 1,
                            decoration: InputDecoration(
                              labelText: '????????????????????????',
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
                                return '??????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????';
                              }
                              return null;
                            },
                            maxLines: 1,
                            decoration: InputDecoration(
                              labelText: '????????????????????????????????????',
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
                          return '???????????????????????????????????????????????????????????????????????????';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          labelText: "????????????????????????????????????????????????",
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
                            _ctrlpurchase_date.text = DateFormat('yyyy/MM/dd').format(date!);
                          });
                        }
                      },

                    ),
                    const SizedBox(
                      height: height,
                    ),
                    ButtonWidget(
                      text: '??????????????????????????????????????????????????????????????????????????????????????????????????????????????????',
                      icon: Icons.photo,
                      onClicked: selectFile1 ,
                    ),
                    const SizedBox(
                      height: height,
                    ),
                    Center(
                        child: file3 == null
                            ? Container(
                            margin: EdgeInsets.only(top: 10),
                            child: Text("?????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????"))
                            : Image.file(file3!,height: 150,width: 150,fit: BoxFit.cover)),

                    const SizedBox(
                      height: height,
                    ),

                    ButtonWidget(
                      text: '?????????????????????????????????????????????????????????????????????????????????????????????',
                      icon: Icons.photo,
                      onClicked: selectFile2,
                    ),
                    const SizedBox(
                      height: height,
                    ), Center(
                        child: file4 == null
                            ? Container(
                            margin: EdgeInsets.only(top: 10),
                            child: Text("????????????????????????????????????????????????????????????????????????????????????????????????????????????"))
                            : Image.file(file4!,height: 150,width: 150,fit: BoxFit.cover)),

                    const SizedBox(
                      height: height,
                    ),
                    ButtonWidget(
                      text: '????????????????????????????????????????????????',
                      icon: Icons.photo,
                      onClicked: selectFileCar,
                    ),
                    const SizedBox(
                      height: height,
                    ),
                    Center(
                        child: file2 == null
                            ? Container(
                            margin: EdgeInsets.only(top: 10),
                            child: Text("???????????????????????????????????????????????????????????????"))
                            : Image.file(file2!,height: 150,width: 150,fit: BoxFit.cover)),
                    Row(
                      children: [
                        const Expanded(child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            '??????????????????????????????????????????',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        ),
                        Expanded(child: Align(
                            alignment: Alignment.topRight,
                            child: InkWell(
                              onTap: (){
                                setState(() {
                                  if(selectedSchoolValue == null){
                                    alertDialogApp.showAlertDialog(context, '??????????????????????????????????????????????????????');
                                  }else if(_croundshcool.text == ''){
                                    alertDialogApp.showAlertDialog(context, '??????????????????????????? URL ??????????????????????????????');
                                  }else if(_crounddetail.text == ''){
                                    alertDialogApp.showAlertDialog(context, '???????????????????????????????????????????????????????????????????????????????????????');
                                  } else{
                                    bool rec = true;
                                    if(listaroute!.isEmpty){
                                      rec = true;
                                    }else {
                                      for(BusStop r in listaroute!){
                                        if(r.school.school_name == selectedSchoolValue!.split(" : ")[1]){
                                          rec = false;
                                        }
                                      }
                                    }
                                    if(rec){
                                      _cardList.add(_card(context,selectedSchoolValue!,_croundshcool.text,_crounddetail.text));
                                      String nums =  selectedSchoolValue!.split(" : ")[0];
                                      School s = listSchool![int.parse(nums)-1];
                                      //BusStop r = BusStop(_crounddetail.text,_croundshcool.text,s);
                                      //listaroute!.add(r);
                                      index ++;
                                    }else{
                                      alertDialogApp.showAlertDialog(context, '???????????????????????????????????????????????????????????????????????????');
                                    }
                                  }
                                });
                              },
                              child: Container(
                                width: 40,
                                height: 40,
                                child: Icon(Icons.add, color: Color(0xffa3d064),),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        color: Color(0xffa3d064),
                                        width: 1
                                    )
                                ),
                              ),
                            )
                        ),)
                      ],
                    ),
                    const SizedBox(
                      height: height,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: Container(
                        padding: const EdgeInsets.only(left: 16,right: 16),
                        decoration:
                        BoxDecoration(
                            border: Border.all(color: Colors.grey,width: 1),
                            borderRadius: BorderRadius.circular(15)
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton2(
                            isExpanded: true,
                            hint: Text(
                              '?????????????????????????????????????????????????????? : ',
                              style: TextStyle(
                                fontSize: 14,
                                color: Theme
                                    .of(context)
                                    .hintColor,
                              ),
                            ),
                            items: _addDividersAfterItems(DropdownSchool!),
                            underline: const SizedBox(),style: const TextStyle(
                              color: Colors.black,fontSize: 16
                          ),
                            customItemsIndexes: _getDividersIndexes(),
                            customItemsHeight: 4,
                            value: selectedSchoolValue,
                            onChanged: (value) {
                              setState(() {
                                selectedSchoolValue = value as String;
                              });
                            },
                            buttonHeight: 50,
                            buttonWidth: 320,
                            itemHeight: 40,
                            itemPadding: const EdgeInsets.symmetric(horizontal: 8.0),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: height,
                    ),
                    TextFormField(
                      controller: _croundshcool,
                      validator: (value) {

                        if (value == null || value.isEmpty) {
                          return '????????????????????????????????????????????????';
                        }
                        return null;
                      },
                      maxLines: 1,
                      decoration: InputDecoration(
                        labelText: '?????????????????????',
                        prefixIcon: const Icon(Icons.route),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: height,
                    ),
                    TextFormField(
                      controller: _crounddetail,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '??????????????????????????????????????????????????????????????????????????????';
                        }
                        return null;
                      },
                      maxLines: 1,
                      decoration: InputDecoration(
                        labelText: '???????????????????????????????????????????????????',
                        prefixIcon: const Icon(Icons.details),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: height,
                    ),
                    SingleChildScrollView(
                      child:  ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: _cardList.length,
                        itemBuilder: (context, index) {
                          return _cardList[index];
                        },
                      ),
                    ),
                    const SizedBox(
                      height: height,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        /*showDialog(context: context, builder: (context) => AlertDialog(
                          title: const Text("???????????????????????????????????????????????????????????? ?"),
                          actions: [
                            ElevatedButton(onPressed: () {*/
                        doRegister(context);
                        /* }, child: const Text("?????????????????????????????????")),
                            ElevatedButton(onPressed: (){
                              Navigator.pop(context);
                            }, child: const Text("??????????????????"))
                          ],
                        ));
*/
                      },
                      style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.fromLTRB(100, 15, 100, 15),
                          alignment: Alignment.topCenter
                      ),
                      child: isLoading ? Row(
                        children: const [
                          CircularProgressIndicator(color: Colors.white),
                          SizedBox(width: 24),Text('???????????????????????????...', style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 17,
                          )),
                        ],
                      ): const Text(
                        '?????????????????????????????????',
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

  Position? _position;
  Future _getCurrentLocation() async {
    Position position = await _determinePosition();
    setState(() {
      _position = position;
    });
  }

  Future<Position> _determinePosition() async {
    LocationPermission permission;

    permission = await Geolocator.checkPermission();

    if(permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if(permission == LocationPermission.denied) {
        return Future.error('Location Permissions are denied');
      }
    }

    return await Geolocator.getCurrentPosition();
  }

  void onSignInClick(BuildContext context){
    Navigator.of(context).push(
        MaterialPageRoute(
            builder: (context) => const LoginPage()));
  }
  AlertDialogApp alertDialogApp =AlertDialogApp();
  DriverManager manager = DriverManager();
  RouteManager routeManager = RouteManager();

  Future doRegister(BuildContext context) async {
    setState(() => isLoading = true);
    if(_formKey.currentState!.validate()){
      if(file1 == null){
        setState(() => isLoading = false);
        alertDialogApp.showAlertDialog(context, '??????????????????????????????????????????????????????????????????????????????');
      }else {
        if(file2 == null){
          setState(() => isLoading = false);
          alertDialogApp.showAlertDialog(context, '?????????????????????????????????????????????????????????????????????????????????');
        }else{
          if(file3 == null){
            setState(() => isLoading = false);
            alertDialogApp.showAlertDialog(context, '?????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????');
          }else{
            if(file4 == null){
              setState(() => isLoading = false);
              alertDialogApp.showAlertDialog(context, '????????????????????????????????????????????????????????????????????????????????????????????????????????????');
            }else{
              if(listaroute!.isEmpty ||  listaroute! == '' || listaroute! == null){
                setState(() => isLoading = false);
                alertDialogApp.showAlertDialog(context, '????????????????????????????????????????????????????????????????????????????????????????????? 1 ????????????????????????');
              }else{
                await uploadFile1();
                await uploadFile2();
                await uploadFile3();
                await uploadFile4();
                try{
                  await _getCurrentLocation();
                  List<String> s = _ctrlbirthday.text.split("/");
                  DateTime b = DateTime(int.parse(s[0]), int.parse(s[1]), int.parse(s[2]));
                  List<String> s2 = _ctrlbirthday.text.split("/");
                  DateTime p = DateTime(int.parse(s2[0]), int.parse(s2[1]), int.parse(s2[2]));
                  Driver driver = Driver(_ctrlIDCard.text,_ctrlfirstname.text,_ctrllastname.text,b,_ctrlphone.text,
                      _ctrlemail.text,_ctrlgroupline.text,_ctrladdress.text,latitude!,longitude!,imageprofile.text,driver_license.text,student_bus_license.text
                      ,Login(_ctrlUsername.text,_ctrlPassword.text,3));
                  Bus bus = Bus(_ctrlnum_plate.text,_ctrlprovince.text,_ctrlbrand.text,p,int.parse(_ctrlseats_amount.text),_position!.latitude.toString(),_position!.longitude.toString(),_ctrlrRoute_mapURL.text,1,"",image_Bus.text,driver);
                  String result = await manager.doRegisrerDriver(bus);
                  var logger = Logger();
                  await getSharedPreferences.init();
                  logger.e(result);

                  if(result != "0") {
                    bool resultr = false ;
                    for(BusStop routes in listaroute!){
                      routes.bus_stop_ID= "";
                      routes.bus = bus;
                      String resultroute = await routeManager.doAddRoute(routes);
                      if(resultroute!= "0"){
                        resultr = true;
                      }else{
                        resultr = false;
                        break;
                      }
                    }


                    if(resultr){
                      isLoading = false;
                      AnimatedSnackBar.rectangle(
                          '??????????????????',
                          '????????????????????????????????????????????????????????????',
                          type: AnimatedSnackBarType.success,
                          brightness: Brightness.light,
                          duration : const Duration(seconds: 5)
                      ).show(
                        context,
                      );
                      getSharedPreferences.removeLongitude();
                      getSharedPreferences.removeLatitude();
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                              builder: (context) => const LoginPage()));
                    }else{
                      isLoading = false;
                      AnimatedSnackBar.rectangle(
                          '??????????????????????????????????????????',
                          '?????????????????????????????? ???????????? ????????????????????????????????????????????? ?????????',
                          type: AnimatedSnackBarType.error,
                          brightness: Brightness.light,
                          duration : const Duration(seconds: 5)
                      ).show(
                        context,
                      );


                    }
                  }else{
                    isLoading = false;
                    AnimatedSnackBar.rectangle(
                        '??????????????????????????????????????????',
                        '?????????????????????????????? ???????????? ????????????????????????????????????????????? ?????????',
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
          }
        }
      }
    }else{
      setState(() => isLoading = false);
    }
  }


  Future selectFileProfile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false,
        type: FileType.custom,
        allowedExtensions: ['jpg','png','jpeg']);

    if (result == null) return;
    final path = result.files.single.path!;

    setState(() => file1 = File(path));
    _ctrlimageprofile.text = result.toString();
  }

  Future selectFileCar() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false,
        type: FileType.custom,
        allowedExtensions: ['jpg','png','jpeg']);

    if (result == null) return;
    final path = result.files.single.path!;

    setState(() => file2 = File(path));
    _ctrlimage_Bus.text = result.toString();
  }
  Future selectFile1() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false,
        type: FileType.custom,
        allowedExtensions: ['jpg','png','jpeg']);

    if (result == null) return;
    final path = result.files.single.path!;

    setState(() => file3 = File(path));
    _ctrldriver_license.text = result.toString();
  }
  Future selectFile2() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false,
        type: FileType.custom,
        allowedExtensions: ['jpg','png','jpeg']);

    if (result == null) return;
    final path = result.files.single.path!;

    setState(() => file4 = File(path));
    _ctrlstudent_bus_license.text = result.toString();
  }


  Future uploadFile1() async {
    if (file1 == null) return;

    final fileName = basename(file1!.path);
    final file_extension = fileName.split(".").last;
    final name = _ctrlUsername.text+"_Profile"+"."+file_extension;
    final destination = 'DriverProfile/$name';

    task = FirebaseApi.uploadFile(destination, file1!);
    setState(() {});

    if (task == null) return;

    final snapshot = await task!.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();

    print('Download-Link: $urlDownload');
    imageprofile.text =urlDownload;

  }
  Future uploadFile2() async {
    if (file2 == null) return;

    final fileName = basename(file2!.path);
    final file_extension = fileName.split(".").last;
    final name = _ctrlUsername.text+"_Car"+"."+file_extension;
    final destination = 'CarProfile/$name';

    task = FirebaseApi.uploadFile(destination, file2!);
    setState(() {});

    if (task == null) return;

    final snapshot = await task!.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();

    print('Download-Link: $urlDownload');
    image_Bus.text = urlDownload;

  }
  Future uploadFile3() async {
    if (file3 == null) return;

    final fileName = basename(file3!.path);
    final file_extension = fileName.split(".").last;
    final name = _ctrlUsername.text+"_license"+"."+file_extension;
    final destination ='driver_license/$name';

    task = FirebaseApi.uploadFile(destination, file3!);
    setState(() {});

    if (task == null) return;

    final snapshot = await task!.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();

    print('Download-Link: $urlDownload');
    driver_license.text  = urlDownload;

  }
  Future uploadFile4() async {
    if (file4 == null) return;

    final fileName = basename(file4!.path);
    final file_extension = fileName.split(".").last;
    final name = _ctrlUsername.text+"_buslicense"+"."+file_extension;
    final destination = 'student_bus_license/$name';

    task = FirebaseApi.uploadFile(destination, file4!);
    setState(() {});

    if (task == null) return;

    final snapshot = await task!.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();

    print('Download-Link: $urlDownload');
    student_bus_license.text  = urlDownload;
  }
}