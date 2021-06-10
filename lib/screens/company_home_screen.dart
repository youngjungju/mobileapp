import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobileapp/widgets/company_item_list.dart';

import 'company_user_info_screen.dart';

class CompanyHomeScreen extends StatefulWidget {
  const CompanyHomeScreen({Key? key, required User user})
      : _user = user,
        super(key: key);

  final User _user;

  @override
  _CompanyHomeScreenState createState() => _CompanyHomeScreenState();
}

class _CompanyHomeScreenState extends State<CompanyHomeScreen> {
  late User _user;
  late String currentLocation;

  @override
  void initState() {
    _user = widget._user;
    currentLocation = "양덕동";

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.indigo,
        title: GestureDetector(
          onTap: () {
            print("click");
          },
          child: PopupMenuButton<String>(
            offset: Offset(0, 30),
            onSelected: (String where) {
              setState(() {
                currentLocation = where;
              });
            },
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(value: "양덕동", child: Text("양덕동")),
                PopupMenuItem(value: "장량동", child: Text("장량동")),
                PopupMenuItem(value: "두호동", child: Text("두호동")),
                PopupMenuItem(value: "장성동", child: Text("장성동")),
              ];
            },
            child: Row(
              children: [
                Text(currentLocation),
                Icon(Icons.arrow_drop_down),
              ],
            ),
          ),
        ),
        //title: Text("전체 인재"),
        actions: [
          Padding(
              padding: const EdgeInsets.all(5.0),
              child: IconButton(
                icon: _user.photoURL != null
                    ? Hero(
                        tag: 'profile',
                        child: ClipOval(
                          child: Material(
                            color: Colors.grey,
                            child: Image.network(
                              _user.photoURL!,
                              fit: BoxFit.fitHeight,
                            ),
                          ),
                        ),
                      )
                    : Hero(
                        tag: 'profile',
                        child: ClipOval(
                          child: Material(
                            color: Colors.grey,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Icon(
                                Icons.person,
                                size: 10,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ),
                      ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            CompanyUserInfoScreen(user: _user),
                      ));
                },
              ))
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 16.0,
            right: 16.0,
            bottom: 20.0,
          ),
          child: CompanyItemList(user: _user, where: currentLocation),
        ),
      ),
    );
  }
}
