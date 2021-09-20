import 'package:chatting_application/contant.dart';
import 'package:chatting_application/ui/pages/ContactsPage.dart';
import 'package:flutter/material.dart';
import 'package:chatting_application/ui/screen/SearchScreen/SearchSreen.dart';
import 'package:chatting_application/ui/pages/Chatspage.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectindex = 0;
  final actionicon = [
    Icon(Icons.search),
    Icon(Icons.refresh),
    Icon(Icons.search)
  ];
  final tabs = [ChatPage(), ContactsPages(), Text("Profile")];
  final titles = ["Chats", "Contacts", "Profile"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(titles[_selectindex]),
        actions: [
          PopupMenuButton(
              onSelected: (value) {},
              itemBuilder: (BuildContext context) {
                return [
                  PopupMenuItem(
                    child: Text("New Group"),
                    value: "New Group",
                  ),
                  PopupMenuItem(
                    child: Text("Started Messages"),
                    value: "Started Messages",
                  ),
                  PopupMenuItem(
                    child: Text("Settings"),
                    value: "Settings",
                  ),
                ];
              })
        ],
      ),
      body: tabs[_selectindex],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_selectindex == 1) {
            _selectindex = 1;
          } else {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => SearchScreen()));
          }
        },
        child: actionicon[_selectindex],
        backgroundColor: kPrimaryColor,
      ),
      bottomNavigationBar: buildBottomNavigationBar(),
    );
  }

  BottomNavigationBar buildBottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: _selectindex,
      type: BottomNavigationBarType.fixed,
      onTap: (value) {
        setState(() {
          _selectindex = value;
        });
      },
      items: [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.messenger,
          ),
          label: "chats",
        ),
        BottomNavigationBarItem(icon: Icon(Icons.people), label: "People"),
        BottomNavigationBarItem(
            icon: CircleAvatar(
              backgroundImage: AssetImage("assets/images/Logo_light.png"),
              backgroundColor: Colors.white,
              radius: 14,
            ),
            label: "Profile"),
      ],
    );
  }
}
