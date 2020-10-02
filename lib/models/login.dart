import 'package:sijaka/models/profile.dart';

class Login {
  int id;
  String email;
  List<dynamic> profile;
  String token;

  Login({this.id, this.email, this.profile, this.token});

  factory Login.fromJson(Map<String, dynamic> json) {
    return Login(
      id: json['id'],
      email: json['email'],
      profile: json['profile'],
      token: json['token']
    );
  } 
}