
import 'package:flutter/material.dart';

class SignInUpPage extends StatelessWidget {
  const SignInUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('로그인 페이지'), // 앱바 타이틀
      ),
      body: Center(
        child: Text('로그인 페이지'), // 본문에 표시될 텍스트
      ),
    );
  }
}