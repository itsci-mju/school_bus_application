import 'package:flutter/cupertino.dart';

class AlertDialogApp  {
  AlertDialogApp();

  void showAlertDialog(BuildContext context,String Textmss) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: const Text('แจ้งเตือน',style: TextStyle(
            fontFamily: 'Kanit'
        )),
        content: Text(Textmss,style: TextStyle(
            fontFamily: 'Kanit')),
      ),
    );
  }


}
