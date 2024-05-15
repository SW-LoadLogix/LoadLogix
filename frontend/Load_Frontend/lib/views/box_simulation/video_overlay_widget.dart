import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constaints.dart';
import '../../stores/box_store.dart';
import '../../stores/goods_store.dart';
import '../box_simulation_3d.dart';
import 'box_simulation_gobal_setting.dart';
import 'box.dart';

class VideoControlsOverlay extends StatefulWidget {
  final VoidCallback onClose;
  final GlobalKey<VideoControlsOverlayState> overlayKey;

  VideoControlsOverlay({required this.onClose, required this.overlayKey});

  @override
  VideoControlsOverlayState createState() => VideoControlsOverlayState();
}

class VideoControlsOverlayState extends State<VideoControlsOverlay> {
  double _playbackSpeed = 1.0;
  bool _isReversed = false;
  int _currentItem = 0;
  int _totalItems = 100;
  double _currentValue = 50.0;

  void syncWithGlobalValue(int gCurrItem, int gTotalItems) {
    if (gCurrItem == _currentItem && gTotalItems == _totalItems) return;

    if (gCurrItem < 0) gCurrItem = 0;
    if (gCurrItem > gTotalItems) gCurrItem = gTotalItems;

    setState(() {
      _currentItem = gCurrItem;
      _totalItems = gTotalItems;
      _currentValue = _currentItem / _totalItems * 100;
      if (_currentValue > 100)
        _currentValue = 100.0;
      else if (_currentValue < 0) _currentValue = 0.0;
    });
  }

  void setGlobalValue() {}

  void initBoxAfterIndex(int index) {
    if (gIsForword) {
      for (int i = 0; i < boxes.length; i++) {
        SimulBox box = boxes[i];
        if (i >= index) {
          box.init();
        } else {
          box.makeAsDone();
        }
      }
    } else {
      for (int i = 0; i < boxes.length; i++) {
        SimulBox box = boxes[i];
        if (i <= index) {
          box.init();
        } else {
          box.makeAsDone();
        }
      }
    }
  }

  void updateCurrentValue(double increment) {
    setState(() {
      _currentValue = (_currentValue + increment).clamp(0, 100);
      _currentItem = (_currentValue / 100 * _totalItems).round();
      gCurrentBoxIndex = _currentItem;
      initBoxAfterIndex(gCurrentBoxIndex);
    });
  }

  void onPlayBarChanged(double value) {
    if (value < 0 || value > 100) return;

    setState(() {
      _currentValue = value;
      _currentItem = (_currentValue / 100 * _totalItems).round();

      if (_currentValue < 0) _currentValue = 0;
      if (_currentItem < 0) _currentItem = 0;

      gCurrentBoxIndex = _currentItem;
      if (gIsForword) {
        initBoxAfterIndex(gCurrentBoxIndex);
      } else {
        initBoxAfterIndex(gCurrentBoxIndex);
      }

      for (int i = 0; i < boxes.length; i++) {
        boxes[i].determineIsFinished();
      }
    });
  }

  void rewind() {
    print("rewind ............. ");
    gIsForword = false;
    for (int i = 0; i < boxes.length; i++) {
      boxes[i].determineIsFinished();
    }
  }

  @override
  Widget build(BuildContext context) {
    BoxStore boxStore = Provider.of<BoxStore>(context, listen: true);
    syncWithGlobalValue(boxStore.currentBoxIndex, boxStore.boxCount);
    final Size _size = MediaQuery.of(context).size;
    bool isMobile = _size.width < 1600;
    double centerIconSize;
    if (isMobile){
      centerIconSize = 24;
    }else{
      centerIconSize = 36;
    }

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
                onChanged: onPlayBarChanged,
              ),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      alignment: Alignment.topLeft,
                      height: 40,
                      child: Text('       ${_currentValue.round()}%',
                          style: TextStyle(fontSize: 12)),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: Icon(Icons.replay_10, size: centerIconSize),
                          onPressed: () => updateCurrentValue(-10),
                        ),
                        IconButton(
                          icon: !gIsPause
                              ? Icon(Icons.pause, size: centerIconSize)
                              : Icon(Icons.play_arrow, size: centerIconSize),
                          onPressed: () {
                            setState(() {
                              gIsPause = !gIsPause;
                            });
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.forward_10, size: centerIconSize),
                          onPressed: () => updateCurrentValue(10),
                        ),
                      ],
                    ),
                  ),
                  !isMobile ? Expanded(
                    flex : 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text("Speed:", style: TextStyle(fontSize: 10)),
                        SizedBox(width: 5),
                        Container(
                          width: 100,
                          child: Slider(
                            value: _playbackSpeed,
                            min: 0.5,
                            max: 2.0,
                            divisions: 15,
                            label: '${_playbackSpeed.toStringAsFixed(1)}x',
                            onChanged: (value) => {
                              setState(() {
                                _playbackSpeed = value;
                                gPlaySpeed = _playbackSpeed;
                              }),
                            },
                          ),
                        ),
                        Text("Reverse:", style: TextStyle(fontSize: 10)),
                        Transform.scale(
                          scale: 0.5,
                          child: Switch(
                            value: _isReversed,
                            onChanged: (bool value) {
                              setState(() {
                                _isReversed = value;
                                gIsForword = !value;
                                for (int i = 0; i < boxes.length; i++) {
                                  boxes[i].determineIsFinished();
                                }
                              });
                            },
                          ),
                        ),
                        SizedBox(width: 5),
                        Text('$_currentItem / $_totalItems',
                            style: TextStyle(fontSize: 12)),
                      ],
                    ),
                  ): Expanded(
                      flex: 1,
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: Text('$_currentItem / $_totalItems',
                            style: TextStyle(fontSize: 12)),
                      )
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
