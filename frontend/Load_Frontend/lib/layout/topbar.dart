import 'package:flutter/material.dart';
import 'package:load_frontend/constaints.dart';
import 'package:load_frontend/views/building.dart';

import '../views/box_simulation_3d.dart';
import '../views/delivery_simulation_map.dart';

class TopBar extends StatelessWidget {
  final bool showDesktop;
  final String name;

  TopBar({required this.showDesktop, required this.name});
  //const TopBar([this._showDesktop = false, this.name]);

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    final _isMobile = _size.width < screenSm;
    return Container(
      height: _isMobile ? mobileTopBarHeight : topBarHeight,
      decoration: _isMobile ?
                    BoxDecoration(color: primaryLight):
                    BoxDecoration(color:Colors.transparent),
      padding: EdgeInsets.symmetric(horizontal: componentPadding),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    name,
                    style: TextStyle(
                        fontSize: _isMobile ? 15 : 24,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                Positioned(
                  child: Container(
                    height: 4,
                    width: 60,
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(4)),
                  ),
                  bottom: 0,
                  left: 0,
                )
              ],
            ),
          ),
          Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            IconButton(
              icon: Icon(
                Icons.local_shipping,
                color: Theme.of(context).primaryColor,
              ),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(
                Icons.conveyor_belt,
                color: Theme.of(context).primaryColor,
              ),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(
                Icons.forklift,
                color: Theme.of(context).primaryColor,
              ),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(
                Icons.view_in_ar,
                color: Theme.of(context).primaryColor,
              ),
              onPressed: () {},
            ),
            this.showDesktop
                ? SizedBox.shrink()
                : IconButton(
                    icon: Icon(
                      Icons.article_outlined,
                      color: Theme.of(context).primaryColor,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => BuildingPage()),
                      );
                    },
                  )
          ])
        ],
      ),
    );
  }
}
