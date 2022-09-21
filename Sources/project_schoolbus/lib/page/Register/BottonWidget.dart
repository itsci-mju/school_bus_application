import 'package:flutter/material.dart';
import 'package:project_schoolbus/importer.dart';

class ButtonWidget extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onClicked;

  const ButtonWidget({
    Key? key,
    required this.icon,
    required this.text,
    required this.onClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => ElevatedButton(
    style: ElevatedButton.styleFrom(
      primary: Colors.white,
      minimumSize: Size.fromHeight(50),
      shape: StadiumBorder(),
        side: const BorderSide(
            color: Colors.grey,
            width: 2,
            style: BorderStyle.solid
        )
    ),
    child: buildContent(),
    onPressed: onClicked,
  );

  Widget buildContent() => Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Icon(icon, size: 28,color: Colors.grey),
      SizedBox(width: 10),
      Text(
        text,
        style: TextStyle(fontSize: 14, color: Colors.grey),
      ),
    ],
  );
}
