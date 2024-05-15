// import 'package:flutter/material.dart';
//
// class ImageDescriptionWidget extends StatelessWidget {
//   final String imageUrl;
//   final String description;
//   final bool imageLeft;
//
//   ImageDescriptionWidget({
//     required this.imageUrl,
//     required this.description,
//     this.imageLeft = true, // 기본값으로 이미지가 왼쪽에 위치하도록 설정
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: imageLeft ? _buildImageLeft(context) : _buildImageRight(context),
//       ),
//     );
//   }
//
//   List<Widget> _buildImageLeft(BuildContext context) {
//     return [
//       Flexible(
//         flex: 4,
//         child: Padding(
//         padding: const EdgeInsets.only(left: 16.0, right: 16.0),
//         child: Image.network(imageUrl, width: double.infinity),
//         ),
//         //child: Image.network(imageUrl, width: MediaQuery.of(context).size.width * 0.4),
//       ),
//       //SizedBox(width: 16),
//       Flexible(
//         flex: 6,
//         child: Padding(
//           padding: const EdgeInsets.only(left: 16.0, right: 16.0),
//           child: Text(description),
//         ),
//       ),
//     ];
//   }
//
//   List<Widget> _buildImageRight(BuildContext context) {
//     return [
//       Flexible(
//         flex: 6,
//         child: Padding(
//           padding: const EdgeInsets.only(left: 16.0, right: 16.0),
//           child: Text(description),
//         ),
//       ),
//       //SizedBox(width: 16),
//       Flexible(
//         flex: 4,
//       child: Padding(
//     padding: const EdgeInsets.only(left: 16.0, right: 16.0),
//         child: Image.network(imageUrl, width: double.infinity),
//       ),
//       ),
//     ];
//   }
// }


import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

class ImageDescriptionWidget extends StatefulWidget {
  final String imageUrl;
  final String description;
  final bool imageLeft;

  ImageDescriptionWidget({
    required this.imageUrl,
    required this.description,
    this.imageLeft = true, // 기본값으로 이미지가 왼쪽에 위치하도록 설정
  });

  @override
  _ImageDescriptionWidgetState createState() => _ImageDescriptionWidgetState();
}

class _ImageDescriptionWidgetState extends State<ImageDescriptionWidget> {
  double _opacity = 0.0;

  void _onVisibilityChanged(VisibilityInfo info) {
    if (info.visibleFraction > 0) {
      setState(() {
        _opacity = 1.0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    Color backgroundColor = Theme.of(context).colorScheme.background;

    // HSLColor를 사용하여 배경 색상을 더 진하게 만듦
    HSLColor hslColor = HSLColor.fromColor(backgroundColor);
    HSLColor darkerHslColor = hslColor.withLightness((hslColor.lightness - 0.02).clamp(0.0, 1.0));
    Color darkerColor = darkerHslColor.toColor();

    return VisibilityDetector(
      key: Key(widget.imageUrl), // 각 위젯을 고유하게 식별할 수 있는 키
      onVisibilityChanged: _onVisibilityChanged,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: AnimatedOpacity(
          opacity: _opacity,
          duration: Duration(seconds: 2),
          child: Container(
            color: widget.imageLeft ? Theme.of(context).colorScheme.background: darkerColor,
            constraints: BoxConstraints(minHeight: screenHeight/2.0),
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
    return [
      Flexible(
        flex: 4,
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0),
          child: Image.network(widget.imageUrl, width: double.infinity),
        ),
      ),
      Flexible(
        flex: 6,
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0),
          child: Text(widget.description),
        ),
      ),
    ];
  }

  List<Widget> _buildImageRight(BuildContext context) {
    return [
      Flexible(
        flex: 6,
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0),
          child: Text(widget.description),
        ),
      ),
      Flexible(
        flex: 4,
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0),
          child: Image.network(widget.imageUrl, width: double.infinity),
        ),
      ),
    ];
  }
}
