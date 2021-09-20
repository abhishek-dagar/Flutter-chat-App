import 'package:chatting_application/models/UserModel.dart';
import 'package:chatting_application/ui/screen/homescreen/HomeScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:chatting_application/services/auth.dart';

class OTPScreen extends StatefulWidget {
  String phoneNumber;
  UserModel userModel;
  OTPScreen(this.phoneNumber, this.userModel);
  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final _code_controller = TextEditingController();
  FirebaseAuth _auth = FirebaseAuth.instance;
  String _verfiactionCod = "";
  Future<bool> verifyPhone(BuildContext context) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: widget.phoneNumber,
      timeout: Duration(seconds: 120),
      verificationCompleted: (PhoneAuthCredential credential) async {
        Navigator.of(context).pop();
        UserCredential result = await _auth.signInWithCredential(credential);

        User user = result.user;

        if (user != null) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => HomeScreen()));
        } else {
          print("Error");
        }
      },
      verificationFailed: (FirebaseAuthException exception) {
        print("autherror " + exception.code);
      },
      codeSent: (String verificationID, [int resendToken]) {
        setState(() {
          this._verfiactionCod = verificationID;
        });
      },
      codeAutoRetrievalTimeout: (String verificationID, [int resendToken]) {
        setState(() {
          this._verfiactionCod = verificationID;
        });
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    verifyPhone(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            children: <Widget>[_buildContainer(context)],
          )
        ],
      ),
    );
  }

  Widget _buildcodeInput() {
    return Padding(
      padding: EdgeInsets.all(2),
      child: TextFormField(
        controller: this._code_controller,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: "OTP",
        ),
      ),
    );
  }

  Widget _buildConfrimBtn(BuildContext context) {
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
              var details = LoginDetails(userModel: widget.userModel);
              details.verifypin(this._code_controller.text.trim(),
                  this._verfiactionCod, context);
            },
            elevation: 5.0,
            color: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0)),
            child: Text(
              "Confirm",
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

  Widget _buildContainer(BuildContext context) {
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
                      "OTP",
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
                  child: this._buildcodeInput(),
                ),
                SizedBox(
                  height: 20,
                ),
                this._buildConfrimBtn(context),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
