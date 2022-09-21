
import '../../../importer.dart';

class ButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onClicked;

  const ButtonWidget({Key? key,required this.text, required this.onClicked}) : super(key: key);

  @override
  Widget build(BuildContext context) => ElevatedButton(
    style: ElevatedButton.styleFrom(
      minimumSize: const Size.fromHeight(40),
      primary: Colors.white,
    ),
    child: FittedBox(
      child: Text(
        text,
        style: const TextStyle(fontSize: 14, color: Colors.black,fontWeight: FontWeight.bold),
      ),
    ),
    onPressed: onClicked,
  );
}



