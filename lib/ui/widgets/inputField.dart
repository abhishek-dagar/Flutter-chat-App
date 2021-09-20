import 'package:chatting_application/helper_function/Constants.dart';
import 'package:chatting_application/services/DataBaseService.dart';
import 'package:flutter/material.dart';

class InputchatField extends StatefulWidget {
  final chatRoomId;
  InputchatField(this.chatRoomId);
  @override
  _InputchatField createState() => _InputchatField();
}

class _InputchatField extends State<InputchatField> {
  FocusNode focusNode = FocusNode();
  TextEditingController messageController = TextEditingController();

  sendMessage() {
    if (messageController.text.isNotEmpty) {
      Map<String, dynamic> messageMap = {
        "message": messageController.text,
        "sendBy": Constants.MyPhoneNumber,
        "time": DateTime.now().microsecondsSinceEpoch,
      };
      DatabaseMethods.addConversationMessage(widget.chatRoomId, messageMap);
      messageController.text = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20 / 2),
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
            offset: Offset(0, 4),
            blurRadius: 32,
            color: Colors.black.withOpacity(0.08))
      ]),
      child: SafeArea(
        child: Row(
          children: [
            IconButton(icon: Icon(Icons.mic), onPressed: null),
            // SizedBox(width: 20),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20 * 0.75),
                decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(40)),
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                          // focus mode;
                          focusNode: focusNode,
                          controller: messageController,
                          textAlignVertical: TextAlignVertical.center,
                          // keyboardType: TextInputType.multiline,
                          maxLines: 5,
                          minLines: 1,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Type a message",
                          )),
                    ),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                sendMessage();
              },
              borderRadius: BorderRadius.circular(50),
              child: CircleAvatar(
                child: Icon(Icons.send),
              ),
            )
          ],
        ),
      ),
    );
  }
}
