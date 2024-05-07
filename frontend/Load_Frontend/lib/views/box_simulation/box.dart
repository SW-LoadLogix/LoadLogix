import 'package:load_frontend/views/box_simulation/simulation_controller.dart';
import 'package:three_dart/three_dart.dart' as three;

double boxStep = 10.0;
double gScale = 0.1;

class Box {
  String type; //S1 to S6
  three.Vector3 currPosition;
  three.Vector3 startPosition;
  three.Vector3 endPosition;
  three.Vector3 boxSize;
  int goodsId;
  int buildingId;
  bool isDone = false;
  bool isChecked = true;
  bool isVisible = true;

  Box(this.type, this.currPosition, this.startPosition, this.endPosition,
      this.boxSize, this.goodsId, this.buildingId);

  void setSize() {
    // boxSize =
    //     three.Vector3(280 / 6 * gScale, 160 / 6 * gScale, 160 / 6 * gScale);
    // return;
    if (type == 'S1') {
      boxSize = three.Vector3(22 * gScale, 22 * gScale, 9 * gScale);
    } else if (type == 'S2') {
      boxSize = three.Vector3(27 * gScale, 27 * gScale, 15 * gScale);
    } else if (type == 'S3') {
      boxSize = three.Vector3(35 * gScale, 35 * gScale, 10 * gScale);
    } else if (type == 'S4') {
      boxSize = three.Vector3(34 * gScale, 34 * gScale, 21 * gScale);
    } else if (type == 'S5') {
      boxSize = three.Vector3(41 * gScale, 41 * gScale, 28 * gScale);
    } else if (type == 'S6') {
      boxSize = three.Vector3(48 * gScale, 48 * gScale, 34 * gScale);
    }
  }

  void init() {
    this.currPosition = this.startPosition.clone();
    setSize();
    isDone = false;
  }

  void update() {
    boxStep = 10.0 * boxStepPercent / 100.0;
    if (isDone) return;
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

  void toggleChecked() {
    isChecked = !isChecked; // 체크 상태 토글
  }
}
