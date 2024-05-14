import 'package:flutter/material.dart';
import 'package:load_frontend/constaints.dart';




class SimulationSidebarContents extends StatelessWidget {
  final bool showDesktop;
  const SimulationSidebarContents([this.showDesktop = false]);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: primaryLight.withAlpha(100),
      padding: EdgeInsets.symmetric(horizontal: componentPadding),
      child: Column(
        children: [
          Container(
            height: topBarHeight,
            child: Row(
              children: [
                this.showDesktop
                    ? SizedBox.shrink()
                    : IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                  ),
                  onPressed: () {
                    //Navigator.pop(context);
                  },
                ),
                Expanded(
                    child: Center(
                      child: Text(
                        'Simulation Sidebar Contents',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                    ))
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(

              ),
            ),
          ),
        ],
      ),
    );
  }
}
