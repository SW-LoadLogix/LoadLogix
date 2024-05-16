import 'package:flutter/material.dart';
import 'package:load_frontend/stores/worker_store.dart';
import 'package:msh_checkbox/msh_checkbox.dart';
import 'package:provider/provider.dart';

import '../constaints.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class DeliveryStatus2 extends StatefulWidget {
  final bool isHover;

  const DeliveryStatus2({
    Key? key,
    required this.isHover,
  }) : super(key: key);

  @override
  _Container2State createState() => _Container2State();
}

class _Container2State extends State<DeliveryStatus2> {
  String message = "적재 알고리즘을 위한 배송 상품이 준비중입니다";
  bool isLoading = true; // API 호출되었을 때 여부를 관리하는 변수 추가

  bool isChecked = true; // 체크박스 형태로 고정
  bool isCalled = false;

  @override
  Widget build(BuildContext context) {
    WorkerStore ws = Provider.of<WorkerStore>(context, listen: true);
    if (ws.isWorkerReady) {
      if (isCalled == false) {
        isCalled = true;
        fetchDataFromAPI();
      }
    } else {
      message = "준비 중";
    }
    return Container(
      constraints: BoxConstraints(
        minHeight: 170.0, // 최소 높이 설정
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              width: double.infinity,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "적재 Status",
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w400,
                          color: widget.isHover
                              ? Colors.white
                              : primary), // StatefulWidget 클래스의 속성에 접근할 때는 "widget" 객체를 사용해야 됨.
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      message,
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: widget.isHover ? Colors.white : primary),
                      textAlign: TextAlign.center,
                    ),

                  ])),
    Container(
    width:  double.infinity,
    child:  Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
          Center(
            child: isLoading
                ? LoadingAnimationWidget.inkDrop(
                    color: widget.isHover ? Colors.white : primary,
                    size: 50,
                  )
                : MSHCheckbox(
                    size: 60,
                    value: isChecked,
                    colorConfig: MSHColorConfig.fromCheckedUncheckedDisabled(
                      checkedColor: widget.isHover ? Colors.white : primary,
                    ),
                    style: MSHCheckboxStyle.stroke,
                    onChanged: (selected) {
                      setState(() {
                        isChecked = selected;
                      });
                    },
                  ),
          ),
      SizedBox(
        height: 5,
      )
    ])),
        ],
      ),
    );
  }

  // API 호출해서 상태 업데이트하는 함수
  void fetchDataFromAPI() {
    // Here you would implement your API call logic
    // For demonstration purposes, let's assume we fetched the data successfully
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        isLoading = false;
        message = "적재 알고리즘이 준비되었습니다"; // API 호출 후 메시지 업데이트
      });
    });
  }

  @override
  void initState() {
    super.initState();
    // Call API to fetch initial data when widget is initialized
  }
}
