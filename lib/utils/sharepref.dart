import 'package:shared_preferences/shared_preferences.dart';
import 'package:sijaka/models/login.dart';

class SharePref {
  void simpanLogin(Login login) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    prefs.setInt('id', login.id);
    prefs.setString('email', login.email);
    prefs.setString('token', login.token);
  }
}