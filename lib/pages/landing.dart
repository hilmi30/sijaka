import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  
  FirebaseMessaging fm = FirebaseMessaging();

  _LandingPageState() {
    fm.getToken().then((fcmToken) {
      checkUser(fcmToken);
    });
    fm.configure();
  }

  void checkUser(String fcmToken) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('fcmToken', fcmToken);
    var token = prefs.getString('token');
    if (token == null || token == '') {
      Navigator.pushReplacementNamed(context, '/login');
    } else {
      Navigator.pushReplacementNamed(context, '/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}