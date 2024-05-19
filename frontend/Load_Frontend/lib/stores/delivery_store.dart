import 'package:flutter/cupertino.dart';
import 'package:load_frontend/services/area_service.dart';
import 'package:load_frontend/services/delivery_service.dart';

import '../models/building_data.dart';
import '../models/delivery_data.dart';

class DeliveryStore extends ChangeNotifier {
  DeliveryService deliveryService = DeliveryService();

  DeliveryData deliveryData = DeliveryData(
    areaName : 'test store',
    total : 0,
    buildings: [],
  );
  List<BuildingData> buildingPriority = [];

  Future<void> getDeliveryServiceFromApi(String tokken) async {
    var DeliveryData = await deliveryService.fetchDeliveryGoods(tokken);
    if (DeliveryData != null) {
      deliveryData = DeliveryData;
      notifyListeners();
    }
  }

  Future<void> getBuildingPriorityFromApi(String token) async{
    var buildingPriorityTemp = await AreaService().getBuildingPriority(token);
    if (buildingPriorityTemp != null ){
      buildingPriority = buildingPriorityTemp;
      notifyListeners();
    }
  }
}
