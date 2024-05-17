import 'package:flutter/material.dart';
import 'package:load_frontend/components/building_fraction.dart';
import 'package:load_frontend/layout/sidebar.dart';
import 'package:load_frontend/layout/topbar.dart';

import '../constaints.dart';
import '../views/box_simulation/sim_right_sidebar.dart';

class SimulationLayout extends StatelessWidget {
  final Widget child;

  SimulationLayout({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    final _showDesktop = _size.width >= screenXxl;
    final _isMobile = _size.width < screenSm;

    return Scaffold(
        body: SafeArea(
      child: Row(
        children: [
          !_isMobile
              ? SideBar()
              : Container(
                  width: 0,
                ),
          //SideBar(),
          Expanded(
            child: Column(
              children: [
                TopBar(
                    showDesktop: _showDesktop, name: '3D Simulation Dashboard'),
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      child: child,
                      padding: EdgeInsets.all(componentPadding),
                    ),
                  ),
                )
              ],
            ),
          ),
          _isMobile ? Container() : SimSidebarPage(_showDesktop)
        ],
      ),
    ));
  }
}
