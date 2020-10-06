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

  @override
  void initState() {
    super.initState();
    getLocalData();
  }

  void getLocalData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      namaKota = prefs.getString('full_name');
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
                visible: true,
                child: LinearProgressIndicator()
              ),
              Text(namaKota ?? "", textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,)),
              SizedBox(height: 8.0),
              Text('banjarmasin@mail.com', textAlign: TextAlign.center,),
              SizedBox(height: 16.0),
              FlatButton(
                child: Text('Keluar', style: TextStyle(color: Colors.red),),
                onPressed: () {
                  showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text("Keluar"),
                        content: Text("Yakin ingin keluar?"),
                        actions: [
                          FlatButton(
                            child: Text("Ya"),
                            onPressed: !loading ? () async {
                              Navigator.pop(context);
                              setState(() {
                                loading = !loading;
                              });
                              SharedPreferences prefs = await SharedPreferences.getInstance();
                              var token = prefs.getString('token');
                              ApiServices().logout(token).then((status) {
                                if (status) {
                                  Navigator.pushNamedAndRemoveUntil(
                                    context, '/login', ModalRoute.withName('/login'));
                                }
                              });
                            } : null,
                          ),
                          FlatButton(
                            child: Text("Tidak"),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          )
                        ],
                      );
                    },
                  );
                },
              )
            ]
          ),
        ),
      ),
    );
  }
}