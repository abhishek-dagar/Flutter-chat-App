import 'package:chatting_application/contant.dart';
import 'package:chatting_application/helper_function/Shared_preference_helper.dart';
import 'package:chatting_application/ui/screen/homescreen/HomeScreen.dart';
import 'package:chatting_application/ui/screen/startupscreen/startupscreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:chatting_application/helper_function/Constants.dart';
import 'package:chatting_application/services/DataBaseService.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  bool isuserLogedIn = false;

  @override
  void initState() {
    // TODO: implement initState
    getLogedInState();
    getAllContacts();
    super.initState();
  }

  getLogedInState() async {
    await SharedPreferenceHelper.getUserPhonenumber().then((value) => {
          if (value != null)
            {
              setState(() {
                isuserLogedIn = true;
              })
            }
        });
  }

  getAllContacts() async {
    List<Contact> _contacts =
        (await ContactsService.getContacts(withThumbnails: false)).toList();
    _contacts.forEach((element) async {
      String realnumber = convertnumber(element);
      Iterable<Map<String, dynamic>> productName =
          await DatabaseMethods().getUserByPhonenumber(realnumber);
      if (productName.elementAt(0)["phonenumber"] != Constants.MyPhoneNumber &&
          productName.isNotEmpty) {
        Constants.MyContacts.add(element);
        setState(() {
          // ContactModel cont = ContactModel(
          //     phoneNumber: productName.elementAt(0)["phonenumber"],
          //     username: productName.elementAt(0)["username"],
          //     id: productName.elementAt(0)["uid"]);
          // avialContacts.add(cont);
          // contacts.add(element);
        });
      }
    });
  }

  String convertnumber(Contact element) {
    String phonenumber = element.phones.elementAt(0).value;
    String realnumber = "";
    for (int i = 0; i < phonenumber.length; i++) {
      if (phonenumber[i] != " ") {
        realnumber = realnumber + phonenumber[i];
      }
    }
    return realnumber;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: kPrimaryColor,
      ),
      home: isuserLogedIn != null
          ? isuserLogedIn
              ? HomeScreen()
              : StartupScreen()
          : RenderScreen(),
    );
  }
}

class RenderScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
          child: Column(
            children: [
              Spacer(
                flex: 2,
              ),
              Image.asset(
                "assets/images/Logo_light.png",
                height: 146,
              ),
              SizedBox(
                height: kDefaultPadding,
              ),
              Spacer(
                flex: 2,
              )
            ],
          ),
        ),
      ),
    );
  }
}
