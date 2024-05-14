import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:load_frontend/constaints.dart';
import 'package:load_frontend/model.dart';
import 'package:load_frontend/routes/app_router.dart';
import 'package:load_frontend/views/dashboard_simulation3d.dart';

class SideBarMenuItem extends StatefulWidget {
  final MenuItem item;
  final bool isDesktop;

  SideBarMenuItem(this.item, [this.isDesktop = false]);

  @override
  _MenuItemState createState() => _MenuItemState();
}

class _MenuItemState extends State<SideBarMenuItem> {
  var _bgColor = Colors.transparent;
  var _iconColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        switch(widget.item.name){
          case '홈':
            AutoRouter.of(context).push(HomeRoute());
            break;
          case '배송관리 대시보드':
            AutoRouter.of(context).popUntilRouteWithPath('/dashboard');
            AutoRouter.of(context).push(DashboardRoute());
            break;
          case 'Simulation 3d':
            AutoRouter.of(context).popUntilRouteWithPath('/dashboard');
            AutoRouter.of(context).push(DashboardSimulation3dRoute());
            break;
        }
        print(widget.item.name);
      },
      child: MouseRegion(
          onEnter: (e) {
            setState(() {
              _bgColor = Colors.white;
              _iconColor = primary;
            });
          },
          onExit: (e) {
            setState(() {
              _bgColor = Colors.transparent;
              _iconColor = Colors.white;
            });
          },
          child: Container(
            width: widget.isDesktop ? null : 44,
            height: 44,
            padding: EdgeInsets.symmetric(horizontal: 8),
            margin: EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
                color: _bgColor, borderRadius: BorderRadius.circular(8)),
            child: Row(
              mainAxisAlignment: widget.isDesktop
                  ? MainAxisAlignment.start
                  : MainAxisAlignment.center,
              children: [
                Container(
                  width: 35,
                  height: 35,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(0),
                      color: primary,
                      image: DecorationImage(
                          fit: BoxFit.cover, image: AssetImage(widget.item.icon))),
                ),
                // Icon(
                //   widget.item.icon,
                //   size: 24,
                //   color: _iconColor,
                // ),
                if (widget.isDesktop) ...[
                  SizedBox(
                    width: 16,
                  ),
                  Text(
                    widget.item.name,
                    style: TextStyle(
                      color: _iconColor,
                      fontSize: 13,
                    ),
                  )
                ] else
                  SizedBox.shrink(),
              ],
            ),
          )),
    );
  }
}
