import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:load_frontend/services/area_service.dart';
import 'package:load_frontend/stores/user_store.dart';
import 'package:provider/provider.dart';

import '../models/building_data.dart';

class MyGoogleMap extends StatefulWidget {
  const MyGoogleMap({Key? key}) : super(key: key);

  @override
  _MyGoogleMapState createState() => _MyGoogleMapState();
}
class _MyGoogleMapState extends State<MyGoogleMap> {
  late GoogleMapController mapController;
  final LatLng _center = const LatLng(36.36405586, 127.3561363);

  List<BuildingData> _buildingData = [];
  Set<Circle> _circles = {};

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
      _circles = _markCircles(buildingdata);
      print(_markCircles(buildingdata));
    });
  }

  Set<Circle> _markCircles(List<BuildingData> buildings) {
    Set<Circle> circles = {};

    for (int i = 0; i < buildings.length; i++) {
      print(buildings[i].buildingId.toString());
      print(buildings[i].longitude);
      circles.add(
        Circle(
          circleId: CircleId(buildings[i].buildingId.toString()),
          center: LatLng(buildings[i].latitude, buildings[i].longitude),
          radius: 1500,
          fillColor: Colors.red,
          strokeWidth: 3,
          strokeColor: Colors.black,
        ),
      );
    }

    return circles;
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
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
              zoom: 13.0,
            ),
            circles: _circles,
          ),
        ),
      ),
    );
  }
}
