import 'package:flutter/material.dart';

import '../components/nav_rail.dart';

class SetTruckSpecificationPage extends StatelessWidget {
  const SetTruckSpecificationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final EdgeInsets padding = const EdgeInsets.only(top: 10.0);

    final TextStyle textStyle = TextStyle(
      fontSize: 16.0,
      color: Colors.black,
      letterSpacing: 1.2,
      wordSpacing: 2.0,
      height: 1.5,
      decorationStyle: TextDecorationStyle.solid,
      fontFamily: 'Roboto',
      fontFamilyFallback: ['NotoSans', 'Arial'],
    );

    final TextStyle textStyle2 = TextStyle(
      fontSize: 18.0,
      color: Colors.black,
      letterSpacing: 1.2,
      wordSpacing: 2.0,
      fontWeight: FontWeight.bold, // 폰트 두껍게
      fontStyle: FontStyle.italic, // 이탤릭체
      height: 1.5,
      decorationStyle: TextDecorationStyle.solid,
      fontFamily: 'Roboto',
      fontFamilyFallback: ['NotoSans', 'Arial'],
      shadows: [
        Shadow(
          color: Colors.blue,
          offset: Offset(2, 2),
          blurRadius: 9,
        ),
      ],
    );

    return Scaffold(
      body: Row(
        children: [
          Flexible(
            child: MyNav(),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 40.0), // 위쪽 패딩 추가
                  child: Text(
                    'Aishahansten 님, 사용하시는 배송 차량을 선택해주세요.',
                    textAlign: TextAlign.left,
                    style: textStyle,
                    ),
                  ),
                Padding(
                  padding: EdgeInsets.only(top: 3.0),
                  child: Text(
                    '(표준 규격 정보는 제공되며, 수정 가능합니다.)',
                    textAlign: TextAlign.left,
                    style: textStyle,
                    ),
                  ),
                Padding(
                  padding: EdgeInsets.only(top: 3.0),
                  child: Text(
                    '차량 규격 정보를 바탕으로 LOAD에서 상품 적재 최적화를 진행하겠습니다.',
                    textAlign: TextAlign.left,
                    style: textStyle,
                    ),
                  ),
                SizedBox(height: 40.0),
                ]
            ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Material(
                    color: Color(0xFFCEEDFF),
                      elevation: 13,
                      borderRadius: BorderRadius.circular(34),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: InkWell(
                        splashColor: Colors.black26,
                        onTap: () {},
                        child: Column(
                        // mainAxisSize: MainAxisSize.min,
                        children: [
                          Ink.image(
                            image: AssetImage('assets/images/truck1.png'),
                            height: 220,
                            width: 350,
                            fit: BoxFit.cover
                          ),
                          SizedBox(height: 6),
                          Text(
                            '1.4톤 탑차',
                            style: textStyle2,
                          ),

                          SizedBox(height: 6),
                        ],
                        )
                      )
                    ),
                    SizedBox(width: 40),
                    Material(
                      color: Color(0xFFCEEDFF),
                      elevation: 13,
                      borderRadius: BorderRadius.circular(35),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: InkWell(
                        splashColor: Colors.black26,
                        onTap: () {},
                        child: Column(
                          // mainAxisSize: MainAxisSize.min,
                          children: [
                            Ink.image(
                            image: AssetImage('assets/images/truck2.png'),
                            height: 220,
                            width: 350,
                            fit: BoxFit.cover
                            ),
                            SizedBox(height: 6),
                            Text(
                              '2.5톤 탑차',
                              style: textStyle2,
                            ),
                            SizedBox(height: 6),
                          ],
                        )
                      )
                    ),
                    SizedBox(width: 40),
                    Material(
                      color: Color(0xFFCEEDFF),
                      elevation: 13,
                      borderRadius: BorderRadius.circular(32),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: InkWell(
                        splashColor: Colors.black26,
                        onTap: () {},
                        child: Column(
                          // mainAxisSize: MainAxisSize.min,
                          children: [
                            Ink.image(
                              image: AssetImage('assets/images/truck3.png'),
                              height: 220,
                              width: 350,
                              fit: BoxFit.cover
                            ),
                            SizedBox(height: 6),
                            Text(
                              '3.5톤 탑차',
                              style: textStyle2,
                            ),
                            SizedBox(height: 6),
                          ],
                        )
                      )
                    ),
                  ]
                ),
                SizedBox(height: 100),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                  SizedBox(
                    width: 300,
                    height: 100,// 입력 필드의 너비 지정
                    child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: '차량 내부 가로 길이를 입력하세요', // 예시로 표시할 힌트 텍스트
                      ),
                    ),
                  ),
                  SizedBox(width: 40),
                  SizedBox(
                    width: 300,
                    height: 100,// 입력 필드의 너비 지정
                    child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: '차량 내부 세로 길이를 입력하세요', // 예시로 표시할 힌트 텍스트
                      ),
                    ),
                  ),
                  SizedBox(width: 40),
                  SizedBox(
                    width: 300,
                    height: 100,// 입력 필드의 너비 지정
                      child: TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: '차량 높이를 입력하세요', // 예시로 표시할 힌트 텍스트
                      ),
                    ),
                  ),

                ],
              )



              ]
              )
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //   children: [
              //     Column(
              //       children: [
              //         Material(
              //           color: Color(0xFFCEEDFF),
              //           elevation: 13,
              //           borderRadius: BorderRadius.circular(34),
              //           clipBehavior: Clip.antiAliasWithSaveLayer,
              //           child: InkWell(
              //             splashColor: Colors.black26,
              //             onTap: () {},
              //             child: Column(
              //               // mainAxisSize: MainAxisSize.min,
              //               children: [
              //                 Ink.image(
              //                     image: AssetImage('assets/images/truck1.png'),
              //                     height: 220,
              //                     width: 350,
              //                     fit: BoxFit.cover
              //                 ),
              //                 SizedBox(height: 6),
              //                 Text(
              //                   '1.4톤 탑차',
              //                   style: textStyle2,
              //                 ),
              //
              //                 SizedBox(height: 6),
              //               ],
              //             )
              //           )
              //         ),
              //         SizedBox(height: 20),
              //         SizedBox(
              //           width: 300,
              //           height: 100,// 입력 필드의 너비 지정
              //           child: TextField(
              //             decoration: InputDecoration(
              //             border: OutlineInputBorder(),
              //             hintText: '차량 내부 가로 길이를 입력하세요', // 예시로 표시할 힌트 텍스트
              //             ),
              //           ),
              //         ),
              //       ],
              //     ),
              //     SizedBox(width: 40),
              //
              //     Column(
              //       children: [
              //         Material(
              //           color: Color(0xFFCEEDFF),
              //           elevation: 13,
              //           borderRadius: BorderRadius.circular(35),
              //           clipBehavior: Clip.antiAliasWithSaveLayer,
              //           child: InkWell(
              //               splashColor: Colors.black26,
              //               onTap: () {},
              //               child: Column(
              //                 // mainAxisSize: MainAxisSize.min,
              //                 children: [
              //                   Ink.image(
              //                       image: AssetImage('assets/images/truck2.png'),
              //                       height: 220,
              //                       width: 350,
              //                       fit: BoxFit.cover
              //                   ),
              //                   SizedBox(height: 6),
              //                   Text(
              //                     '2.5톤 탑차',
              //                     style: textStyle2,
              //                   ),
              //                   SizedBox(height: 6),
              //                 ],
              //               )
              //           )
              //       ),
              //         SizedBox(height: 20),
              //         SizedBox(
              //           width: 300,
              //           height: 100,// 입력 필드의 너비 지정
              //           child: TextField(
              //             decoration: InputDecoration(
              //               border: OutlineInputBorder(),
              //               hintText: '차량 내부 세로 길이를 입력하세요', // 예시로 표시할 힌트 텍스트
              //             ),
              //           ),
              //         ),
              //       ],
              //     ),
              //     SizedBox(width: 40),
              //     Column(
              //       children: [
              //         Material(
              //             color: Color(0xFFCEEDFF),
              //             elevation: 13,
              //             borderRadius: BorderRadius.circular(32),
              //             clipBehavior: Clip.antiAliasWithSaveLayer,
              //             child: InkWell(
              //                 splashColor: Colors.black26,
              //                 onTap: () {},
              //                 child: Column(
              //                   // mainAxisSize: MainAxisSize.min,
              //                   children: [
              //                     Ink.image(
              //                         image: AssetImage('assets/images/truck3.png'),
              //                         height: 220,
              //                         width: 350,
              //                         fit: BoxFit.cover
              //                     ),
              //                     SizedBox(height: 6),
              //                     Text(
              //                       '3.5톤 탑차',
              //                       style: textStyle2,
              //                     ),
              //                     SizedBox(height: 6),
              //                   ],
              //                 )
              //             )
              //         ),
              //         SizedBox(height: 20),
              //         SizedBox(
              //           width: 300,
              //           height: 100,// 입력 필드의 너비 지정
              //           child: TextField(
              //             decoration: InputDecoration(
              //               border: OutlineInputBorder(),
              //               hintText: '차량 높이를 입력하세요', // 예시로 표시할 힌트 텍스트
              //             ),
              //           ),
              //         ),
              //       ],
              //     ),
              //   ],
              // )
            // ),
          ]
          )
        ],
      )
    );
  }
}

