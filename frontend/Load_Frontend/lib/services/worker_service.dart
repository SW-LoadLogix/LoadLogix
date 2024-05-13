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
        Uri.parse('http://43.201.116.59:8081/api/worker/info'), headers: {
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

  Future<String> changeCarInfo(String accessToken, int carWidth, int carLength, int carHeight) async {
    try {
      var url = Uri.parse('http://43.201.116.59:8081/api/car/change');
      var data = {
        'car_width': carWidth,
        'car_length': carLength,
        'car_height': carHeight,
      };
      var response = await http.put(url, body: json.encode(data), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $accessToken', //Bearer
      });

      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 200) {
        var responseData = json.decode(response.body);
        if (responseData['result']['width'] == carWidth){
          print("트럭 정보 변경 성공");
          return "success";
        }
        else{
          print("트럭 정보 변경 실패");
          return "fail";
        }
        print(responseData.toString());
        // LoginResponseWrapperData loginResponseWrapperData = LoginResponseWrapperData.fromJson(responseData);
        // print(loginResponseWrapperData.toString());


      } else {
        print('Failed to create a post');
      }
    } catch (e) {
      print('Caught error: $e');
    }return "fail";
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