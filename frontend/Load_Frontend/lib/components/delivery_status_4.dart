import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:load_frontend/stores/worker_store.dart';
import 'package:provider/provider.dart';

import '../constaints.dart';
import '../models/worker_info_data.dart';
import 'trucksize_modal.dart';
import 'package:http/http.dart';

class DeliveryStatus4 extends StatelessWidget {
  final bool isHover;
  final Key key;

  const DeliveryStatus4({
    required this.key,
    required this.isHover,
  });

  void _showTruckSizeModal(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.3),
      builder: (context) => TruckSizeModal(),
    );
  }

  @override
  Widget build(BuildContext context) {
    WorkerInfoData workerInfo =
        Provider.of<WorkerStore>(context, listen: true).workerInfo;
    return Container(
        constraints: BoxConstraints(
          minHeight: 170.0, // 최소 높이 설정
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flex(
              direction: Axis.horizontal,
              children: [
                Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "담당자 Info",
                          style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w400,
                              color: isHover ? Colors.white : primary),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "담당 구역",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: isHover ? Colors.white : primary,
                          ),
                        ),
                        Text(
                          "컨베이어벨트",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: isHover ? Colors.white : primary,
                          ),
                        ),
                        Text(
                          "화물차량(cm)",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: isHover ? Colors.white : primary,
                          ),
                        ),
                      ],
                    )),
                Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "      ",
                          style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w400,
                              color: isHover ? Colors.white : primary),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          //"봉명 1동",
                          workerInfo.areaName,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: isHover ? Colors.white : primary,
                          ),
                        ),
                        Text(
                          workerInfo.conveyNo.toString(),
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: isHover ? Colors.white : primary,
                          ),
                        ),
                        Text(
                          "${workerInfo.carWidth} X ${workerInfo.carLength} X ${workerInfo.carHeight}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: isHover ? Colors.white : primary,
                          ),
                        ),
                      ],
                    )),
              ],
            ),
            GestureDetector(
              onTap: () => _showTruckSizeModal(context),
              child: Container(
                width: double.infinity,
                // 전체 너비
                height: 55,
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
                  "화물차량 규격 확인",
                  style: TextStyle(
                    color: isHover ? primary : Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}

// API 받아오는 코드
