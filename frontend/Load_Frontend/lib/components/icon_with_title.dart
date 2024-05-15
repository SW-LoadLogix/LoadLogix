import 'package:flutter/material.dart';

import '../constaints.dart';

class IconWithTitle extends StatefulWidget {
  final IconData icon;
  final String title;
  final String description;

  IconWithTitle({required this.icon, required this.title, required this.description});

  @override
  _IconWithTitleState createState() => _IconWithTitleState();
}

class _IconWithTitleState extends State<IconWithTitle> {
  bool _isHovered = false;

  void _updateHoverState(bool isHovered) {
    setState(() {
      _isHovered = isHovered;
    });
  }

  void _handleTap() {
    _updateHoverState(true);
    Future.delayed(Duration(seconds: 2), () {
      _updateHoverState(false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: MouseRegion(
        onEnter: (_) => _updateHoverState(true),
        onExit: (_) => _updateHoverState(false),
        child: AnimatedContainer(
          duration: Duration(milliseconds: 200),
          color: _isHovered ? primary : Colors.transparent,
          padding: EdgeInsets.all(8.0), // Padding for better visual
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(widget.icon, size: 80, color: _isHovered ? Colors.white : primary),
                  SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.title, style: TextStyle(fontSize: 16, color: _isHovered ? Colors.white : Colors.black)),
                      if (_isHovered) // Show description only when hovered or clicked
                        Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: Text(widget.description, style: TextStyle(fontSize: 14, color: Colors.white)),
                        ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
