
import 'package:flutter/cupertino.dart';
import 'package:load_frontend/services/worker_info_functions.dart';

import '../models/worker_info_data.dart';

// List<WorkerInfoData> wInfo = [];

class WorkerStore extends ChangeNotifier {
  WorkerInfoService workerInfoService = WorkerInfoService();

  late WorkerInfoData workerInfo;

  // 페이지 진입 시 API 호출하기 위한 함수
  Future<void> getWorkerInfoFromApi() async{
    workerInfo = (await workerInfoService.fetchWorkerInfo())!;
    print(workerInfo);
    notifyListeners();

  }

}