import 'package:chatting_application/helper_function/Shared_preference_helper.dart';
import 'package:chatting_application/models/UserModel.dart';
import 'package:chatting_application/services/DataBaseService.dart';
import 'package:chatting_application/ui/screen/homescreen/HomeScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginDetails {
  FirebaseAuth _auth = FirebaseAuth.instance;
  UserModel userModel;
  LoginDetails({this.userModel});

  // getCurrentUser() async {
  //   return await _auth.currentUser;
  // }

  Future<bool> verifypin(
      var pin, String _verfiactionCod, BuildContext context) async {
    AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verfiactionCod, smsCode: pin);
    UserCredential result =
        await _auth.signInWithCredential(credential).catchError((e) {
      return e;
    });
    User user = result.user;
    if (user != null) {
      // Navigator.pop();
      userModel = UserModel(
          id: user.uid,
          userName: userModel.userName,
          phonNumber: user.phoneNumber,
          logedin: true);
      SharedPreferenceHelper.saveUserName(userModel.userName);
      SharedPreferenceHelper.saveUserId(userModel.id);
      SharedPreferenceHelper.saveUserPhonenumber(userModel.phonNumber);
      Map<String, dynamic> userInfoMap = {
        "username": userModel.userName,
        "phonenumber": userModel.phonNumber,
      };
      DatabaseMethods().addUserInfoToDB(userModel.id, userInfoMap).then(
          (value) => Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => HomeScreen())));
    }
  }

  bool checkLogedin() {
    if (_auth.currentUser != null) {
      return true;
    } else {
      return false;
    }
  }
}
