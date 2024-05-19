import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

class ImageDescriptionWidget extends StatefulWidget {
  final String imageUrl;
  final String title;
  final String description;
  final bool imageLeft;


  ImageDescriptionWidget({
    required this.imageUrl,
    required this.title,
    required this.description,
    this.imageLeft = true, // 기본값으로 이미지가 왼쪽에 위치하도록 설정
  });

  @override
  _ImageDescriptionWidgetState createState() => _ImageDescriptionWidgetState();
}

class _ImageDescriptionWidgetState extends State<ImageDescriptionWidget> {
  double _opacity = 0.0;
  late Image image;

  void _onVisibilityChanged(VisibilityInfo info) {
    if (info.visibleFraction >= 0.5) {
      // 80% 이상 보일 때
      setState(() {
        _opacity = 1.0;
      });
    } else if (info.visibleFraction == 0) {
      setState(() {
        _opacity = 0.0;
      });
    }
  }

  @override
  void initState() {
    super.initState();

    bool isNetwork = widget.imageUrl.startsWith('http');
    image = isNetwork
        ? Image.network(widget.imageUrl, width: double.infinity)
        : Image.asset(widget.imageUrl, width: double.infinity);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    precacheImage(image.image, context);
  }


  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return VisibilityDetector(
      key: Key(widget.imageUrl), // 각 위젯을 고유하게 식별할 수 있는 키
      onVisibilityChanged: _onVisibilityChanged,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: AnimatedOpacity(
          opacity: _opacity,
          duration: _opacity > 0 ? Duration(milliseconds: 500) : Duration.zero,
          child: Container(
            color: widget.imageLeft
                ? Color.fromARGB(255, 255, 255, 255)
                : Color.fromARGB(255, 250, 250, 250),
            constraints: BoxConstraints(minHeight: screenHeight / 2.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: widget.imageLeft
                  ? _buildImageLeft(context)
                  : _buildImageRight(context),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildImageLeft(BuildContext context) {
    bool isNetwork = widget.imageUrl.startsWith('http');
    return [
      Flexible(
        flex: 4,
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0),
          child: Container(
            decoration: BoxDecoration(
              // borderRadius: BorderRadius.circular(20), // 모서리 둥글기 반지름 설정
              // border:
              //     Border.all(color: Colors.white, width: 3), // 흰색 테두리, 너비는 3픽셀
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5), // 그림자 색상, 반투명
                  spreadRadius: 5, // 그림자 범위 확장
                  blurRadius: 5, // 그림자 블러 효과
                  offset: Offset(0, 0), // 그림자의 위치 조정
                ),
              ],
            ),
            child: image,
          ),
        ),
      ),
      Flexible(
        flex: 6,
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0),
          child: Container(
            width: 450,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title,
                  style: TextStyle(
                    fontSize: 35, // 여기에서 텍스트 크기를 조절합니다.
                    height: 1.5,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff618777),
                  ),
                  // overflow: TextOverflow.ellipsis,
                ),
                Text(
                  widget.description,
                  style: TextStyle(
                    fontSize: 17, // 여기에서 텍스트 크기를 조절합니다.
                    height: 1.5,
                    fontWeight: FontWeight.w200,
                    color: Color(0xff618777),
                  ),
                  // overflow: TextOverflow.ellipsis,
                ),
              ],
            )
          ),
        ),
      ),
    ];
  }
  List<Widget> _buildImageRight(BuildContext context) {
    bool isNetwork = widget.imageUrl.startsWith('http');
    return [
      Flexible(
        flex: 6,
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0),
          child: Container(
            width: 450,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title,
                  style: TextStyle(
                    fontSize: 35, // 여기에서 텍스트 크기를 조절합니다.
                    height: 1.5,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff618777),
                  ),
                  // overflow: TextOverflow.ellipsis,
                ),
                Text(
                  widget.description,
                  style: TextStyle(
                    fontSize: 17, // 여기에서 텍스트 크기를 조절합니다.
                    height: 1.5,
                    fontWeight: FontWeight.w200,
                    color: Color(0xff618777),
                  ),
                ),
              ],
            )
          ),
        ),
      ),
      Flexible(
        flex: 4,
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0),
          child: Container(
            decoration: BoxDecoration(
              // borderRadius: BorderRadius.circular(20), // 모서리 둥글기 반지름 설정
              // border:
              //     Border.all(color: Colors.white, width: 3), // 흰색 테두리, 너비는 3픽셀
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5), // 그림자 색상, 반투명
                  spreadRadius: 5, // 그림자 범위 확장
                  blurRadius: 5, // 그림자 블러 효과
                  offset: Offset(0, 0), // 그림자의 위치 조정
                ),
              ],
            ),
            child: image,
          ),
        ),
      ),
    ];
  }
}
