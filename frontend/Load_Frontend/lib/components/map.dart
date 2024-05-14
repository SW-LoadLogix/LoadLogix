import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:load_frontend/services/area_service.dart';
import 'package:load_frontend/stores/user_store.dart';
import 'package:provider/provider.dart';

import '../models/building_data.dart';

List<Color> generateDistinctColors(int count) {
  List<Color> colors = [];
  for (int i = 0; i < 20; i++) {
    // Colors 클래스에 정의된 색상 중 랜덤하게 선택하여 리스트에 추가
    Color color = Colors.primaries[i % Colors.primaries.length].withOpacity(0.3);
    colors.add(color);
  }
  return colors;
}

List<Color> distinctColor = generateDistinctColors(20);
class MyGoogleMap extends StatefulWidget {
  const MyGoogleMap({Key? key}) : super(key: key);

  @override
  _MyGoogleMapState createState() => _MyGoogleMapState();
}

class _MyGoogleMapState extends State<MyGoogleMap> {
  late GoogleMapController mapController;
  LatLng _center = LatLng(36.36405586, 127.3561363);
  late LatLng newPosition;
  List<BuildingData> _buildingData = [];
  Set<Circle> _circles = {};
  Set<Marker> _markers = {};
  bool _mapControllerInitialized = false;

  @override
  void initState() {
    super.initState();
    _loadBuildingData();
  }

  Future<void> _loadBuildingData() async {
    AreaService areaService = AreaService();
    UserStore userStore = Provider.of<UserStore>(context, listen: false);
    List<BuildingData> buildingdata = await areaService.getBuildingPriority(userStore.token);
    print(buildingdata[0]);
    setState(() {
      _buildingData = buildingdata;
      _circles = _markCircles(buildingdata);
      _markers = _getMarkers(buildingdata);
      // 카메라 이동은 맵 컨트롤러가 초기화된 후에 실행합니다.
      if (_mapControllerInitialized) {
        _moveCamera(newPosition);
      }
    });
  }

  //위치 표시
  Set<Circle> _markCircles(List<BuildingData> buildings) {
    Set<Circle> circles = {};
    double new_latitude = 0;
    double new_longitude = 0;
    for (int i = 0; i < buildings.length; i++) {
      new_latitude += buildings[i].latitude;
      new_longitude += buildings[i].longitude;

      circles.add(
        Circle(
          circleId: CircleId(buildings[i].buildingId.toString()),
          center: LatLng(buildings[i].longitude, buildings[i].latitude),
          radius: 9, // 반지름 (미터)
          fillColor: distinctColor[i], // 원 내부 색상
          strokeWidth: 3, // 원 외곽선 두께
          strokeColor: Colors.black, // 원 외곽선 색상
        ),
      );
    }
    new_latitude = new_latitude / buildings.length;
    new_longitude = new_longitude / buildings.length;
    newPosition = LatLng(new_longitude, new_latitude);
    return circles;
  }

  //마커 표시
  Set<Marker> _getMarkers(List<BuildingData> buildings) {
    Set<Marker> markers = {};

    for (int i = 0; i < buildings.length; i++) {

      markers.add(
        Marker(
          markerId: MarkerId(buildings[i].buildingId.toString()),
          position: LatLng(buildings[i].longitude, buildings[i].latitude),
          infoWindow: InfoWindow(
            title: "${buildings[i].buildingName}",
            snippet: "배송 상품 개수 : ${buildings[i].totalGoods}",
          ), // InfoWi
        ),
      );
    }
    return markers;
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    _mapControllerInitialized = true;
    // 맵 컨트롤러가 초기화된 후에 카메라 이동을 시도합니다.
    if (_buildingData.isNotEmpty) {
      _moveCamera(newPosition);
    }
  }

  void _moveCamera(LatLng target) {
    mapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: target, zoom: 18.0),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.5,
      child: MaterialApp(
        home: Scaffold(
          body: GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: _center,
              zoom: 15.0,
            ),
            circles: _circles,
            markers: _markers,
          ),
        ),
      ),
    );
  }
}
