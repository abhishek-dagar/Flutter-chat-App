import 'package:chatting_application/ui/screen/loginscreen/LoginScreen.dart';
import 'package:stacked/stacked.dart';

class LoginScreenModel extends BaseViewModel {
  String phonenumber;
  var code;
  String verificationID;
  LoginScreenModel({this.phonenumber, this.code, this.verificationID});
}
