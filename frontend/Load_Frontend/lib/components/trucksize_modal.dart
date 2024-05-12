import 'package:flutter/material.dart';
import 'package:load_frontend/services/worker_info_functions.dart';
import 'package:load_frontend/stores/worker_store.dart';
import 'package:provider/provider.dart';

import '../constaints.dart';
import '../models/worker_info_data.dart';
import '../stores/user_store.dart';

class TruckSizeModal extends StatelessWidget {
  final TextEditingController widthController = TextEditingController();
  final TextEditingController lengthController = TextEditingController();
  final TextEditingController heightController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent, // 투명한 배경
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Container(
        width: 200,
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              blurRadius: 5,
              spreadRadius: 1,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "화물차량 규격",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: primary,
              ),
            ),
            SizedBox(height: 16.0),
            _buildInputField("가로", widthController),
            SizedBox(height: 8),
            _buildInputField("세로", lengthController),
            SizedBox(height: 8),
            _buildInputField("높이", heightController),
            SizedBox(height: 16),
            GestureDetector(
              onTap: () async {
                UserStore userStore = await Provider.of<UserStore>(context, listen: false);
                String? result = await WorkerInfoService().changeCarInfo(userStore.token,
                    int.parse(widthController.text),
                    int.parse(lengthController.text),
                    int.parse(heightController.text));
                if (result == "success"){
                  WorkerStore workerStore = Provider.of<WorkerStore>(context, listen: false);
                  WorkerInfoData? workerInfoDataNew = await WorkerInfoService().fetchWorkerInfo(userStore.token);
                  workerStore.setWorkerInfo(workerInfoDataNew!);
                }
                else{
                  print ("실패요 ㅠㅠ");
                }
                print(
                    '가로: ${widthController.text}, 세로: ${lengthController.text}, 높이: ${heightController.text}');


                Navigator.pop(context);
              },
              child: Container(
                width: 64,
                height: 32,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: primary,
                  borderRadius: BorderRadius.circular(8.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      blurRadius: 5,
                      spreadRadius: 1,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Text(
                  "저장",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField(String label, TextEditingController controller) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: primary,
          ),
        ),
        SizedBox(width: 8),
        Container(
          width: 150,
          height: 24,
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              filled: true,
              fillColor: Colors.grey[200],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
