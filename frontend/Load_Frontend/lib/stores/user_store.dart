import 'package:flutter/cupertino.dart';


class UserStore extends ChangeNotifier {
    String userName = '';
    String token = '';

    Future<void> saveToken(String token) async {
        this.token = token;
        notifyListeners();
    }
    void deleteToken() {
        this.token = '';
        notifyListeners();
    }
}
