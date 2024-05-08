import 'package:flutter/material.dart';
import 'package:load_frontend/constaints.dart';
import 'package:load_frontend/widgets/sidebar_menu_item.dart';

import '../model.dart';

final List<MenuItem> menuItems = [
  MenuItem('홈', Icons.home_outlined),
  MenuItem('배송관리 대시보드', Icons.dashboard_outlined),
  MenuItem('Simulation 3d', Icons.threed_rotation),
  // MenuItem('Contact', Icons.contact_mail),
];

class SideBar extends StatelessWidget {
  const SideBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    final bool _isDesktop = _size.width >= screenLg;
    return Container(
      decoration: BoxDecoration(color: primary),
      width: _isDesktop ? sideBarDesktopWidth : sideBarMobileWidth,
      padding:
          EdgeInsets.symmetric(vertical: 24, horizontal: _isDesktop ? 24 : 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Center(
            child:
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8), color: primaryAncient),
              width: 100,
              height: 45,
              child: Center(
                child: Text(
                  'LOAD',
                  style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 24,
          ),
          Center(
            child: Image.asset('assets/images/logo3.png'),
          ),
          SizedBox(
            height: 24,
          ),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children:
                menuItems.map((e) => SideBarMenuItem(e, _isDesktop)).toList(),
          ))
        ],
      ),
    );
  }
}
