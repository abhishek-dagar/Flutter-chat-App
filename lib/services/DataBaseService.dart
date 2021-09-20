import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';

class DatabaseMethods {
  Future addUserInfoToDB(
      String userId, Map<String, dynamic> userInfoMap) async {
    return await FirebaseFirestore.instance
        .collection("Users")
        .doc(userId)
        .set(userInfoMap);
  }

  Future<Iterable<Map<String, dynamic>>> getUserByPhonenumber(
      String phonenumber) async {
    Iterable<Map<String, dynamic>> result;
    QuerySnapshot stream = await FirebaseFirestore.instance
        .collection("Users")
        .where("phonenumber", isEqualTo: phonenumber)
        .get();
    result = stream.docs.map((qsnap) => qsnap.data()).toList();
    String id = stream.docs.map((qsnap) => qsnap.id).toString();
    if (result.isNotEmpty) {
      result.elementAt(0).addAll({"uid": id});
    }
    return result;
  }

  static createChatRoom(String chatRoomId, chatRoomMap) {
    FirebaseFirestore.instance
        .collection("ChatRoom")
        .doc(chatRoomId)
        .set(chatRoomMap)
        .catchError((e) {
      print(e.toString());
    });
  }

  static addConversationMessage(String chatRoomId, messageMap) {
    FirebaseFirestore.instance
        .collection("ChatRoom")
        .doc(chatRoomId)
        .collection("chats")
        .add(messageMap)
        .catchError((e) {
      print(e.toString());
    });
  }

  static Future getConversationMessage(String chatRoomId) async {
    return await FirebaseFirestore.instance
        .collection("ChatRoom")
        .doc(chatRoomId)
        .collection("chats")
        .orderBy("time", descending: false)
        .snapshots();
  }

  static getChatRooms(String PhoneNumber) async {
    return await FirebaseFirestore.instance
        .collection("ChatRoom")
        .where("users", arrayContains: PhoneNumber)
        .snapshots();
  }
}
