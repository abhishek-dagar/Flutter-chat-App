import 'package:chatting_application/models/UserModel.dart';
import 'package:chatting_application/ui/screen/loginscreen/LoginScreenModel.dart';
import 'package:chatting_application/ui/screen/loginscreen/OTPScreen.Dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key key}) : super(key: key);
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String phonenumber;
  UserModel userModel;
  var code;
  final _phone_controller = TextEditingController();
  final _username_controller = TextEditingController();
  String message = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginScreenModel>.reactive(
      builder: (context, model, child) => Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.green,
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[_buildContainer()],
            )
          ],
        ),
      ),
      viewModelBuilder: () => LoginScreenModel(phonenumber: this.phonenumber),
    );
  }

  Widget _buildPhoneInput() {
    return Padding(
      padding: EdgeInsets.all(2),
      child: TextFormField(
        controller: this._phone_controller,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: "91 Phone Number",
            prefixIcon: Icon(
              Icons.phone,
              color: Colors.green,
            )),
      ),
    );
  }

  Widget _buildUsernameInput() {
    return Padding(
      padding: EdgeInsets.all(2),
      child: TextFormField(
        controller: this._username_controller,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: "Username",
            prefixIcon: Icon(
              Icons.supervised_user_circle_rounded,
              color: Colors.green,
            )),
      ),
    );
  }

  Widget _buildLoginBtn() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(2),
          height: 1.4 * (MediaQuery.of(context).size.height / 20),
          width: 5 * (MediaQuery.of(context).size.width / 10),
          margin: EdgeInsets.only(bottom: 20),
          child: RaisedButton(
            onPressed: () {
              String pNo = this._phone_controller.text;
              String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
              RegExp regExp = new RegExp(pattern);
              if (pNo != "") {
                if (regExp.hasMatch(pNo)) {
                  setState(() {
                    this.phonenumber = this._phone_controller.text.trim();
                    this.phonenumber = phonenumber;
                    // this.clearBtn_height =
                    //     1.4 * (MediaQuery.of(context).size.height / 20);
                    this.message = "";
                    userModel = UserModel(
                        userName: this._username_controller.text.trim(),
                        phonNumber: this.phonenumber);
                  });
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              OTPScreen(this.phonenumber, this.userModel)),
                      (Route) => false);
                } else {
                  setState(() {
                    this.message = "Invalid Phone number";
                  });
                }
              } else {
                setState(() {
                  this.message = "Enter the Number";
                });
              }
            },
            elevation: 5.0,
            color: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0)),
            child: Text(
              "Login",
              style: TextStyle(
                color: Colors.green,
                letterSpacing: 1.5,
                fontSize: MediaQuery.of(context).size.height / 40,
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget _buildContainer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.7,
            width: MediaQuery.of(context).size.width * 0.8,
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Login",
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height / 30,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20 * 0.75),
                  width: MediaQuery.of(context).size.width * 0.7,
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: this._buildUsernameInput(),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20 * 0.75),
                  width: MediaQuery.of(context).size.width * 0.7,
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: this._buildPhoneInput(),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(message),
                this._buildLoginBtn(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
