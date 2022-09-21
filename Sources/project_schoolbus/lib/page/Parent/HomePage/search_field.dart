import '../../../importer.dart';

class serach_field extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<serach_field> {
  TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 0, right: 0, left: 10),
      child: AnimSearchBar(
        width: 230,
        textController: textController,

        helpText: "ค้นหา...",
        color: const Color(0xE5E5E5FF),
        rtl: true,
        suffixIcon: const Icon(Icons.search),
        onSuffixTap: () {
          setState(() {
            textController.clear();
          });
        },
      ),
    );
  }
}