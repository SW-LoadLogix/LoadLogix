import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';


@RoutePage()
class SetTruckSpecificationPage extends StatefulWidget {
  @override
  _SetTruckSpecificationPageState createState() => _SetTruckSpecificationPageState();
}

class _SetTruckSpecificationPageState extends State<SetTruckSpecificationPage> {
  TextEditingController _controller1 = TextEditingController();
  TextEditingController _controller2 = TextEditingController();
  TextEditingController _controller3 = TextEditingController();
  bool _isValid1 = false;
  bool _isValid2 = false;
  bool _isValid3 = false;

  @override
  Widget build(BuildContext context) {

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
        appBar: AppBar(
          title: Text('트럭 규격',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Color(0xFF90D7FF),
        ),
        body: Row(
          children: [
            //MyNav(),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 40.0),
                child:
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10.0),
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
                                mainAxisAlignment: MainAxisAlignment.start,
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
                                                  height: 180,
                                                  width: 300,
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
                                                  height: 180,
                                                  width: 300,
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
                                                  height: 180,
                                                  width: 300,
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
                            SizedBox(height: 80),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 300,
                                  height: 100,
                                  child: TextField(
                                    controller: _controller1,
                                    onChanged: (value) {
                                      setState(() {
                                        _isValid1= value.isNotEmpty;
                                      });
                                    },

                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      hintText: '가로 길이를 입력하세요',
                                      labelText: '차량 내부 가로길이', // 레이블 텍스트
                                      labelStyle: TextStyle( // 레이블 텍스트 스타일 지정
                                        fontSize: 16,
                                        color: Colors.blueGrey,
                                      ),
                                      prefixIcon: Icon(Icons.width_full_sharp), // 입력 필드 앞에 아이콘 추가
                                      suffixIcon: Icon(
                                        _isValid1 ? Icons.check_circle : Icons.error,
                                        color: _isValid1 ? Colors.green : Colors.red,
                                      ),
                                      helperText: '예: 1,700m', // 보조 텍스트
                                      helperStyle: TextStyle( // 보조 텍스트 스타일 지정
                                        fontSize: 16,
                                        color: Colors.grey,
                                      ),
                                      errorText: _isValid1 ? null : '올바른 형식으로 입력하세요', // 오류 메시지 텍스트
                                      errorStyle: TextStyle( // 오류 메시지 텍스트 스타일 지정
                                        fontSize: _isValid1 ? 12 : 12,
                                        color: _isValid1 ? Color(0xFF3AB9FF) : Colors.red,
                                      ),
                                      errorBorder: OutlineInputBorder( // 오류 발생 시 테두리 스타일 지정
                                        borderSide: _isValid1 ? BorderSide(color: Color(0xFF3AB9FF)) : BorderSide(color: Colors.red),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 40),
                                SizedBox(
                                  width: 300,
                                  height: 100,
                                  child: TextField(
                                    controller: _controller2,
                                    onChanged: (value) {
                                      setState(() {
                                        _isValid2 = value.isNotEmpty; // 입력 값이 비어있지 않은지 확인하여 _isValid 값을 업데이트합니다.
                                      });
                                    },

                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      hintText: '세로 길이를 입력하세요',
                                      labelText: '차량 내부 세로길이',
                                      labelStyle: TextStyle(
                                        fontSize: 16,
                                        color: Colors.blueGrey,
                                      ),
                                      prefixIcon: Icon(Icons.height),
                                      suffixIcon: Icon(
                                        _isValid2 ? Icons.check_circle : Icons.error,
                                        color: _isValid2 ? Colors.green : Colors.red,
                                      ),
                                      helperText: '예: 3,700m',
                                      helperStyle: TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey,
                                      ),
                                      errorText: _isValid2 ? null : '올바른 형식으로 입력하세요',
                                      errorStyle: TextStyle(
                                        fontSize: _isValid2 ? 12 : 12,
                                        color: _isValid2 ? Color(0xFF3AB9FF) : Colors.red,
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: _isValid2 ? BorderSide(color: Color(0xFF3AB9FF)) : BorderSide(color: Colors.red),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 40),
                                SizedBox(
                                  width: 300,
                                  height: 100,
                                  child: TextField(
                                    controller: _controller3,
                                    onChanged: (value) {
                                      setState(() {
                                        _isValid3 = value.isNotEmpty; // 입력 값이 비어있지 않은지 확인하여 _isValid 값을 업데이트합니다.
                                      });
                                    },

                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(), // 테두리 스타일 지정
                                      hintText: '차량 높이를 입력하세요', // 힌트 텍스트
                                      labelText: '차량 높이', // 레이블 텍스트
                                      labelStyle: TextStyle( // 레이블 텍스트 스타일 지정
                                        fontSize: 16,
                                        color: Colors.blueGrey,
                                      ),
                                      prefixIcon: Icon(Icons.directions_car), // 입력 필드 앞에 아이콘 추가
                                      suffixIcon: Icon(
                                        _isValid3 ? Icons.check_circle : Icons.error,
                                        color: _isValid3 ? Colors.green : Colors.red,
                                      ),
                                      helperText: '예: 2,100m', // 보조 텍스트
                                      helperStyle: TextStyle( // 보조 텍스트 스타일 지정
                                        fontSize: 16,
                                        color: Colors.grey,
                                      ),
                                      errorText: _isValid3 ? null : '올바른 형식으로 입력하세요', // 오류 메시지 텍스트
                                      errorStyle: TextStyle( // 오류 메시지 텍스트 스타일 지정
                                        fontSize: _isValid3 ? 12 : 12,
                                        color: _isValid3 ? Color(0xFF3AB9FF) : Colors.red,
                                      ),
                                      errorBorder: OutlineInputBorder( // 오류 발생 시 테두리 스타일 지정
                                        borderSide: _isValid3 ? BorderSide(color: Color(0xFF3AB9FF)) : BorderSide(color: Colors.red),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 40),
                                Container(
                                  margin: EdgeInsets.only(bottom: 43),
                                  child: ElevatedButton(
                                    onPressed: () {print('ElevatedButton이 클릭되었습니다!');},
                                    style: ElevatedButton.styleFrom(
                                      padding: EdgeInsets.all(25),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      elevation: 2,
                                      backgroundColor: Color(0xFF6ECBFF),
                                    ),
                                    child: Text('규격 수정하기',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(height: 20),
                            Column( // 수정된 부분
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    SizedBox(width: 890),
                                    Container(
                                      margin: EdgeInsets.only(bottom: 40),
                                      child: ElevatedButton(
                                        onPressed: () {
                                          print('ElevatedButton이 클릭되었습니다!');
                                        },
                                        style: ElevatedButton.styleFrom(
                                          padding: EdgeInsets.all(30),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(5),
                                          ),
                                          elevation: 2,
                                          backgroundColor: Color(0xFFB9CEFF),
                                        ),
                                        child: Text(
                                          '전체 시뮬레이션 확인하기',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ]
                      )
                    ]
                )
              )
            )
          ],
        )
    );
  }
}