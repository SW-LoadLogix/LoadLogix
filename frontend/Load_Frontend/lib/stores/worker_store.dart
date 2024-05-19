
import 'package:flutter/cupertino.dart';
import 'package:load_frontend/services/worker_service.dart';

import '../models/worker_info_data.dart';
import '../views/box_simulation/box_simulation_gobal_setting.dart';

// List<WorkerInfoData> wInfo = [];

class WorkerStore extends ChangeNotifier {
  WorkerService workerInfoService = WorkerService();
  int gtruckWidth = 100;
  int gtruckLength = 100;
  int gtruckHeight = 100;

  WorkerInfoData workerInfo = WorkerInfoData(
  name : "a",
  areaName : 'bbbbbbbbb',
  conveyNo : 333,
  carHeight: 400,
  carLength: 500,
  carWidth: 600,
  );
  bool isWorkerReady = false;


  // 페이지 진입 시 API 호출하기 위한 함수
  Future<void> getWorkerInfoFromApi(String accessToken) async{
    workerInfo = (await workerInfoService.fetchWorkerInfo(accessToken))!;
    gtruckHeight = workerInfo.carHeight;
    gtruckLength = workerInfo.carLength;
    gtruckWidth = workerInfo.carWidth;
    print ("gtuckHeight: $gtruckHeight, gtruckLength: $gtruckLength, gtruckWidth: $gtruckWidth");
    print(workerInfo);
    notifyListeners();
  }
  Future<void> setWorkerInfo(WorkerInfoData newWorkerInfo) async {
    workerInfo = newWorkerInfo;
    notifyListeners();
  }
  Future<void> setWorkerIsReady(bool ready) async{
    isWorkerReady = ready;
    notifyListeners();
  }
}