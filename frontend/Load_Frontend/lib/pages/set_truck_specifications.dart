import 'package:flutter/material.dart';

import '../components/nav_rail.dart';

class SetTruckSpecificationPage extends StatelessWidget {
  const SetTruckSpecificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Row(
        children: [
          Flexible(
            child: MyNav(),
          ),
          Flexible(
              child: Center(
                child: Text('트럭 규격 입력 페이지입니다 여기에 내요응ㄹ 적으세요'),
              ))
        ],
      ),
    );
  }
}