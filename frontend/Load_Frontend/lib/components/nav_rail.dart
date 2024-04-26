import 'package:flutter/material.dart';
import 'package:sidebarx/sidebarx.dart';

class SidebarComponent extends StatelessWidget {
  final Function(int) onDestinationSelected;
  final int selectedIndex;

  const SidebarComponent({super.key,
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
          borderRadius: BorderRadius.circular(20),
        ),
        hoverColor: const Color(0xFF464667),
        textStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
        selectedTextStyle: const TextStyle(color: Colors.white),
        hoverTextStyle: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),
        itemTextPadding: const EdgeInsets.only(left: 30),
        selectedItemTextPadding: const EdgeInsets.only(left: 30),
        itemDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: const Color(0xFF3AB9FF)),
        ),
        selectedItemDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Color(0xFF464667),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.28),
              blurRadius: 30,
            )
          ],
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
      extendedTheme: const SidebarXTheme(
        width: 230,
        decoration: BoxDecoration(
          color: Color(0xFF3AB9FF),
        ),
      ),
      footerDivider: const Divider(color: Colors.white, height: 1),
      headerBuilder: (context, extended) {
        return SizedBox(
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
                    color: Colors.white,
                    // Define your text style here
                  ),
                ),
              ],
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
          },
        ),
        SidebarXItem(
          icon: Icons.local_shipping,
          label: '트럭 규격 입력',
          onTap: () {
            onDestinationSelected(1);
          },
        ),
        SidebarXItem(
          icon: Icons.view_in_ar,
          label: '적재 최적화 시뮬레이션',
          onTap: () {
            onDestinationSelected(2);
          },
        ),
        SidebarXItem(
          icon: Icons.location_on,
          label: '배송구역 확인',
          onTap: () {
            onDestinationSelected(3);
          },
        ),
      ],
    );
  }
}
