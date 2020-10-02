import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sijaka/models/login.dart';

class ApiServices {

  final baseUrl = "https://sijaka.kartinimedia.com/api/web/index.php?r=v1/auth";

  void simpanLogin(Login login) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    prefs.setInt('id', login.id);
    prefs.setString('email', login.email);
    prefs.setString('token', login.token);

    print(prefs.getString('email'));
  }

  Future<bool> login(String username, String password) async {
    // Await the http get response, then decode the json-formatted response.
    var response = await http.post(
      "$baseUrl/login",
      body: {
        'username': username,
        'password': password
      },
      headers: {
         "Accept": "application/json",
         "Content-Type": "application/x-www-form-urlencoded"
       },
       encoding: Encoding.getByName("utf-8")

    );

    if (response.statusCode == 200) {
      if (response.body == "false") return false;

      var login = Login.fromJson(jsonDecode(response.body));
      // simpan ke lokal
      simpanLogin(login);

      return true;
    } else {
      return false;
    }
  }
}