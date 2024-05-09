import 'package:flutter/material.dart';
import 'package:load_frontend/components/building_fraction.dart';
import 'package:load_frontend/layout/sidebar.dart';
import 'package:load_frontend/layout/topbar.dart';

import '../constaints.dart';
import '../views/box_simulation/sim_right_sidebar.dart';

class MainLayout extends StatelessWidget {
  final Widget child;
  final String topBarTitle;
  final bool isFixed;

  MainLayout(
      {Key? key,
      required this.child,
      required this.topBarTitle,
      required this.isFixed})
      : super(key: key);




  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    final _showDesktop = _size.width >= screenXxl;
    final _isSimulationPage = topBarTitle == '3D Simulation Dashboard';

    return Scaffold(
        body: SafeArea(
      child: Row(
        children: [
          SideBar(),
          Expanded(
            child: Column(
              children: [
                TopBar(showDesktop: _showDesktop, name: topBarTitle),
                !isFixed
                    ? Expanded(
                        child: SingleChildScrollView(
                          child: Padding(
                            child: child,
                            padding: EdgeInsets.all(componentPadding),
                          ),
                        ),
                      )
                    : Expanded(
                        child: child,
                      ),
              ],
            ),
          ),
          _isSimulationPage ? SimSidebarPage(_showDesktop) :
          Container(
            width: _showDesktop ? newsPageWidth : 0,
            child:
            BuildingList(_showDesktop),
          ),
        ],
      ),
    ));
  }
}
