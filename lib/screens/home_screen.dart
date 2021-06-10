import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobileapp/screens/user_info_screen.dart';
import 'package:mobileapp/screens/add_screen.dart';
import 'package:mobileapp/widgets/item_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key, required User user})
      : _user = user,
        super(key: key);

  final User _user;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late User _user;
  late String currentLocation;

  @override
  void initState() {
    _user = widget._user;

    super.initState();
    currentLocation = "양덕동";
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
                        ))
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
                        builder: (context) => UserInfoScreen(user: _user),
                      ));
                },
              )),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => AddScreen(user: _user),
            ),
          );
        },
        backgroundColor: Colors.orange,
        child: Icon(
          Icons.add,
          color: Colors.white,
          size: 32,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 16.0,
            right: 16.0,
            bottom: 20.0,
          ),
          child: ItemList(user: _user, where: currentLocation),
        ),
      ),
    );
  }
}
