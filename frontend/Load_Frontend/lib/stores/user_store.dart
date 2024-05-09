import 'package:flutter/cupertino.dart';

class UserStore extends ChangeNotifier {
  String? _email;
  String? _password;

  String? get email => _email;
  String? get password => _password;


  void setEmail(String email) {
    _email = email;
    notifyListeners();
  }

  void setPassword(String password) {
    _password = password;
    notifyListeners();
  }
}