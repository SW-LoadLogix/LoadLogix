import 'package:flutter/material.dart';
import 'package:load_frontend/constaints.dart';
import 'package:load_frontend/components/sidebar_menu_item.dart';

import '../model.dart';

final List<MenuItem> menuItems = [
  MenuItem('홈', Icons.home_outlined),
  MenuItem('배송관리 대시보드', Icons.dashboard_outlined),
  MenuItem('적재 시뮬레이션', Icons.threed_rotation),
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
            child: Image.asset('assets/images/logotouse.png'),
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
