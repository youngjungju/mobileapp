import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobileapp/screens/sign_in_screen.dart';
import 'package:mobileapp/utils/authentication.dart';
import 'package:mobileapp/widgets/my_item_list.dart';

class UserInfoScreen extends StatefulWidget {
  const UserInfoScreen({Key? key, required User user})
      : _user = user,
        super(key: key);

  final User _user;

  @override
  _UserInfoScreenState createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  late User _user;
  bool _isSigningOut = false;

  Route _routeToSignInScreen() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => SignInScreen(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(-1.0, 0.0);
        var end = Offset.zero;
        var curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

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
        title: Text("프로필"),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.indigo,
              ),
              padding: const EdgeInsets.only(
                top: 20.0,
                left: 16.0,
                right: 16.0,
                bottom: 20.0,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(),
                  SizedBox(
                    width: 100,
                    height: 100,
                    child: _user.photoURL != null
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
                                  size: 60,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    _user.displayName!,
                    style: TextStyle(
                      color: Colors.yellow,
                      fontSize: 26,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    '( ${_user.email!} )',
                    style: TextStyle(
                      color: Colors.orange,
                      fontSize: 20,
                      letterSpacing: 0.5,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    '구글 계정 로그인',
                    style: TextStyle(
                        color: Colors.grey, fontSize: 14, letterSpacing: 0.2),
                  ),
                  SizedBox(height: 8.0),
                  _isSigningOut
                      ? CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                        )
                      : ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                              Colors.redAccent,
                            ),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          onPressed: () async {
                            setState(() {
                              _isSigningOut = true;
                            });
                            await Authentication.signOut(context: context);
                            setState(() {
                              _isSigningOut = false;
                            });
                            Navigator.pop(context);
                            Navigator.of(context)
                                .pushReplacement(_routeToSignInScreen());
                          },
                          child: Padding(
                            padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                            child: Text(
                              '로그아웃',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                letterSpacing: 2,
                              ),
                            ),
                          ),
                        ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.only(
                left: 24.0,
                right: 24.0,
                bottom: 12.0,
              ),
              color: Colors.indigo,
              child: Row(
                children: [
                  Text(
                    '내 이력서',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22.0,
                      letterSpacing: 1,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: MyItemList(user: _user),
            ),
          ],
        ),
      ),
    );
  }
}
