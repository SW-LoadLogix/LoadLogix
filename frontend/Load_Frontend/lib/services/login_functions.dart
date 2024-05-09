
import 'dart:convert';

import 'package:flutter/material.dart';

//import 'dialog_builders.dart';
import 'package:load_frontend/utils/dialog_builders.dart';
import 'package:load_frontend/models/login_data.dart';

import '../models/signup_data.dart';
import 'base_url.dart';
import 'package:http/http.dart' as http;

class LoginFunctions {

  const LoginFunctions(this.context);
  final BuildContext context;

  Future<String?> onLogin(LoginData loginData) async {
    print("로그인 버튼 클릭이요");
    await Future.delayed(const Duration(seconds: 2));
    var response;
    var responseData;
    try {
      var url = Uri.parse('$baseUrl/worker/login');
      var data = {
        'body': {
          'id': loginData.email,
          'password': loginData.password
        }
      };
      response = await http.post(url, body: json.encode(data), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      });
      if (response.statusCode == 201) {
        responseData = json.decode(response.body);
        print(responseData);
      } else {
        print('Failed to create a post');
      }
    } catch (e) {
      print('Caught error: $e');
    }
    print("LoginData: $loginData");
    return responseData;
  }


  Future<String?> onSignup(SignUpData signupData) async {
    print("가입하기 버튼 클릭이요");
    if (signupData.password != signupData.confirmPassword) {
      print (signupData);
      print ("asdf");
      return 'The passwords you entered do not match, check again.';
    }
    await Future.delayed(const Duration(seconds: 2));

    var response;
    var responseData;
    try {
      var url = Uri.parse('$baseUrl/worker/signup');
      var data = {
        'body':
        {
          'name': signupData.name,
          'id': signupData.email,
          'password': signupData.password
        }
      };
      print ("asasdf!!!");
      response = await http.post(url, body: json.encode(data), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      });

      print ("asasd22222f!!!");
      if (response.statusCode == 201) {
        responseData = json.decode(response.body);
        print(responseData);
      } else {
        print('Failed to create a post');
      }
    } catch (e) {
      print('Caught error: $e');
    }
    return responseData;
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
