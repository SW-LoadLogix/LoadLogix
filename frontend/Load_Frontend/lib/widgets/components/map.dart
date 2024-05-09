import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MyGoogleMap extends StatefulWidget {
  const MyGoogleMap({Key? key}) : super(key: key);

  @override
  _MyGoogleMapState createState() => _MyGoogleMapState();
}
class _MyGoogleMapState extends State<MyGoogleMap> {
  late GoogleMapController mapController;

  // final LatLng _center = const LatLng(45.521563, -122.677433);
  final LatLng _center = const LatLng(36.36405586, 127.3561363);
  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    Set<Circle> _circles = Set<Circle>.from([
      Circle(
        circleId: CircleId('circle_1'),
        center: LatLng(36.3644346, 127.3569143), // 원의 중심
        radius: 50, // 반지름 (미터)
        fillColor: Color(0XFF89B5A2).withOpacity(0.3), // 원 내부 색상
        strokeWidth: 3, // 원 외곽선 두께
        strokeColor: Colors.black, // 원 외곽선 색상
      ),
    ]);
    return AspectRatio(
        aspectRatio: 1.5,
        child: MaterialApp(
          home: Scaffold(
            body: GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: _center,
                zoom: 18.0,
              ),
              circles: _circles, // 원 추가
              // markers: {
              //   const Marker(
              //     markerId: const MarkerId("Sydney"),
              //     position: LatLng(36.3644346, 127.3569143),
              //     infoWindow: InfoWindow(
              //       title: "Sydney",
              //       snippet: "Capital of New South Wales",
              //     ), // InfoWi
              //   ), // Marker
              // }, // markers
            ),
          ),
        )
    );
  }
}
