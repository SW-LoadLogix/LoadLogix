import 'package:flutter/material.dart';
import '../constaints.dart';

class LandingLayout extends StatefulWidget {
  final Widget header;
  final Widget child;

  LandingLayout({
    Key? key,
    required this.child,
    required this.header,
  }) : super(key: key);

  @override
  _LandingLayoutState createState() => _LandingLayoutState();
}

class _LandingLayoutState extends State<LandingLayout> {
  final ScrollController _scrollController = ScrollController();
  double _headerOpacity = 0.0;
  bool _isHeaderVisible = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    double newOpacity = _scrollController.position.pixels / 900.0;
    newOpacity = newOpacity.clamp(0.0, 1.0);


    if (_scrollController.position.pixels > 0) {
      setState(() {
        _isHeaderVisible = true;
      });
    } else {
      setState(() {
        _isHeaderVisible = false;
      });
    }

    setState(() {
      _headerOpacity = newOpacity;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _isHeaderVisible ? SizedBox(height: 65) : SizedBox(height: 0) ,
                  widget.child,
                ],
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 65,
              color: Theme.of(context).primaryColor.withOpacity(_headerOpacity),
              child: widget.header,
            ),
          ),
        ],
      ),
    );
  }
}
