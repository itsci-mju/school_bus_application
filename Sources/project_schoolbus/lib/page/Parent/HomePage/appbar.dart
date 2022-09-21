import '../../../importer.dart';

class SchoolbusAppBarPage extends StatefulWidget {
  const SchoolbusAppBarPage({Key? key}) : super(key: key);

  @override
  State<SchoolbusAppBarPage> createState() => SchoolbusAppBar();
}

class SchoolbusAppBar extends State<SchoolbusAppBarPage>  {
  String username = getSharedPreferences.getUsername() ?? '';
  String firstname = getSharedPreferences.getFirstname() ?? '';
  String lastname = getSharedPreferences.getLastname() ?? '';
  String profile = getSharedPreferences.getProfile() ?? '';
  Parent? p ;

  @override
  void initState() {
    getProfile();
    super.initState();
  }

  void getProfile(){
    var log = Logger();
    Map<String, dynamic> map = jsonDecode(profile);
    p = Parent.fromJson(map);
  }

  @override
  Widget build(BuildContext context) {

    return Container(
        decoration:  BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: <Color>[
                Colors.amber,
                Colors.yellow
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 5,
                blurRadius: 5,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
        ),
        margin: const EdgeInsets.only(),
        padding: const EdgeInsets.fromLTRB(40, 20, 20, 20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'ยินดีตอนรับ',
                      style:
                      const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Text(
                          firstname,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black.withOpacity(0.6),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          lastname,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black.withOpacity(0.6),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                  child: Container (
                    height: 100,
                    width: 100,
                    decoration:  BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(50.0)),
                      image: DecorationImage(
                          image: NetworkImage(p!.image_profile),
                          fit: BoxFit.cover)
                     ),
                    ),
                  ),
              ],
            ),
          ],
        ));
  }
}