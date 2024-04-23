import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({required Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('홈 페이지'), // 앱바 타이틀
      ),
      body:
      Column(
        children: <Widget>[
          Expanded(
            child: ListView(
              children: <Widget>[
                ListTile(title: Text("항목 1")),
                ListTile(title: Text("항목 2")),
                ElevatedButton(
                  onPressed: (){
                    Navigator.pushNamed(context, '/sign-in-up');
                  },
                  child: const Text('로그인 페이지로 이동'),
                )
              ],
            ),
          ),
        ],
      )
    );
  }
}