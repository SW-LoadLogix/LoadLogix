import 'package:flutter/cupertino.dart';


class UserStore extends ChangeNotifier {
    String userName = '';
    String token = '';

    void saveToken(String token) {
        this.token = token;
        notifyListeners();
    }
    void deleteToken() {
        this.token = '';
        notifyListeners();
    }
}
