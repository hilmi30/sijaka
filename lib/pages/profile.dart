import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sijaka/utils/api_services.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  bool loading = false;
  String namaKota = "";
  String username = "";
  String token = "";

  @override
  void initState() {
    super.initState();
    getLocalData();
  }

  void getLocalData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      namaKota = prefs.getString('full_name');
      username = prefs.getString('email');
      token = prefs.getString('token');
    });
  }

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
              Visibility(
                visible: loading,
                child: Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30),
                  child: Column(
                    children: [
                      LinearProgressIndicator(),
                      SizedBox(height: 32,)
                    ],
                  ),
                )
              ),
              Text(namaKota ?? "", textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,)),
              SizedBox(height: 8.0),
              Text(username ?? "", textAlign: TextAlign.center,),
              SizedBox(height: 16.0),
              FlatButton(
                child: Text('Keluar', style: TextStyle(color: Colors.red),),
                onPressed: () {
                  setState(() {
                    loading = !loading;
                  });
                  ApiServices().logout(token).then((status) {
                    if (status) {
                      Navigator.pushReplacementNamed(context, '/login');
                    }
                  });
                },
              )
            ]
          ),
        ),
      ),
    );
  }
}