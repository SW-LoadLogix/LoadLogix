import 'package:flutter/material.dart';

import 'box_simulation_gobal_setting.dart';

class VideoControlsOverlay extends StatefulWidget {
  final VoidCallback onClose;

  VideoControlsOverlay({required this.onClose});
  @override
  _VideoControlsOverlayState createState() => _VideoControlsOverlayState();
}

class _VideoControlsOverlayState extends State<VideoControlsOverlay> {
  double _playbackSpeed = 1.0;
  bool _isReversed = false;
  int _currentItem = 5;
  int _totalItems = 10;
  double _currentValue = 50.0;

  void updateCurrentValue(double increment) {
    setState(() {
      _currentValue = (_currentValue + increment).clamp(0, 100);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 50.0,
      left: 50.0 + gCurrSideBarWidth,
      right: 50.0 + gCurrRightSideBarWidth,
      child: Material(
        elevation: 4.0,
        color: Colors.white.withOpacity(0.9), // Set transparency here
        borderRadius: BorderRadius.circular(15.0), // Rounded corners
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Slider(
                value: _currentValue,
                min: 0,
                max: 100,
                divisions: 100,
                label: _currentValue.round().toString() + '%',
                onChanged: (value) {
                  setState(() {
                    _currentValue = value;
                  });
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(Icons.replay_10, size: 24),
                    onPressed: () => updateCurrentValue(-10),
                  ),
                  IconButton(
                    icon: Icon(Icons.play_arrow, size: 24),
                    onPressed: () {}, // Play functionality here
                  ),
                  IconButton(
                    icon: Icon(Icons.forward_10, size: 24),
                    onPressed: () => updateCurrentValue(10),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text('${_currentValue.round()}%', style: TextStyle(fontSize: 12)),
                  SizedBox(width: 10),
                  Text("Speed:", style: TextStyle(fontSize: 10)),
                  SizedBox(width: 5),
                  Container(
                    width: 80,
                    child: Slider(
                      value: _playbackSpeed,
                      min: 0.5,
                      max: 2.0,
                      divisions: 15,
                      label: '${_playbackSpeed.toStringAsFixed(1)}x',
                      onChanged: (double value) {
                        setState(() {
                          _playbackSpeed = value;
                        });
                      },
                    ),
                  ),
                  Text("Reverse:", style: TextStyle(fontSize: 10)),
                  Transform.scale(
                    scale: 0.8,
                    child: Switch(
                      value: _isReversed,
                      onChanged: (bool value) {
                        setState(() {
                          _isReversed = value;
                        });
                      },
                    ),
                  ),
                  SizedBox(width: 5),
                  Text('$_currentItem / $_totalItems', style: TextStyle(fontSize: 12)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
