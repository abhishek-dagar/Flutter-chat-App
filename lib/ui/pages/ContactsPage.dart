import 'dart:convert';

import 'package:chatting_application/helper_function/Constants.dart';
import 'package:chatting_application/ui/pages/ContactModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:chatting_application/services/DataBaseService.dart';
import 'package:chatting_application/ui/screen/individualScreen/message_screen.dart';

class ContactsPages extends StatefulWidget {
  @override
  _ContactsPagesState createState() => _ContactsPagesState();
}

class _ContactsPagesState extends State<ContactsPages> {
  List<Contact> contacts = Constants.MyContacts;
  Stream userStream;
  bool availabe = false;
  String chatRoomID;

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

  getchatRoomID(String a, String b) {
    int a1 = int.parse(a.substring(3, a.length));
    int b1 = int.parse(b.substring(3, b.length));
    if (a1 > b1) {
      return a1.toString() + b1.toString();
    } else {
      return b1.toString() + a1.toString();
    }
  }

  createChatroomandStartConversation(index) {
    Contact contact = contacts[index];
    String userPhoneNumber = convertnumber(contact);
    List<String> users = [userPhoneNumber, Constants.MyPhoneNumber];
    chatRoomID = getchatRoomID(users[0], users[1]);
    Map<String, dynamic> chatRoomMap = {
      "users": users,
      "chatRoomID": chatRoomID,
    };
    DatabaseMethods.createChatRoom(chatRoomID, chatRoomMap);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                MessageScreen(contact.displayName, chatRoomID)));
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: contacts.length,
          itemBuilder: (context, index) {
            Contact contact = contacts[index];
            return InkWell(
              onTap: () {
                createChatroomandStartConversation(index);
              },
              child: ListTile(
                title: Text(contact.displayName),
                leading: (contact.avatar != null && contact.avatar.length > 0)
                    ? CircleAvatar(
                        backgroundImage: MemoryImage(contact.avatar),
                      )
                    : CircleAvatar(child: Text(contact.initials())),
              ),
            );
          },
        ),
      ),
    ]);
  }
}
