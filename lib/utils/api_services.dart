import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sijaka/models/login.dart';
import 'package:sijaka/utils/sharepref.dart';

class ApiServices {

  final baseUrl = "https://sijaka.kartinimedia.com/api/web/index.php?r=v1/auth";

  Future<bool> login(String username, String password) async {
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
      SharePref().simpanLogin(login);

      return true;
    } else {
      return false;
    }
  }

  Future dataPresentase(String token) async {
    var response = await http.get(
      "$baseUrl/data",
      headers: {
         "Accept": "application/json",
         "Content-Type": "application/json",
         'Authorization': 'Bearer $token'
       },
    );

    if(response.statusCode == 200) {
      print("berhasil");
      print(response.body);
    }
  }
}