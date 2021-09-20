import 'dart:developer';

class UserModel {
  String id;
  String userName;
  String phonNumber;
  bool logedin = false;
  UserModel({this.id, this.userName, this.phonNumber, this.logedin});
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': userName,
      'PhoneNumber': phonNumber,
      'LogedIn': logedin,
    };
  }
}
