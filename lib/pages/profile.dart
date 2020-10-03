import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Profil'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Kota Banjarmasin', textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,)),
              SizedBox(height: 8.0),
              Text('banjarmasin@mail.com', textAlign: TextAlign.center,),
              SizedBox(height: 16.0),
              FlatButton(
                child: Text('Keluar', style: TextStyle(color: Colors.red),),
                onPressed: () {},
              )
            ]
          ),
        ),
      ),
    );
  }
}