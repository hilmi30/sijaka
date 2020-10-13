import 'package:flutter/material.dart';
import 'package:sijaka/utils/api_services.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: Stack(
            alignment: AlignmentDirectional.center,
            children: [
              Visibility(
                visible: loading,
                child: CircularProgressIndicator()
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: Form(
                  key: _formKey,
                  child: ListView(
                    children: <Widget>[
                      SizedBox(height: 100.0),
                      Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(10),
                          child: Text(
                            'Si Jaka',
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.w500,
                                fontSize: 30),
                          )),
                      SizedBox(height: 100.0),
                      Container(
                        padding: EdgeInsets.all(10),
                        child: TextFormField(
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'tidak boleh kosong';
                            }
                            return null;
                          },
                          enabled: !loading,
                          controller: nameController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Username',
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                        child: TextFormField(
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'tidak boleh kosong';
                            }
                            return null;
                          },
                          enabled: !loading,
                          obscureText: true,
                          controller: passwordController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Password',
                          ),
                        ),
                      ),
                      SizedBox(height: 32.0),
                      Container(
                          height: 50,
                          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: RaisedButton(
                            textColor: Colors.white,
                            color: Colors.blue,
                            child: Text('MASUK'),
                            onPressed: !loading ? () {
                              if (_formKey.currentState.validate()) {
                                setState(() {
                                  loading = !loading;
                                });

                                ApiServices().login(nameController.text, passwordController.text).then((status) {
                                  setState(() {
                                    loading = !loading;
                                  });

                                  if (status) {
                                    Navigator.pushNamedAndRemoveUntil(
                                      context, '/home', ModalRoute.withName('/home'));
                                  } else {
                                    showDialog(
                                      barrierDismissible: false,
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text("Kesalahan"),
                                          content: Text("Username atau password salah"),
                                          actions: [
                                            FlatButton(
                                              child: Text("Tutup"),
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                            )
                                          ],
                                        );
                                      },
                                    );
                                  }
                                });
                              }
                            } : null,
                          )),
                    ],
                  ),
                )),
            ],
          )),
    );
  }
}