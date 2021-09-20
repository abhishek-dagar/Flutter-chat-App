import 'package:chatting_application/contant.dart';
import 'package:chatting_application/helper_function/Constants.dart';
import 'package:chatting_application/helper_function/Shared_preference_helper.dart';
import 'package:chatting_application/services/DataBaseService.dart';
import 'package:chatting_application/ui/screen/individualScreen/message_screen.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  Stream chatRoomStream;

  String convertnumber(element) {
    String phonenumber = element.phones.elementAt(0).value;
    String realnumber = "";
    for (int i = 3; i < phonenumber.length; i++) {
      if (phonenumber[i] != " ") {
        realnumber = realnumber + phonenumber[i];
      }
    }
    return realnumber;
  }

  getNameFromContact(String PhoneNumber) {
    for (int i = 0; i < Constants.MyContacts.length; i++) {
      String Number = convertnumber(Constants.MyContacts[i]);
      if (PhoneNumber.substring(3) == Number) {
        return Constants.MyContacts[i].displayName;
      }
    }
  }

  Widget chatRoomList() {
    return StreamBuilder(
      stream: chatRoomStream,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  String Name = getNameFromContact(
                      snapshot.data.docs[index].data()["users"][0]);
                  return Name != null
                      ? chatRoomTitle(
                          Name, snapshot.data.docs[index].data()["chatRoomID"])
                      : Container();
                },
              )
            : Container();
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    // getNameFromContact("12345");
    getUserinfo();
    DatabaseMethods.getChatRooms(Constants.MyPhoneNumber).then((value) {
      setState(() {
        chatRoomStream = value;
      });
    });
    super.initState();
  }

  getUserinfo() async {
    Constants.MyPhoneNumber = await SharedPreferenceHelper.getUserPhonenumber();
  }

  @override
  Widget build(BuildContext context) {
    return Container(child: chatRoomList());
  }
}

class chatRoomTitle extends StatelessWidget {
  final String userName;
  final String chatRoomId;
  chatRoomTitle(this.userName, this.chatRoomId);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MessageScreen(userName, chatRoomId)));
      },
      child: Container(
        // color: kSecondaryColor,
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 10),
        child: Row(
          children: [
            Container(
              height: 40,
              width: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: kPrimaryColor,
                  borderRadius: BorderRadius.circular(40)),
              child: Text(
                "${userName.substring(0, 1).toUpperCase()}",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
            SizedBox(
              width: 8,
            ),
            Text(
              userName,
              style: TextStyle(
                fontSize: 25,
              ),
            )
          ],
        ),
      ),
    );
  }
}
