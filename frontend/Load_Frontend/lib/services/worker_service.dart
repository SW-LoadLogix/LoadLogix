import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:load_frontend/services/user_service.dart';
import 'package:provider/provider.dart';
import '../models/worker_info_data.dart';
import 'base_url.dart';

class WorkerService {

  /**
   * Rest API method : GET
   * URI : "worker/info"
   * DTO : WorkerInfoResponse
   **/

  Future<WorkerInfoData?> fetchWorkerInfo(String accessToken) async {
    try {
      final response = await http.get(
        Uri.parse('http://125.138.70.52:8081/api/worker/info'), headers: {
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

  Future <bool> isWorkerReadyApi(String accessToken) async {
    try {
      final response = await http.get(
          Uri.parse('http://43.201.116.59:8081/api/worker/info'), headers: {
        "Authorization": "Bearer $accessToken"
      });

      var responseBody = json.decode(response.body);
      print(responseBody);
      if (response.statusCode == 200) {
        if (responseBody['result'] == true)
          return true;
        else
          return false;
      }
      else {
        return false;
      }
    }
    catch (error) {
      throw Exception("Failed to load Worker Ready");
    }
  }
}