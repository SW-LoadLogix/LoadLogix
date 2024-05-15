// import 'package:auto_route/annotations.dart';
// import 'package:flutter/material.dart';
// import 'package:load_frontend/components/charts.dart';
// import 'package:load_frontend/components/status_list.dart';
// import 'package:load_frontend/constaints.dart';
// import 'package:load_frontend/layout/landing_layout.dart';
// import 'package:load_frontend/layout/main_layout.dart';
// import 'package:load_frontend/models/delivery_data.dart';
// import 'package:load_frontend/services/delivery_service.dart';
// import 'package:provider/provider.dart';
// import '../components/icon_with_title.dart';
// import '../components/image_description_widget.dart';
// import '../components/image_slider.dart';
// import '../components/landing_header.dart';
// import '../components/responsive_icon_grid.dart';
// import '../components/start_service.dart';
// import '../services/area_service.dart';
// import '../stores/delivery_store.dart';
// import '../stores/user_store.dart';
// import '../components/delivery_table.dart';
// @RoutePage()
// class MainLandingPage extends StatefulWidget {
//   const MainLandingPage({super.key});
//
//   @override
//   State<StatefulWidget> createState() {
//     return _MainLandingPage();
//   }
// }
//
// class _MainLandingPage extends State<MainLandingPage> {
//   @override
//   void initState() {
//     super.initState();
//     //뭐 api 호출할 거 있으면 여기서 호출하자고
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return LandingLayout(
//       header: LandingHeader(),
//       child: ListView(
//         padding: EdgeInsets.all(componentPadding),
//         children: [
//           ImageSlider(
//             imageUrls: [
//               'https://via.placeholder.com/900x700/618777',
//               'https://via.placeholder.com/900x700/618777',
//               'https://via.placeholder.com/900x700/618777',
//               'https://via.placeholder.com/900x700/618777',
//             ],
//           ),
//           ResponsiveIconGrid(
//             icons: [
//               IconWithTitle(icon: Icons.home, title: 'Aaaaaa'),
//               IconWithTitle(icon: Icons.search, title: 'Bbbbb'),
//               IconWithTitle(icon: Icons.settings, title: 'Ccccc'),
//               IconWithTitle(icon: Icons.account_circle, title: 'Dddddd'),
//               // IconWithTitle(icon: Icons.favorite, title: 'Eeeeee'),
//               // IconWithTitle(icon: Icons.notifications, title: 'Ffffff'),
//               // IconWithTitle(icon: Icons.message, title: 'Ggggg'),
//               // IconWithTitle(icon: Icons.help, title: 'Hhhhhh'),
//             ],
//           ),
//           ImageDescriptionWidget(
//             imageUrl: 'https://via.placeholder.com/600',
//             description: '컴포넌트 1번 설명설명 설명설명 설명 설명설명 설명 뭐시기\n'
//                 '설명설명설명1123123132312313123123123123123123123123123123123\n'
//                 '설명설명설명1123123132312313123123123123123123123123123123123\n'
//                 '설명설명설명1123123132312313123123123123123123123123123123123\n',
//             imageLeft: true,
//           ),
//           ImageDescriptionWidget(
//             imageUrl: 'https://via.placeholder.com/600',
//             description: '컴포넌트 2번 설명설명 설명설명 설명 설명설명 설명 뭐시기\n'
//                 '설명설명설명1123123132312313123123123123123123123123123123123\n'
//                 '설명설명설명1123123132312313123123123123123123123123123123123\n'
//                 '설명설명설명1123123132312313123123123123123123123123123123123\n',
//             imageLeft: false,
//           ),
//           ImageDescriptionWidget(
//             imageUrl: 'https://via.placeholder.com/600',
//             description: '컴포넌트 3번 설명설명 설명설명 설명 설명설명 설명 뭐시기\n'
//                 '설명설명설명1123123132312313123123123123123123123123123123123\n'
//                 '설명설명설명1123123132312313123123123123123123123123123123123\n'
//                 '설명설명설명1123123132312313123123123123123123123123123123123\n',
//             imageLeft: true,
//           ),
//           ImageDescriptionWidget(
//             imageUrl: 'https://via.placeholder.com/600',
//             description: '컴포넌트 4번 설명설명 설명설명 설명 설명설명 설명 뭐시기\n'
//                 '설명설명설명1123123132312313123123123123123123123123123123123\n'
//                 '설명설명설명1123123132312313123123123123123123123123123123123\n'
//                 '설명설명설명1123123132312313123123123123123123123123123123123\n',
//             imageLeft: false,
//           ),
//           StartServiceWidget(onPressed: () { print("서비스 시작 눌렀어용.."); },),
//         ],
//       ),
//     );
//   }
// }


import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:load_frontend/components/charts.dart';
import 'package:load_frontend/components/status_list.dart';
import 'package:load_frontend/constaints.dart';
import 'package:load_frontend/layout/landing_layout.dart';
import 'package:load_frontend/layout/main_layout.dart';
import 'package:load_frontend/models/delivery_data.dart';
import 'package:load_frontend/services/delivery_service.dart';
import 'package:provider/provider.dart';
import '../components/icon_with_title.dart';
import '../components/image_description_widget.dart';
import '../components/image_slider.dart';
import '../components/landing_header.dart';
import '../components/responsive_icon_grid.dart';
import '../components/start_service.dart';
import '../services/area_service.dart';
import '../stores/delivery_store.dart';
import '../stores/user_store.dart';
import '../components/delivery_table.dart';

@RoutePage()
class MainLandingPage extends StatefulWidget {
  const MainLandingPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MainLandingPage();
  }
}

class _MainLandingPage extends State<MainLandingPage> {
  @override
  void initState() {
    super.initState();
    // Call API to fetch initial data when widget is initialized
  }

  @override
  Widget build(BuildContext context) {
    return LandingLayout(
      header: LandingHeader(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,  // 추가된 코드
              children: [
                ImageSlider(
                  imageUrls: [
                    'https://via.placeholder.com/900x800/618777',
                    'https://via.placeholder.com/900x800/618777',
                    'https://via.placeholder.com/900x800/618777',
                    'https://via.placeholder.com/900x800/618777',
                  ],
                ),
                ResponsiveIconGrid(
                  icons: [
                    IconWithTitle(icon: Icons.home, title: 'Aaaaaa', description: 'Aaaaaa 설명설명설명\n설명설명설명설명설명설명\n설명끝'),
                    IconWithTitle(icon: Icons.search, title: 'Bbbbb', description: 'Bbbbb 설명설명설명\n설명설명설명설명\n설명끝'),
                    IconWithTitle(icon: Icons.settings, title: 'Ccccc', description: 'Ccccc 설명설명설명\n설명설명설명설명\n설명끝'),
                    IconWithTitle(icon: Icons.account_circle, title: 'Dddddd', description: 'Dddddd 설명설명설명\n설명설명설명설명설명설명\n설명끝'),
                  ],
                ),
                ImageDescriptionWidget(
                  imageUrl: 'https://via.placeholder.com/600',
                  description: '컴포넌트 1번 설명설명 설명설명 설명 설명설명 설명 뭐시기\n'
                      '설명설명설명1123123132312313123123123123123123123123123123123\n'
                      '설명설명설명1123123132312313123123123123123123123123123123123\n'
                      '설명설명설명1123123132312313123123123123123123123123123123123\n',
                  imageLeft: true,
                ),
                ImageDescriptionWidget(
                  imageUrl: 'https://via.placeholder.com/601',
                  description: '컴포넌트 2번 설명설명 설명설명 설명 설명설명 설명 뭐시기\n'
                      '설명설명설명1123123132312313123123123123123123123123123123123\n'
                      '설명설명설명1123123132312313123123123123123123123123123123123\n'
                      '설명설명설명1123123132312313123123123123123123123123123123123\n',
                  imageLeft: false,
                ),
                ImageDescriptionWidget(
                  imageUrl: 'https://via.placeholder.com/604',
                  description: '컴포넌트 3번 설명설명 설명설명 설명 설명설명 설명 뭐시기\n'
                      '설명설명설명1123123132312313123123123123123123123123123123123\n'
                      '설명설명설명1123123132312313123123123123123123123123123123123\n'
                      '설명설명설명1123123132312313123123123123123123123123123123123\n',
                  imageLeft: true,
                ),
                ImageDescriptionWidget(
                  imageUrl: 'https://via.placeholder.com/603',
                  description: '컴포넌트 4번 설명설명 설명설명 설명 설명설명 설명 뭐시기\n'
                      '설명설명설명1123123132312313123123123123123123123123123123123\n'
                      '설명설명설명1123123132312313123123123123123123123123123123123\n'
                      '설명설명설명1123123132312313123123123123123123123123123123123\n',
                  imageLeft: false,
                ),
                StartServiceWidget(onPressed: () { print("서비스 시작 눌렀어용.."); },),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
