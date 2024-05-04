import 'package:flutter/material.dart';
import 'package:load_frontend/components/news_list.dart';
import 'package:load_frontend/layout/sidebar.dart';
import 'package:load_frontend/layout/topbar.dart';

import '../constaints.dart';

class MainLayout extends StatelessWidget {
  final Widget child;
  MainLayout({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    final _showDesktop = _size.width >= screenXxl;
    return Scaffold(
        body: SafeArea(
      child: Row(
        children: [
          SideBar(),
          Expanded(
            child: Column(
              children: [
                TopBar(_showDesktop),
                Expanded(
                    child: SingleChildScrollView(
                        child: Padding(
                  child: this.child,
                  padding: EdgeInsets.all(componentPadding),
                )))
              ],
            ),
          ),
          Container(
            width: _showDesktop ? newsPageWidth : 0,
            child: NewsList(_showDesktop),
          )
        ],
      ),
    ));
  }
}
