import 'package:flutter/material.dart';

import '../components/nav_rail.dart';

class DeliverySimulationMapPage extends StatelessWidget {
  const DeliverySimulationMapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Flexible(
            child: MyNav(),
          ),
          Flexible(
              child: Center(
                child: Text('map'),
              ))
        ],
      ),
    );
  }
}