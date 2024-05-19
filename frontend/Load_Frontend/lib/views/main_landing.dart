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
import 'package:auto_route/auto_route.dart';
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
import '../routes/app_router.dart';
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
              crossAxisAlignment: CrossAxisAlignment.start, // 추가된 코드
              children: [
                ImageSlider(
                  imageUrls: [
                    // 'https://via.placeholder.com/900x800/618777',
                    'assets/images/Group 54.png', 'assets/images/Group 66.png',

                    // 'assets/images/Group 50.png',  // 후보
                    // 'assets/images/ai5.webp',
                    // 'assets/images/Group 51.png',
                    // 'assets/images/ai6.webp', // 후보
                    'assets/images/Group 52.png',
                    // 'assets/images/ai4.webp',
                    'assets/images/lan25.png',
                  ],
                ),
                ResponsiveIconGrid(
                  icons: [
                    IconWithTitle(
                        icon: Icons.conveyor_belt,
                        title: '경로 최적화 알고리즘',
                        description: '효율적인 배송 경로 계획'),
                    IconWithTitle(
                        icon: Icons.forklift,
                        title: '화물 자동 적재',
                        description: '효율적인 화물 적재 자동화'),
                    IconWithTitle(
                        icon: Icons.local_shipping,
                        title: '애니로직',
                        description: '자동 택배 분류 시뮬레이션'),
                    IconWithTitle(
                        icon: Icons.view_in_ar,
                        title: '3D 시뮬레이션',
                        description: '적재 과정의 시각화'),
                    // IconWithTitle(icon: Icons.home, title: 'Aaaaaa', description: 'Aaaaaa 설명설명설명\n설명설명설명설명설명설명\n설명끝'),
                    // IconWithTitle(icon: Icons.search, title: 'Bbbbb', description: 'Bbbbb 설명설명설명\n설명설명설명설명\n설명끝'),
                    // IconWithTitle(icon: Icons.settings, title: 'Ccccc', description: 'Ccccc 설명설명설명\n설명설명설명설명\n설명끝'),
                    // IconWithTitle(icon: Icons.account_circle, title: 'Dddddd', description: 'Dddddd 설명설명설명\n설명설명설명설명설명설명\n설명끝'),
                  ],
                ),
                // ImageDescriptionWidget(
                //   imageUrl: 'assets/images/Group 53.png',
                //   description: '3D 시뮬레이션\n'
                //       // '3D 시뮬레이션을 통해 화물차 내부에서 \n\n택배가 어떻게 적재되는지 직관적으로 보여줍니다. \n\n각 택배의 크기와 무게에 따라 \n\n최적의 순서로 배열되어 배송 효율을 극대화합니다.',
                //       '• 저희의 3D 시뮬레이션은 화물차 내부에서 택배 적재 과정을 시각적으로 보여줌으로써 효율적인 적재 방법을 제시합니다.\n'
                //       '• 이 시뮬레이션은 각 택배의 크기와 무게를 고려하여 최적의 적재 순서를 계산하고,\n'
                //       '- 그 결과를 3D 모델로 직관적으로 표현합니다. 이를 통해 배송 전략을 세우고,\n'
                //       '- 차량 공간을 최대한 활용할 수 있는 방법을 개발할 수 있습니다.\n'
                //       '- 또한, 배송 효율을 극대화하기 위한 이러한 기술은 배송 시간과 운영 비용을 줄이는 데 크게 기여합니다.',
                //   imageLeft: false,
                // ),
                ImageDescriptionWidget(
                  imageUrl: 'assets/images/Group 65.png',
                  description: '애니로직\n'
                      // '저희의 고도화된 애니로직 시뮬레이션을 통해 \n\n물류센터 내 택배 분류 과정을 최적화합니다. \n\n이 시스템은 정확하고 빠른 분류를 \n\n가능하게 하여 전체적인 물류 효율을 높입니다.',

                      '우리의 첨단 애니로직 시뮬레이션은 택배 분류 과정의 핵심입니다. \n이 시뮬레이션은 물류 센터 내에서의 택배 처리 절차를 자동화합니다. \n고도화된 기술로 정확하고 빠른 분류를 가능하게 하여, 처리 시간을 대폭 줄이고, 오류율을 최소화합니다. \n이 모든 과정은 실시간으로 모니터링되며, 관련 데이터는 관리자에게 지속적으로 피드백됩니다.',
                  imageLeft: true,
                ),
                ImageDescriptionWidget(
                  imageUrl: 'assets/images/Group 59.png',
                  description: '3D 시뮬레이션\n'
                      // '3D 시뮬레이션을 통해 화물차 내부에서 \n\n택배가 어떻게 적재되는지 직관적으로 보여줍니다. \n\n각 택배의 크기와 무게에 따라 \n\n최적의 순서로 배열되어 배송 효율을 극대화합니다.',
                      '저희의 3D 시뮬레이션은 화물차 내부에서 택배 적재 과정을 시각적으로 보여줌으로써 효율적인 적재 방법을 제시합니다. \n이 시뮬레이션은 각 택배의 크기와 무게를 고려하여 최적의 적재 순서를 계산하고, 그 결과를 3D 모델로 직관적으로 표현합니다. \n이를 통해 배송 전략을 세우고, 차량 공간을 최대한 활용할 수 있는 방법을 개발할 수 있습니다. \n배송 효율을 극대화하기 위한 이러한 기술은 배송 시간과 운영 비용을 줄이는 데 크게 기여합니다.',
                  imageLeft: false,
                ),
                ImageDescriptionWidget(
                  imageUrl: 'assets/images/Group 63.png',
                  description: '경로 알고리즘\n'
                      // '우리의 경로 최적화 알고리즘은 택배 주소와 물리적 특성을 \n\n분석하여 가장 효율적인 배송 경로를 계획합니다. \n\n이를 통해 배송 시간과 비용을 절감할 수 있습니다.',
                      '우리의 경로 최적화 알고리즘은 배송 효율을 극대화하기 위해 개발되었습니다. \n이 알고리즘은 수많은 데이터 포인트를 분석하여 각 배송의 주소와 물리적 특성을 기반으로 가장 효율적인 배송 경로를 계획합니다. \n최적의 경로는 시간, 연료 소비, 운전자의 피로도를 고려하여 설정되며, 이를 통해 배송 과정을 더욱 신속하고 비용 효율적으로 만들어 줍니다. \n배송 경로 최적화는 특히 복잡한 도시 환경에서 그 가치를 발휘하여, 운전자와 물류 팀이 보다 원활하게 작업할 수 있도록 지원합니다.',
                  imageLeft: true,
                ),
                ImageDescriptionWidget(
                  imageUrl: 'assets/images/Group 60.png',
                  description:
                      // TextSpan(children: [
                      //   TextSpan(
                      //       text: '',
                      //       style: TextStyle(fontSize: 24, color: Colors.grey))
                      // ]),
                      '배송기사 대시보드\n'
                      // '배송기사 대시보드를 통해 배송 리스트와 \n\n해당 주소 위치를 지도상에서 쉽게 확인할 수 있습니다. \n\n실시간 업데이트되는 정보로 배송 과정을 \n\n더욱 원활하게 관리할 수 있습니다.',
                      '배송기사님을 위한 대시보드는 배송 과정의 중추적인 도구입니다. \n이 대시보드를 통해 배송기사님은 매일의 배송 목록을 경로 순으로 확인할 수 있으며, 각 배송지의 위치는 지도상에서 쉽게 파악할 수 있습니다. \n실시간으로 업데이트되는 배송 정보는 기사들이 현재 위치와 다음 목적지 간 최적의 경로를 선정하는 데 도움을 주며, 배송 중 발생할 수 있는 여러 문제를 예방할 수 있게 합니다. \n또한, 대시보드는 최근 일주일간의 배송 활동을 그래픽으로 표현하여, 배송 효율를 측정하는 데 중요한 역할을 합니다.',
                  imageLeft: false,
                ),
                StartServiceWidget(
                  onPressed: () {
                    // AutoRoute(path: '/sign-in-up',page: SignInUpRoute.page),
                    print("서비스 시작 눌렀어용..");
                    AutoRouter.of(context).popUntilRouteWithPath('/landing');
                    AutoRouter.of(context).push(SignInUpRoute());
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
