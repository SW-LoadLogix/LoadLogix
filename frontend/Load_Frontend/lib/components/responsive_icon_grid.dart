import 'package:flutter/material.dart';
import 'icon_with_title.dart';
class ResponsiveIconGrid extends StatelessWidget {
  final List<IconWithTitle> icons;

  ResponsiveIconGrid({required this.icons});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= 1200) {
          return GridView.count(
            crossAxisCount: 4,
            childAspectRatio: 2,
            children: icons,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            //mainAxisSpacing: 20,
            //crossAxisSpacing: 20,
          );
        } else if (constraints.maxWidth >= 600) {
          return GridView.count(
            crossAxisCount: 2,
            childAspectRatio: 3,
            children: icons,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            //mainAxisSpacing: 20,
            //crossAxisSpacing: 20,
          );
        } else {
          return GridView.count(
            crossAxisCount: 1,
            childAspectRatio: 2,
            children: icons,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            //mainAxisSpacing: 20,
            //crossAxisSpacing: 20,
          );
          // return Column(
          //   children: icons
          //       .map((icon) => Padding(
          //     padding: const EdgeInsets.all(8.0),
          //     child: icon,
          //   ))
          //       .toList(),
          // );
        }
      },
    );
  }
}