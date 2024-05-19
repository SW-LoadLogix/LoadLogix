
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:load_frontend/stores/user_store.dart';

//import 'dialog_builders.dart';
import 'package:load_frontend/utils/dialog_builders.dart';
import 'package:load_frontend/models/login_data.dart';
import 'package:provider/provider.dart';

import '../models/login_response_wrapper_data.dart';
import '../models/signup_response_wrapper_data.dart';
import '../models/signup_data.dart';
import '../stores/user_secure_store.dart';
import 'base_url.dart';
import 'package:http/http.dart' as http;

class LoginFunctions {
  const LoginFunctions(this.context);
  final BuildContext context;

  Future<String?> onLogin(LoginData loginData) async {
    print("로그인 버튼 클릭");
    await Future.delayed(const Duration(seconds: 2));
    LoginResponseResult? loginResult = await UserService().LoginApiCall(loginData);
    if (loginResult == null){
      return "failed";
    }
    else{
      await Provider.of<UserStore>(context, listen: false).saveToken(loginResult.token);
      print ("Token : ${Provider.of<UserStore>(context, listen: false).token}");
      //UserSecureStorage().saveToken(loginResult.token);
      return "success";
    }
  }

  Future<String?> onSignUp(SignUpData signUpData) async {
    print("가입하기 버튼 클릭");
    await Future.delayed(const Duration(seconds: 2));
    if (signUpData.password != signUpData.confirmPassword) {
      return "failed";
    }
    var signUpResult = await UserService().SignUpApiCall(signUpData);
    if (signUpResult == null){
      return "failed";
    }
    else{
      return "success";
    }
  }

  // Future<String?> socialLogin(String type) async {
  //   await Future.delayed(const Duration(seconds: 2));
  //   return null;
  // }

  Future<String?> onForgotPassword(String email) async {
    DialogBuilder(context).showLoadingDialog();
    await Future.delayed(const Duration(seconds: 2));

    // Navigator.of(context).pop();
    // Navigator.of(context).pushNamed('/forgotPass');
    return null;
  }
}


class UserService{
  final baseUrl = dotenv.get("BASE_URL");
  Future<LoginResponseResult?> LoginApiCall(LoginData loginData) async {
    await Future.delayed(const Duration(seconds: 2));
    try {
      var url = Uri.parse('${baseUrl}/api/worker/login');
      var data = {
        'id': loginData.email,
        'password': loginData.password
      };
      var response = await http.post(url, body: json.encode(data), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      });

      print (response.statusCode);
      print(response.body);
      if (response.statusCode == 200) {
        var responseData = json.decode(response.body);
        print(responseData.toString());
        LoginResponseWrapperData loginResponseWrapperData = LoginResponseWrapperData.fromJson(responseData);
        print(loginResponseWrapperData.toString());


        return loginResponseWrapperData.result;
      } else {
        print('Failed to create a post');
      }
    } catch (e) {
      print('Caught error: $e');
    }
    return null;
  }


  Future<SignupResponseResult?> SignUpApiCall(SignUpData signupData) async {
    if (signupData.password != signupData.confirmPassword) {
      return null;
    }
    await Future.delayed(const Duration(seconds: 2));
    try {
      var url = Uri.parse('${baseUrl}/api/worker/signup');
      var data = {
        'name': signupData.name,
        'id': signupData.email,
        'password': signupData.password
      };
      var response = await http.post(url, body: json.encode(data), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      });

      print (response.statusCode);
      print(response.body);
      if (response.statusCode == 200) {
        var responseData = json.decode(response.body);
        SignupResponseWrapperData signupResponse = SignupResponseWrapperData.fromJson(responseData);
        print(signupResponse);
        return signupResponse.result;
      } else {
        print('Failed to create a post');
      }
    } catch (e) {
      print('Caught error: $e');
    }
    return null;
  }
}
