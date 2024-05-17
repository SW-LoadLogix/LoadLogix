import 'package:flutter/cupertino.dart';
import 'package:load_frontend/services/delivery_service.dart';

import '../models/delivery_data.dart';

class DeliveryStore extends ChangeNotifier {
  DeliveryService deliveryService = DeliveryService();

  DeliveryData deliveryData = DeliveryData(
    areaName : 'test store',
    total : 0,
    buildings: [],
  );

  Future<void> getDeliveryServiceFromApi(String tokken) async{
    var DeliveryData = await deliveryService.fetchDeliveryGoods(tokken);
    if (DeliveryData != null){
      deliveryData = DeliveryData;
      notifyListeners();
    }
}}