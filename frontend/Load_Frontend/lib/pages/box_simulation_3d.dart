import 'package:flutter/material.dart';

import '../components/nav_rail.dart';

class BoxSimulation3dPage extends StatelessWidget {
  const BoxSimulation3dPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Row(
        children: [
          Flexible(
            child: MyNav(),
          ),
          Flexible(
              child: Center(
                child: Text('3d'),
              ))
        ],
      ),
    );
  }
}