import 'package:chatting_application/contant.dart';
import 'package:chatting_application/helper_function/Constants.dart';
import 'package:chatting_application/services/DataBaseService.dart';
import 'package:flutter/material.dart';
import 'package:chatting_application/ui/widgets/inputField.dart';

class MessageScreen extends StatefulWidget {
  final String name;
  final chatRoomId;
  MessageScreen(this.name, this.chatRoomId);
  @override
  _MessageScreenState createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  Stream chatMessageStream;

  @override
  void initState() {
    // TODO: implement initState
    DatabaseMethods.getConversationMessage(widget.chatRoomId).then((value) {
      setState(() {
        chatMessageStream = value;
      });
    });
    super.initState();
  }

  Widget chatMessageList() {
    return StreamBuilder(
        stream: chatMessageStream,
        builder: (context, snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    return MessageTile(
                        snapshot.data.docs[index].data()["message"],
                        snapshot.data.docs[index].data()["sendBy"] ==
                            Constants.MyPhoneNumber);
                  })
              : Container();
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.name),
        ),
        body: Container(
          child: Stack(
            children: [
              chatMessageList(),
              Container(
                alignment: Alignment.bottomCenter,
                child: InputchatField(widget.chatRoomId),
              )
            ],
          ),
        ));
  }
}

class MessageTile extends StatelessWidget {
  final String message;
  final bool isSendByme;
  MessageTile(this.message, this.isSendByme);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          left: isSendByme ? 0 : 10, right: isSendByme ? 10 : 0),
      margin: EdgeInsets.symmetric(vertical: 8),
      width: MediaQuery.of(context).size.width,
      alignment: isSendByme ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: isSendByme
                    ? [
                        kPrimaryColor,
                        kPrimaryColor,
                      ]
                    : [kSecondaryColor, kSecondaryColor]),
            borderRadius: isSendByme
                ? BorderRadius.only(
                    topLeft: Radius.circular(23),
                    topRight: Radius.circular(23),
                    bottomLeft: Radius.circular(23),
                  )
                : BorderRadius.only(
                    topLeft: Radius.circular(23),
                    topRight: Radius.circular(23),
                    bottomRight: Radius.circular(23),
                  )),
        child: Text(message),
      ),
    );
  }
}
