import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobileapp/screens/user_info_screen.dart';
import 'package:mobileapp/screens/add_screen.dart';
import 'package:mobileapp/widgets/item_list.dart';

import 'company_user_info_screen.dart';

class RecruitHomeScreen extends StatefulWidget {
  const RecruitHomeScreen({Key? key, required User user})
      : _user = user,
        super(key: key);

  final User _user;

  @override
  _RecruitHomeScreenState createState() => _RecruitHomeScreenState();
}

class _RecruitHomeScreenState extends State<RecruitHomeScreen> {
  late User _user;

  @override
  void initState() {
    _user = widget._user;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.indigo,
        title: Text("전체 인재"),
        actions: [
          Padding(
              padding: const EdgeInsets.all(5.0),
              child: IconButton(
                icon: _user.photoURL != null
                    ? ClipOval(
                        child: Material(
                          color: Colors.grey,
                          child: Image.network(
                            _user.photoURL!,
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                      )
                    : ClipOval(
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
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CompanyUserInfoScreen(user: _user),
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
          child: ItemList(user: _user),
        ),
      ),
    );
  }
}