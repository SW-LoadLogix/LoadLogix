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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 40.0), // 위쪽 패딩 추가
                  child: Text(
                    'Aishahansten 님, 사용하시는 배송 차량을 선택해주세요.',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 16.0, // 폰트 크기
                      color: Colors.black, // 텍스트 색상
                      fontWeight: FontWeight.bold, // 폰트 두껍게
                      fontStyle: FontStyle.italic, // 이탤릭체
                      letterSpacing: 1.2, // 글자 사이 간격
                      wordSpacing: 2.0, // 단어 사이 간격
                      height: 1.5, // 줄간격
                      // decoration: TextDecoration.underline, // 밑줄
                      // decorationColor: Colors.blue, // 밑줄 색상
                      decorationStyle: TextDecorationStyle.solid, // 밑줄 스타일
                      fontFamily: 'Roboto', // 사용할 폰트 패밀리
                      fontFamilyFallback: ['NotoSans', 'Arial'], // 대체 폰트 패밀리
                      shadows: [
                        Shadow(
                          color: Colors.blueGrey,
                          offset: Offset(2, 2),
                          blurRadius: 9,
                        ),
                      ], // 그림자 효과
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.0), // 위쪽 패딩 추가
                  child: Text(
                    '표준 규격 정보는 제공되며, 수정 가능합니다.',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 14.0, // 폰트 크기
                      color: Colors.black, // 텍스트 색상
                      fontWeight: FontWeight.bold, // 폰트 두껍게
                      fontStyle: FontStyle.italic, // 이탤릭체
                      letterSpacing: 1.2, // 글자 사이 간격
                      wordSpacing: 2.0, // 단어 사이 간격
                      height: 1.5, // 줄간격
                      // decoration: TextDecoration.underline, // 밑줄
                      // decorationColor: Colors.blue, // 밑줄 색상
                      decorationStyle: TextDecorationStyle.solid, // 밑줄 스타일
                      fontFamily: 'Roboto', // 사용할 폰트 패밀리
                      fontFamilyFallback: ['NotoSans', 'Arial'], // 대체 폰트 패밀리
                      shadows: [
                        Shadow(
                          color: Colors.blueGrey,
                          offset: Offset(2, 2),
                          blurRadius: 9,
                        ),
                      ], // 그림자 효과
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.0), // 위쪽 패딩 추가
                  child: Text(
                    '차량 규격 정보를 바탕으로 LOAD에서 상품 적재 최적화를 진행하겠습니다.',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 16.0, // 폰트 크기
                      color: Colors.black, // 텍스트 색상
                      fontWeight: FontWeight.bold, // 폰트 두껍게
                      fontStyle: FontStyle.italic, // 이탤릭체
                      letterSpacing: 1.2, // 글자 사이 간격
                      wordSpacing: 2.0, // 단어 사이 간격
                      height: 1.5, // 줄간격
                      // decoration: TextDecoration.underline, // 밑줄
                      // decorationColor: Colors.blue, // 밑줄 색상
                      decorationStyle: TextDecorationStyle.solid, // 밑줄 스타일
                      fontFamily: 'Roboto', // 사용할 폰트 패밀리
                      fontFamilyFallback: ['NotoSans', 'Arial'], // 대체 폰트 패밀리
                      shadows: [
                        Shadow(
                          color: Colors.lightBlueAccent,
                          offset: Offset(2, 2),
                          blurRadius: 9,
                        ),
                      ], // 그림자 효과
                    ),
                  ),
                ),
              ],
            ),)
        ],
      ),
    );
  }
}