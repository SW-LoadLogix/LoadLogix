import 'dart:convert';

import 'package:http/http.dart' as http;
import '../models/worker_info_data.dart';
import 'base_url.dart';

class WorkerInfoService {

  /**
   * writer : 김보경
   * Rest API method : GET
   * URI : "worker/info"
   * DTO : WorkerInfoResponse
   **/

  Future<WorkerInfoData?> fetchWorkerInfo() async {
    try {
      http.Response response = await http.get(
        Uri.parse('192.168.31.245:8081/api/worker/info'));
      if (response.statusCode == 200) {
        var responseBody = json.decode(response.body);

        print(responseBody);

        return WorkerInfoData.fromJson(responseBody);
      } else {
        return null;
      }

    } catch (error) {
      throw Exception("Failed to load Worker Info");
    }
  }

}