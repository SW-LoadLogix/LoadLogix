import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:load_frontend/services/area_service.dart';
import 'package:load_frontend/stores/user_store.dart';
import 'package:provider/provider.dart';
import 'package:custom_map_markers/custom_map_markers.dart';
import '../models/building_data.dart';

List<Color> generateDistinctColors(int count) {
  List<Color> colors = [];
  for (int i = 0; i < count; i++) {
    Color color = Colors.primaries[i % Colors.primaries.length].withOpacity(0.3);
    colors.add(color);
  }
  return colors;
}

class MyGoogleMap extends StatefulWidget {
  const MyGoogleMap({Key? key}) : super(key: key);

  @override
  _MyGoogleMapState createState() => _MyGoogleMapState();
}

class _MyGoogleMapState extends State<MyGoogleMap> {
  late GoogleMapController mapController;
  LatLng _center = LatLng(36.36405586, 127.3561363);
  LatLng newPosition = LatLng(36.36405586, 127.3561363);
  List<BuildingData> _buildingData = [];
  Set<Circle> _circles = {}; 
  List<MarkerData> _customMarkers = [];
  bool _mapControllerInitialized = false;
  List<Color> distinctColor = [];// distinctColor를 동적으로 생성하기 위해 리스트 초기화

  @override
  void initState() {
    super.initState();
    _loadBuildingData();
  }

  Future<void> _loadBuildingData() async {
    AreaService areaService = AreaService();
    UserStore userStore = Provider.of<UserStore>(context, listen: false);
    List<BuildingData> buildingdata = await areaService.getBuildingPriority(userStore.token);
    setState(() {
      _buildingData = buildingdata;
      distinctColor = generateDistinctColors(buildingdata.length); // 건물 데이터의 길이에 맞게 색상 생성
      _circles = _markCircles(buildingdata);
      _customMarkers = _getCustomMarkers(buildingdata);
      if (_mapControllerInitialized) {
        _moveCamera(newPosition);
      }
    });
  }

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
          center: LatLng(buildings[i].latitude,buildings[i].longitude),
          radius: 9,
          fillColor: distinctColor[i],
          strokeWidth: 3,
          strokeColor: Colors.transparent,
        ),
      );
    }
    if (buildings.isNotEmpty) {
      new_latitude = new_latitude / buildings.length;
      new_longitude = new_longitude / buildings.length;
      newPosition = LatLng(new_latitude,new_longitude);
    }
    return circles;
  }

  List<MarkerData> _getCustomMarkers(List<BuildingData> buildings) {
    List<MarkerData> markers = [];
    for (int i = 0; i < buildings.length; i++) {
      markers.add(
        MarkerData(
          marker: Marker(
            markerId: MarkerId(buildings[i].buildingId.toString()),
            position: LatLng(buildings[i].latitude,buildings[i].longitude),
            infoWindow: InfoWindow(
              title: "배송 상품 개수 : ${buildings[i].totalGoods}",
              snippet: "${buildings[i].buildingName}",
            ),
          ),
          child: _customMarkerWidget(buildings[i]),
        ),
      );
    }
    return markers;
  }

  Widget _customMarkerWidget(BuildingData building) {
    return Container(
      color: Colors.white.withOpacity(0.3),
      child:
          Text(
            building.buildingName,
            style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
          ),
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    _mapControllerInitialized = true;
    if (_buildingData.isNotEmpty) {
      _moveCamera(newPosition);
    }
  }

  void _moveCamera(LatLng target) {
    mapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: target, zoom:13.0),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.5,
      child: MaterialApp(
        home: Scaffold(
          body: CustomGoogleMapMarkerBuilder(
            customMarkers: _customMarkers,
            builder: (BuildContext context, Set<Marker>? markers) {
              return GoogleMap(
                onMapCreated: _onMapCreated,
                initialCameraPosition: CameraPosition(
                  target: _center,
                  zoom: 15.0,
                ),
                circles: _circles,
                markers: markers ?? Set<Marker>(),
              );
            },
          ),
        ),
      ),
    );
  }
}