import 'package:flutter/material.dart';
import 'package:load_frontend/components/building_fraction.dart';

class BuildingPage extends StatelessWidget {
  const BuildingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BuildingList(),
    );
  }
}
