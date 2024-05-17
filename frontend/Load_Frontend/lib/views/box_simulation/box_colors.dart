import 'package:flutter/material.dart';
  List<Color> distinctColors = [    Color(0xFFFF6347), // 토마토색
    Color(0xFF4682B4), // 강철청색
    Color(0xFF3CB371), // 중간해초록
    Color(0xFFFFD700), // 금색
    Color(0xFF6A5ACD), // 슬레이트블루
    Color(0xFFFF69B4), // 핫핑크
    Color(0xFFDA70D6), // 난초색
    Color(0xFF00FA9A), // 미들스프링그린
    Color(0xFF48D1CC), // 중간터쿼이즈
    Color(0xFFC71585), // 중간바이올렛레드
    Color(0xFF7FFF00), // 차트리스
    Color(0xFFFF4500), // 오렌지레드
    Color(0xFFDEB887), // 버얼우드
    Color(0xFF5F9EA0), // 캐딜락블루
    Color(0xFFD2691E), // 초콜릿
    Color(0xFFFF7F50), // 코럴
    Color(0xFF6495ED), // 콘플라워블루
    Color(0xFFFFA500), // 오렌지
    Color(0xFF008B8B), // 다크시안
    Color(0xFFBDB76B), // 다크카키
    Color(0xFFFFFFFF), //
    Color(0xFFA52A2A), // 브라운
    Color(0xFF7FFF00), // 차트리유스
    Color(0xFFD2691E), // 초콜릿
    Color(0xFFFF7F50), // 코랄
    Color(0xFF6495ED), // 콘플라워블루
    Color(0xFFFFF8DC), // 콘실크
    Color(0xFFDC143C), // 크림슨
    Color(0xFF00FFFF), // 시안
    Color(0xFF00008B), // 다크블루
    Color(0xFF008B8B), // 다크사이안
    Color(0xFFB8860B), // 다크골든로드
    Color(0xFFA9A9A9), // 다크그레이
    Color(0xFF006400), // 다크그린
    Color(0xFFBDB76B), // 다크카키
    Color(0xFF8B008B), // 다크마젠타
    Color(0xFF556B2F), // 다크올리브그린
    Color(0xFFFF8C00), // 다크오렌지
    Color(0xFF9932CC), // 다크오키드
    Color(0xFF8B0000), // 다크레드
    Color(0xFFE9967A), // 다크살몬
    Color(0xFF8FBC8F), // 다크시그린
    Color(0xFF483D8B), // 다크슬레이트블루
    Color(0xFF2F4F4F), // 다크슬레이트그레이
    Color(0xFF00CED1), // 다크터쿼이즈
    Color(0xFF9400D3), // 다크바이올렛
    Color(0xFFFF1493), // 다크핫핑크
    Color(0xFF00BFFF), // 딥스카이블루
    Color(0xFF696969), // 디미그레이
    Color(0xFF1E90FF), // 도저블루
    Color(0xFFB22222), // 파이어브릭
    Color(0xFFFFFAF0), // 플로랄화이트
    Color(0xFF228B22), // 포레스트그린
    Color(0xFFFF00FF), // 마젠타
    Color(0xFFDCDCDC), // 게인즈보로
    Color(0xFFF8F8FF), // 고스트화이트
    Color(0xFFFFD700), // 골든로드
    Color(0xFFDAA520), // 골든로드
    Color(0xFFADFF2F), // 그린엘로우
    Color(0xFFF0FFF0), // 허니듀
    Color(0xFFFF69B4), // 핫핑크
    Color(0xFFCD5C5C), // 인디언레드
    Color(0xFF4B0082), // 인디고
    Color(0xFFFFFFF0), // 아이보리
    Color(0xFFF0E68C), // 카키
    Color(0xFFE6E6FA), // 라벤더
    Color(0xFFFFF0F5), // 라벤더블러쉬
    Color(0xFF7CFC00), // 론그린
    Color(0xFFFFFACD), // 레몬초코릿
    Color(0xFFADD8E6), // 라이트블루
    Color(0xFFF08080), // 라이트코랄
    Color(0xFFE0FFFF), // 라이트시안
    Color(0xFFFAFAD2), // 라이트골든로드
    Color(0xFFD3D3D3), // 라이트그레이
    Color(0xFF90EE90), // 라이트그린
    Color(0xFFFFB6C1), // 라이트핑크
    Color(0xFFFFA07A), // 라이트살몬
    Color(0xFF20B2AA), // 라이트시그린
    Color(0xFF87CEFA), // 라이트스카이블루
    Color(0xFF778899), // 라이트슬레이트그레이
    Color(0xFFB0C4DE), // 라이트스틸블루
    Color(0xFFFFFFE0), // 라이트옐로우
    Color(0xFF00FF00), // 라임
    Color(0xFF32CD32), // 라임그린
    Color(0xFFFAF0E6), // 린넨
    Color(0xFFFF00FF), // 마젠타
    Color(0xFF800000), // 마룬
    Color(0xFF66CDAA), // 메디움아쿠아마린
    Color(0xFF0000CD), // 메디움블루
    Color(0xFFBA55D3), // 메디움오키드
    Color(0xFF9370DB), // 메디움퍼플
    Color(0xFF3CB371), // 메디움시그린
    Color(0xFF7B68EE), // 메디움슬레이트블루
    Color(0xFF00FA9A), // 메디움스프링그린
    Color(0xFF48D1CC), // 메디움터쿼이즈
    Color(0xFFC71585), // 메디움바이올렛레드
    Color(0xFF191970), // 미드나이트블루
    Color(0xFFF5FFFA), // 민트크림
    Color(0xFFFFE4E1), // 미스티로즈
    Color(0xFFFFE4B5), // 모카
    Color(0xFFFFFFFF), //
    Color(0xFFFFFFFF), //
    Color(0xFFFF6347), // 토마토색
    Color(0xFF4682B4), // 강철청색
    Color(0xFF3CB371), // 중간해초록
    Color(0xFFFFD700), // 금색
    Color(0xFF6A5ACD), // 슬레이트블루
    Color(0xFFFF69B4), // 핫핑크
    Color(0xFFDA70D6), // 난초색
    Color(0xFF00FA9A), // 미들스프링그린
  ];



// const List<Color> distinctColors = [
//   Color(0xFFFF6347), // 토마토색
//   Color(0xFF4682B4), // 강철청색
//   Color(0xFF3CB371), // 중간해초록
//   Color(0xFFFFD700), // 금색
//   Color(0xFF6A5ACD), // 슬레이트블루
//   Color(0xFFFF69B4), // 핫핑크
//   Color(0xFFDA70D6), // 난초색
//   Color(0xFF00FA9A), // 미들스프링그린
//   Color(0xFF48D1CC), // 중간터쿼이즈
//   Color(0xFFC71585), // 중간바이올렛레드
//   Color(0xFF7FFF00), // 차트리스
//   Color(0xFFFF4500), // 오렌지레드
//   Color(0xFFDEB887), // 버얼우드
//   Color(0xFF5F9EA0), // 캐딜락블루
//   Color(0xFFD2691E), // 초콜릿
//   Color(0xFFFF7F50), // 코럴
//   Color(0xFF6495ED), // 콘플라워블루
//   Color(0xFFFFA500), // 오렌지
//   Color(0xFF008B8B), // 다크시안
//   Color(0xFFBDB76B), // 다크카키
//   Color(0xFFFFFFFF),
// ];