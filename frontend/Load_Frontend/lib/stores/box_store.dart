import 'package:flutter/cupertino.dart';

class BoxStore extends ChangeNotifier {
  int currentBoxIndex = 0;
  int boxCount = 100;

  void setEveryThing(int currentBoxIndex, int boxCount){
    this.currentBoxIndex = currentBoxIndex;
    this.boxCount = boxCount;
    notifyListeners();

  }

}