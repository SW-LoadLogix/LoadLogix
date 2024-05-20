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
                  legends: [
                    ImageSliderLegends(
                        imageUrl: 'assets/images/Group 59.png',//'assets/images/ai5.webp',
                        title: 'LoadLogix 시뮬레이션',
                        description:
                            '현명한 적재 시스템을 지향합니다.\n'
                            'LoadLogix는 물류센터의 물류 과정을 시뮬레이션하여\n'
                            '효율적인 물류 시스템을 구축합니다.\n'),
                    ImageSliderLegends(
                        imageUrl: 'assets/images/Group 63.png',//'assets/images/ai7.webp',
                        title: 'LoadLogix 경로 최적화 알고리즘',
                        description:
                          '배송기사의 경로를 최적화하여\n'
                          '배송 시간과 비용을 최소화 합니다.\n'
                          'LoadLogix는 효율적인 배송 경로를 제공하여\n'
                          '배송 과정을 더욱 신속하고 효율적으로 만들어 줍니다.\n'
                    ),
                    ImageSliderLegends(
                        imageUrl: 'assets/images/Group 60.png',//'assets/images/ai6.webp',
                        title: '배송관리 스마트 대시보드',
                        description:
                        '배송기사 스마트 대시보드는 배송 과정의 필요한 모든 정보를 제공합니다.\n'
                        '스마트 대시보드에서는 배송 상품에 대한 종합 정보를 확인할 수 있으며\n'
                        '배송관련 통계 데이터를 그래프, 지도, 표 등 다양한 방식으로 제공합니다/\n'
                        '대시보드 데이터는 실시간으로 업데이트되며 언제든지 데이터를 확인할 수 있습니다.\n'
                    ),
                    //ImageSliderLegends(imageUrl: 'assets/images/ai4.webp', title: 'title', description: 'description'),
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
                        description: '적재 자동화 맞춤 대시보드'),
                    IconWithTitle(
                        icon: Icons.local_shipping,
                        title: '애니로직',
                        description: '자동 택배 분류 시뮬레이션'),
                    IconWithTitle(
                        icon: Icons.view_in_ar,
                        title: '3D 시뮬레이션',
                        description: '적재 과정의 시각화'),
                  ],
                ),
                ImageDescriptionWidget(
                  imageUrl: 'assets/images/l1.png',
                  title: '애니로직',
                  description:
                  '애니로직 시뮬레이션은 택배 분류 과정의 시작입니다. \n애니로직으로 물류센터 내에서의 배송 물품을 준비합니다. \n고도화된 기술로 정확하고 빠른 분류를 가능하게 하여, \n처리 시간을 대폭 줄이고, 오류를 최소화합니다. \n이 모든 과정은 실시간으로 모니터링되며, \n관련 데이터는 관리자에게 지속적으로 피드백됩니다.',
                  imageLeft: true,
                ),
                ImageDescriptionWidget(
                  imageUrl: 'assets/images/l6.PNG',
                  title: '3D 시뮬레이션',
                  description:
                  '3D 시뮬레이션은 택배 적재 과정을 시각적으로 보여줌으로써 \n트럭 내부의 택배 적재 과정을 직관적으로 보여줍니다.\n택배의 크기와 무게, 배송 경로를 고려하여 \n최적의 적재 방법을 계산하고, \n그 결과를 3D 모델로 직관적으로 표현합니다.',
                  imageLeft: false,
                ),
                ImageDescriptionWidget(
                  imageUrl: 'assets/images/l3.PNG',
                  title: '경로 알고리즘',
                  description:
                      '경로 최적화 알고리즘은 \n배송 시간과 운영 비용을 최소화하기 위해 개발되었습니다. \n가장 효율적인 배송 경로를 제공하여 \n배송 과정을 더욱 신속하고 효율적으로 만들어 줍니다. \n특히 복잡한 도시 환경에서 그 가치를 발휘하여, \n배송 과정을 보다 원활하게 만들어줍니다.',
                  imageLeft: true,
                ),
                ImageDescriptionWidget(
                  imageUrl: 'assets/images/l5.PNG',
                  title: '배송기사 대시보드',
                  description:
                      '배송기사님을 위한 대시보드는 \n배송 과정의 중추적인 도구입니다. \n배송기사님은 배송 상품을 경로 순으로 확인할 수 있으며, \n배송지 경로를 지도로 제공합니다. \n최근 일주일간의 배송 활동을 그래픽으로 표현하여, \n배송 라이프스타일 관리를 도와줍니다.',
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
