import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:load_frontend/services/user_service.dart';
import 'package:provider/provider.dart';
import '../models/worker_info_data.dart';
import 'base_url.dart';

class WorkerInfoService {

  /**
   * Rest API method : GET
   * URI : "worker/info"
   * DTO : WorkerInfoResponse
   **/

  Future<WorkerInfoData?> fetchWorkerInfo(String accessToken) async {

    try {
      final response = await http.get(
        Uri.parse('http://192.168.31.245:8081/api/worker/info'), headers: {
          "Authorization": "Bearer $accessToken"
        });


      var responseBody = json.decode(response.body);

      // print("respobd: ");
      // print(responseBody);
      //
      // print("respobd2: ");
      // print(response.statusCode);
      // print(responseBody['result']);
      if (response.statusCode == 200) {
        return WorkerInfoData.fromJson(responseBody['result']);
      } else {
        return null;
      }

    } catch (error) {
      throw Exception("Failed to load Worker Info");
    }
  }

}