import 'package:flutter/material.dart';
import 'package:mobileapp/screens/home_screen.dart';
import 'screens/sign_in_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recruitment App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        brightness: Brightness.dark,
      ),
      home: SignInScreen(),
      // routes: {
      //   '/': (context) => HomeScreen(user: _user),
      // },
    );
  }
}