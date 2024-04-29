import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sidebarx/sidebarx.dart';

import '../main.dart';

class SidebarComponent extends StatelessWidget {
  final Function(int) onDestinationSelected;
  late final int selectedIndex;

  SidebarComponent({super.key,
    required this.onDestinationSelected,
    required this.selectedIndex,
  });

  @override
  Widget build(BuildContext context) {
    return SidebarX(
      controller: SidebarXController(selectedIndex: selectedIndex, extended: true),
      theme: SidebarXTheme(
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: const Color(0xFF3AB9FF),
          borderRadius: BorderRadius.circular(40),
        ),
        // hoverColor: const Color(0xFF464667),
        textStyle: const TextStyle(color: Colors.white),
        selectedTextStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.w900),
        hoverTextStyle: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w900,
        ),
        itemTextPadding: const EdgeInsets.only(left: 30),
        selectedItemTextPadding: const EdgeInsets.only(left: 30),
        itemDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(80),
          border: Border.all(color: const Color(0xFF3AB9FF)),
        ),
        selectedItemDecoration: BoxDecoration(
          border: Border.all(color: Colors.white, width: 1.0, style: BorderStyle.solid),
          borderRadius: BorderRadius.circular(120),
          // color: Color(0xFF464667),
          // boxShadow: [
          //   BoxShadow(
          //     color: Colors.black.withOpacity(0.28),
          //     blurRadius: 30,
          //   )
          // ],
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
          size: 20,
        ),
        selectedIconTheme: const IconThemeData(
          color: Colors.white,
          size: 20,
        ),
      ),
      extendedTheme: SidebarXTheme(
        width: 230,
        decoration: BoxDecoration(
            color: Color(0xFF3AB9FF),
            borderRadius: BorderRadius.circular(10)
        ),
      ),
      footerDivider: const Divider(color: Colors.white, height: 1),
      headerBuilder: (context, extended) {
        return GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, '/');
          },
          child: SizedBox(
            height: 130,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/images/logo3.png'),
                  const SizedBox(height: 8), // Adjust spacing between Image and Text
                  const Text(
                    'LOAD',
                    textAlign: TextAlign.center, // Align text to center horizontally
                    style: TextStyle(
                      color: Colors.black,
                      // Define your text style here
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      items: [
        SidebarXItem(
          icon: Icons.list_alt,
          label: '배송리스트',
          onTap: () {
            onDestinationSelected(0);
            selectedIndex = 0;
          },
        ),
        SidebarXItem(
          icon: Icons.local_shipping,
          label: '트럭 규격 입력',
          onTap: () {
            onDestinationSelected(1);
            selectedIndex = 1;
          },
        ),
        SidebarXItem(
          icon: Icons.view_in_ar,
          label: '적재 최적화 시뮬레이션',
          onTap: () {
            onDestinationSelected(2);
            selectedIndex = 2;
          },
        ),
        SidebarXItem(
          icon: Icons.location_on,
          label: '배송구역 확인',
          onTap: () {
            onDestinationSelected(3);
            selectedIndex = 3;
          },
        ),
      ],
    );
  }
}
class MyNav extends StatelessWidget {
  const MyNav({super.key});

  @override
  Widget build(BuildContext context) {
    final sidebarState = Provider.of<SidebarState>(context);
    return SizedBox(
      width: 250,
      child: Align(
        alignment: Alignment.centerLeft,
        child: SidebarComponent(
          onDestinationSelected: (index) {
            sidebarState.setSelectedIndex(index); // selectedIndex 변경
            switch (index) {
              case 0:
                Navigator.pushNamed(context, '/delivery-list');
                break;
              case 1:
                Navigator.pushNamed(context, '/set-truck-specifications');
                break;
              case 2:
                Navigator.pushNamed(context, '/box-simulation');
                break;
              case 3:
                Navigator.pushNamed(context, '/delivery-simulation');
                break;
            }
            // Handle selection logic
          },
          selectedIndex: sidebarState.selectedIndex, // Provide the selected index
        ),
      ),
    );
  }
}