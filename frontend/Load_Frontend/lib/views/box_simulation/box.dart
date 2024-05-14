import 'package:load_frontend/views/box_simulation/simulation_controller.dart';
import 'package:three_dart/three_dart.dart' as three;

import 'box_simulation_gobal_setting.dart';

double boxStep = 10.0;
double gScale = 1.0;

class SimulBox {
  String type; //S1 to S6
  three.Vector3 currPosition;
  three.Vector3 startPosition;
  three.Vector3 endPosition;
  three.Vector3 boxSize;
  int goodsId;
  int buildingId;
  int boxColorId = 0;
  bool isDone = false;
  bool isChecked = true;
  bool isVisible = true;

  SimulBox(this.type, this.currPosition, this.startPosition, this.endPosition,
      this.boxSize, this.goodsId, this.buildingId,this.boxColorId);

  void setSize() {
    // boxSize =
    //      three.Vector3(280 / 6 * gScale, 160 / 6 * gScale, 160 / 6 * gScale);
    // return;
    if (type == 'L1') {
      boxSize = three.Vector3(22 * gScale,9 * gScale, 22 * gScale);
    } else if (type == 'L2') {
      boxSize = three.Vector3(27 * gScale,15 * gScale, 27 * gScale);
    } else if (type == 'L3') {
      boxSize = three.Vector3(35 * gScale,10 * gScale, 35 * gScale);
    } else if (type == 'L4') {
      boxSize = three.Vector3(34 * gScale, 21 * gScale, 34 * gScale);
    } else if (type == 'L5') {
      boxSize = three.Vector3(41 * gScale,28 * gScale, 41 * gScale);
    } else if (type == 'L6') {
      boxSize = three.Vector3(48 * gScale,34 * gScale, 48 * gScale);
    }
  }

  void init() {
    if (gIsForword){
      this.currPosition = this.startPosition.clone();
    }
    else{
      this.currPosition = this.endPosition.clone();
    }
    setSize();
    isDone = false;
  }
  void makeAsDone(){
    if (gIsForword){
      this.currPosition = this.endPosition.clone();
    }
    else{
      this.currPosition = this.startPosition.clone();
    }
    isDone = true;
  }

  void update() {
    boxStep = 10.0 * gPlaySpeed;
    if (isDone) return;
    if (gIsPause) return;

    if (gIsForword){
      if (currPosition.x > endPosition.x) {
        currPosition.x -= boxStep;
        if (currPosition.x <= endPosition.x) {
          currPosition.x = endPosition.x;
          isDone = true; // 끝 위치 도달 시 완료 처리
        }
      } else {
        currPosition.x = endPosition.x;
        isDone = true; // 끝 위치 도달 시 완료 처리
      }
    }
    else {
      if (currPosition.x < startPosition.x) {
        currPosition.x += boxStep;
        if (currPosition.x >= startPosition.x) {
          currPosition.x = startPosition.x;
          isDone = true; // 끝 위치 도달 시 완료 처리
        }
      } else {
        currPosition.x = startPosition.x;
        isDone = true; // 끝 위치 도달 시 완료 처리
      }
    }
  }

  void determineIsFinished(){
    isDone = false;
    if (gIsForword){
      if (currPosition.x <= endPosition.x) {
        isDone = true;
      }
    }
    else {
      if (currPosition.x >= startPosition.x) {
        isDone = true;
      }
    }
  }



  void toggleChecked() {
    isChecked = !isChecked; // 체크 상태 토글
  }
}
