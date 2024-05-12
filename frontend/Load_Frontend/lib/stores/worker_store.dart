
import 'package:flutter/cupertino.dart';
import 'package:load_frontend/services/worker_info_functions.dart';

import '../models/worker_info_data.dart';

// List<WorkerInfoData> wInfo = [];

class WorkerStore extends ChangeNotifier {
  WorkerInfoService workerInfoService = WorkerInfoService();

  WorkerInfoData workerInfo = WorkerInfoData(
  name : "a",
  areaName : 'b',
  conveyNo : 3,
  carHeight: 4,
  carLength: 5,
  carWidth:6,
  );


  // 페이지 진입 시 API 호출하기 위한 함수
  Future<void> getWorkerInfoFromApi(String accessToken) async{
    workerInfo = (await workerInfoService.fetchWorkerInfo(accessToken))!;
    print(workerInfo);
    notifyListeners();
  }
  Future<void> setWorkerInfo(WorkerInfoData newWorkerInfo) async {
    workerInfo = newWorkerInfo;
    notifyListeners();
  }
}