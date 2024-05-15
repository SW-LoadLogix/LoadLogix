import 'package:flutter/material.dart';
import 'package:load_frontend/services/worker_service.dart';
import 'package:load_frontend/stores/user_store.dart';
import 'package:load_frontend/stores/worker_store.dart';
import 'package:provider/provider.dart';

import '../constaints.dart';
import '../models/worker_info_data.dart';

class DeliveryStatus1 extends StatelessWidget {
  final bool isHover;

  const DeliveryStatus1({
    Key? key,
    required this.isHover,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        minHeight: 150.0, // 최소 높이 설정
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "최신 적재일",
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: isHover ? Colors.white : primary),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            "2024년 05월 07일",
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: isHover ? Colors.white : primary),
          ),
          SizedBox(
            height: 30,
          ),
          GestureDetector(
            onTap: () async {
              print("배송대기 버튼 클릭");
              String accessToken = Provider.of<UserStore>(context, listen: false).token;

              WorkerInfoData? workerInfoData = await WorkerService().fetchWorkerInfo(accessToken);
              if (workerInfoData?.carWidth == 0  || workerInfoData?.carHeight == 0 ||  workerInfoData?.carLength == 0 ){
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text("차량 정보를 입력해주세요"),
                      content: Text("차량 정보를 입력해야 배송을 시작할 수 있습니다."),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text("확인"),
                        ),
                      ],
                    );
                  },
                );
                return;
              }

              bool isWorkerReady = await WorkerService().isWorkerReadyApi(accessToken);
              if (isWorkerReady == false){
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text("배송 준비중"),
                      content: Text("배송 준비중입니다. 잠시만 기다려주세요."),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text("확인"),
                        ),
                      ],
                    );
                  },
                );
                return;
              }
              Provider.of<WorkerStore>(context, listen: false).setWorkerIsReady(isWorkerReady);
              // 버튼 클릭 시 동작할 내용 작성
            },
            child: Container(
              width: double.infinity, // 전체 너비
              height: 56,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), // 버튼의 모서리를 둥글게 만듦
                color: isHover ? Colors.white : primary,
                boxShadow: [
                  BoxShadow(
                    color: Color.fromRGBO(137, 181, 162, 0.56),
                    blurRadius: 16,
                    spreadRadius: 0,
                    offset: Offset(0, -2),
                  ),
                ],
              ),
              child: Text(
                "배송대기",
                style: TextStyle(
                  color: isHover ? primary : Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
