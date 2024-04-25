import 'dart:convert';
import 'dart:html';

import 'package:flutter/material.dart';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_gl/flutter_gl.dart';
import 'package:three_dart/three_dart.dart' as three;
import 'package:three_dart_jsm/three_dart_jsm.dart' as three_jsm;
import 'package:flutter/scheduler.dart';



class BoxSimulation3dPage extends StatelessWidget {
  final String? data;
  const BoxSimulation3dPage({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    if (data != null) {
      print("data : $data");
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('박스 3d 시뮬레이션 페이지'), // 앱바 타이틀
      ),
      body: SizedBox(
        width: screenSize.width,
        height: screenSize.height,
        child: FallingBoxSimulate(),

      ),
    );
  }
}

class Position {
  final double x;
  final double y;
  final double z;

  Position({
    required this.x,
    required this.y,
    required this.z,
  });

  factory Position.fromJson(Map<String, dynamic> json) {
    return Position(
      x: json['x'],
      y: json['y'],
      z: json['z'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'x': x,
      'y': y,
      'z': z,
    };
  }
}

class Box {
  final Position endPosition;
  final Position size;

  Box({
    required this.endPosition,
    required this.size,
  });

  factory Box.fromJson(Map<String, dynamic> json) {
    return Box(
      endPosition: Position.fromJson(json['endPosition'][0]),
      size: Position.fromJson(json['size'][0]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'endPosition': endPosition.toJson(),
      'size': size.toJson(),
    };
  }
}

class BoxesContainer {
  final List<Box> boxes;

  BoxesContainer({
    required this.boxes,
  });

  factory BoxesContainer.fromJson(Map<String, dynamic> json) {
    var boxList = json['boxes'] as List;
    List<Box> boxes = boxList.map((i) => Box.fromJson(i)).toList();
    return BoxesContainer(
      boxes: boxes,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'boxes': boxes.map((box) => box.toJson()).toList(),
    };
  }
}





class FallingBox {
  three.Vector3? currPosition;
  three.Vector3? startPosition;
  three.Vector3? endPosition;
  three.Vector3? boxSize;

  String boxColor = "green";
  bool isTransparent = false;

  bool isDone = false;

  FallingBox({this.currPosition, this.startPosition, this.endPosition, this.boxSize, this.boxColor = "green", this.isTransparent = false});

  // 객체를 초기 위치로 설정
  void initializePosition() {
    isDone = false;
    currPosition = startPosition?.clone();
  }

  // 객체 업데이트 함수, 끝 위치까지 이동
  void update() {
    if (isDone) return;  // 이미 완료된 객체는 업데이트 하지 않음

    double step = 5;  // 이동 단위

    if (currPosition != null && endPosition!= null){
      if (currPosition!.x > endPosition!.x) {
        currPosition!.x -= step;
        if (currPosition!.x <= endPosition!.x) {
          currPosition!.x = endPosition!.x;
          isDone = true;  // 끝 위치 도달 시 완료 처리
        }
      } else {
        currPosition!.x = endPosition!.x;
        isDone = true;  // 끝 위치 도달 시 완료 처리
      }
    }



    // if (currPosition != null && endPosition!= null){
    //   if (currPosition!.y > endPosition!.y) {
    //     currPosition!.y -= step;
    //     if (currPosition!.y <= endPosition!.y) {
    //       currPosition!.y = endPosition!.y;
    //       isDone = true;  // 끝 위치 도달 시 완료 처리
    //     }
    //   } else {
    //     currPosition!.y = endPosition!.y;
    //     isDone = true;  // 끝 위치 도달 시 완료 처리
    //   }
    // }
  }
}


class FallingBoxSimulate extends StatefulWidget {

  const FallingBoxSimulate({Key? key}) : super(key: key);

  @override
  State<FallingBoxSimulate> createState() => _MyAppState();
}

class _MyAppState extends State<FallingBoxSimulate> with TickerProviderStateMixin{
  late FlutterGlPlugin three3dRender;
  three.WebGLRenderer? renderer;
  Ticker? _ticker;

  int? fboId;
  late double width;
  late double height;

  Size? screenSize;

  late three.Scene scene;
  late three.Camera camera;

  double dpr = 1.0;

  var amount = 4;

  bool verbose = true;
  bool disposed = false;

  late three.WebGLRenderTarget renderTarget;

  dynamic sourceTexture;

  final GlobalKey<three_jsm.DomLikeListenableState> _globalKey = GlobalKey<three_jsm.DomLikeListenableState>();

  late three_jsm.OrbitControls controls;

  List<FallingBox> boxes = [];  // 여러 FallingBox 관리

  late BoxesContainer boxesContainer;

  int gridSize = 6;
  double spacing = 1.1;
  int currentBoxIndex = 0;  // 현재 애니메이션 중인 상자 인덱스

  bool kIsWeb = const bool.fromEnvironment('dart.library.js_util');

  bool transparentFlag = false;

  bool isTestingDebug = false;


  @override
  void initState() {
    Uri uri = Uri.parse(window.location.href);
    String? jsonData = uri.queryParameters['data'];

    if (jsonData != null) {
      // print("jsonData : $jsonData");

      //String jsonData = '{"boxes":[{"endPosition":[{"x":0,"y":0,"z":0}],"size":[{"x":1,"y":1,"z":1}]},{"endPosition":[{"x":1,"y":0,"z":0}],"size":[{"x":1,"y":1,"z":1}]}]}';
      Map<String, dynamic> jsonMap = jsonDecode(jsonData);
      boxesContainer = BoxesContainer.fromJson(jsonMap);
      isTestingDebug = true;
    }

    super.initState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    width = screenSize!.width;
    height = screenSize!.height - 60;

    three3dRender = FlutterGlPlugin();

    Map<String, dynamic> options = {
      "antialias": true,
      "alpha": true,
      "width": width.toInt(),
      "height": height.toInt(),
      "dpr": dpr
    };

    await three3dRender.initialize(options: options);

    setState(() {});

    Future.delayed(const Duration(milliseconds: 100), () async {
      await three3dRender.prepareContext();

      initScene();
    });
  }

  initSize(BuildContext context) {
    if (screenSize != null) {
      return;
    }

    final mqd = MediaQuery.of(context);

    screenSize = mqd.size;
    dpr = mqd.devicePixelRatio;

    initPlatformState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("RJH 3D Box Simulation"),
      ),
      body: Builder(
        builder: (BuildContext context) {
          initSize(context);
          return SingleChildScrollView(
              physics: NeverScrollableScrollPhysics(),
              child: _build(context));
        },
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            child: const Text("다시하기"),
            onPressed: () {
              reStart();
            },
          ),
          SizedBox(height: 10),
          FloatingActionButton(
            child: const Text("투명하게"),
            onPressed: () {
              makeTransparent();
            },
          ),
          SizedBox(height: 10),
          FloatingActionButton(
            child: const Text("랜덤 색상변경"),
            onPressed: () {
              changeRandomBoxColor();
            },
          ),
        ],
      ),
    );
  }

  void reStart(){
    print("reStart ............. ");
    currentBoxIndex = 0;
    for (int i = 0; i < boxes.length; i++) {
      boxes[i].isTransparent = false;
      boxes[i].boxColor = "green";
      boxes[i].initializePosition();
    }
  }

  void changeRandomBoxColor(){
    Random random = Random();
    List<int> randomIndices = List.generate(10, (_) => random.nextInt(boxes.length));

    for (int index in randomIndices) {
      print("index : $index");
      boxes[index].boxColor = "red";
      boxes[index].isTransparent = false;
    }
  }


  void makeTransparent() {
    print("makeTransparent ............. ");
    if(transparentFlag == false){
      for(int i = 0; i < boxes.length; i++) {
        boxes[i].isTransparent = true;
      }
      transparentFlag = true;
    }
    else {
      for (int i = 0; i < boxes.length; i++) {
        boxes[i].isTransparent = false;
      }
      transparentFlag = false;
    }
  }

  Widget _build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            three_jsm.DomLikeListenable(
                key: _globalKey,
                builder: (BuildContext context) {
                  return Container(
                      width: width,
                      height: height,
                      color: Colors.black,
                      child: Builder(builder: (BuildContext context) {
                        if (kIsWeb) {
                          return three3dRender.isInitialized
                              ? HtmlElementView(viewType: three3dRender.textureId!.toString())
                              : Container();
                        } else {
                          return three3dRender.isInitialized
                              ? Texture(textureId: three3dRender.textureId!)
                              : Container();
                        }
                      }));
                }),
          ],
        ),
      ],
    );
  }

  int frameCount = 0;
  DateTime lastUpdateTime = DateTime.now();

  render() {
    frameCount++;
    DateTime currentTime = DateTime.now();
    final difference = currentTime.difference(lastUpdateTime).inMilliseconds;

    if (difference >= 1000) {
      double fps = frameCount / (difference / 1000);
      print("FPS: $fps");
      lastUpdateTime = currentTime;
      frameCount = 0;
    }

    final gl = three3dRender.gl;
    renderer!.render(scene, camera);
    if (verbose) {
    }

    gl.flush();


    if (!kIsWeb) {
      three3dRender.updateTexture(sourceTexture);
    }
  }

  initRenderer() {
    Map<String, dynamic> options = {
      "width": width,
      "height": height,
      "gl": three3dRender.gl,
      "antialias": true,
      "canvas": three3dRender.element,
      "alpha": true,
    };
    renderer = three.WebGLRenderer(options);
    renderer!.setPixelRatio(dpr);
    renderer!.setSize(width, height, false);
    //renderer!.shadowMap.enabled = false;

    if (!kIsWeb) {
      var pars = three.WebGLRenderTargetOptions(
          {"minFilter": three.LinearFilter, "magFilter": three.LinearFilter, "format": three.RGBAFormat});
      renderTarget = three.WebGLRenderTarget((width * dpr).toInt(), (height * dpr).toInt(), pars);
      renderTarget.samples = 4;
      renderer!.setRenderTarget(renderTarget);
      sourceTexture = renderer!.getRenderTargetGLTexture(renderTarget);
    }
  }

  initScene() {
    initRenderer();
    initPage();
  }

  initPage() {
    scene = three.Scene();
    scene.background = three.Color(0xcccccc);
    //scene.fog = three.FogExp2(0xcccccc, 0.002);

    camera = three.PerspectiveCamera(60, width / height, 1, 200);
    camera.position.set(23, 23, 0);

    // controls
    controls = three_jsm.OrbitControls(camera, _globalKey);
    // controls.listenToKeyEvents( window );
    //controls.addEventListener( 'change', render ); // call this only in static scenes (i.e., if there is no animation loop)

    controls.enableDamping = true; // an animation loop is required when either damping or auto-rotation are enabled
    controls.dampingFactor = 0.05;
    controls.screenSpacePanning = false;
    controls.minDistance = 10;
    controls.maxDistance = 200;
    controls.maxPolarAngle = three.Math.pi / 2;

    // lights

    var dirLight1 = three.DirectionalLight(0xffffff);
    dirLight1.position.set(1, 1, 1);
    scene.add(dirLight1);

    var dirLight2 = three.DirectionalLight(0x002288);
    dirLight2.position.set(-1, -1, -1);
    scene.add(dirLight2);

    var ambientLight = three.AmbientLight(0x222222);
    scene.add(ambientLight);

    var geometry = three.BoxGeometry(1, 1, 1);

    makeInstanced(geometry);






    _ticker = createTicker(
        _onTick
    )..start();
    //animate();
  }

  _onTick(Duration elapsed){
    animate();
  }


  late three.MeshPhongMaterial material;
  late three.MeshPhongMaterial edgeMaterial;
  late three.MeshPhongMaterial transparentEdgeMaterial;
  late three.MeshPhongMaterial greenMaterial;
  late three.MeshPhongMaterial redMaterial;


  late three.InstancedMesh mesh;
  late three.InstancedMesh edgeMesh;
  late three.InstancedMesh greenMesh;
  late three.InstancedMesh redMesh;
  late three.InstancedMesh transparentMesh;

  late three.Matrix4 matrix;

  late three.BoxGeometry geometry = three.BoxGeometry(1, 1, 1);

  makeInstanced(geometry) {
    matrix = three.Matrix4();
    //material = three.MeshNormalMaterial();
    material = three.MeshPhongMaterial  ({
      "color": 0x00ff00,      // 색상: 녹색
      "flatShading": true,    // 플랫 셰이딩 활성화
      "transparent": true,    // 투명화 가능하도록 설정
      "opacity": 1.0,          // 투명도 설정 (0.0 완전 투명, 1.0 완전 불투명)
    });

    edgeMaterial = three.MeshPhongMaterial({
      "color": 0x000000,      // 색상: 녹색
      "flatShading": true,    // 플랫 셰이딩 활성화
      "transparent": true,    // 투명화 가능하도록 설정
      "opacity": 1.0,          // 투명도 설정 (0.0 완전 투명, 1.0 완전 불투명)
      "wireframe": true,      // 와이어프레임 모드 활성화
    });

    transparentEdgeMaterial = three.MeshPhongMaterial({
      "color": 0x000000,      // 색상: 녹색
      "flatShading": true,    // 플랫 셰이딩 활성화
      "transparent": true,    // 투명화 가능하도록 설정
      "opacity": 0.1,          // 투명도 설정 (0.0 완전 투명, 1.0 완전 불투명)
      "wireframe": true,      // 와이어프레임 모드 활성화
    });

    greenMaterial = three.MeshPhongMaterial({
      "color": 0x00ff00,
      "flatShading": true,
      "transparent": false,
    });

    redMaterial = three.MeshPhongMaterial({
      "color": 0xff0000,
      "flatShading": true,
      "transparent": false,
    });


    int size = 6;  // 큐브의 각 차원당 크기
    double spacing = 1.1;  // 박스 간 간격
    int i = 0;

    mesh = three.InstancedMesh(geometry, material, size*size*size);
    edgeMesh = three.InstancedMesh(geometry, edgeMaterial, size*size*size);
    greenMesh = three.InstancedMesh(geometry, greenMaterial, size*size*size);
    redMesh = three.InstancedMesh(geometry, redMaterial, size*size*size);
    transparentMesh = three.InstancedMesh(geometry, transparentEdgeMaterial, size*size*size);


    if (!isTestingDebug) {
      for (int x = 0; x < size; x++) {
        for (int y = 0; y < size; y++) {
          for (int z = 0; z < size; z++) {
            /* 수정된 좌표 계산 */
            var posX = 25 + ((x - size * 0.5 + 0.5) * spacing);
            var posY = ((y - size * 0.5 + 0.5) * spacing);
            var posZ = ((z - size * 0.5 + 0.5) * spacing);
            // var posX = ((x - size * 0.5 + 0.5) * spacing);
            // var posY = 25 + ((y - size * 0.5 + 0.5) * spacing);
            // var posZ = ((z - size * 0.5 + 0.5) * spacing);
            //matrix.setPosition(posX, posY, posZ);

            var fallingBox = FallingBox(
                currPosition: three.Vector3(posX, posY, posZ),
                startPosition: three.Vector3(posX, posY, posZ),
                endPosition: three.Vector3(posX - 25, posY, posZ),
                // currPosition: three.Vector3(posX, posY, posZ),
                // startPosition: three.Vector3(posX, posY, posZ),
                // endPosition: three.Vector3(posX, posY - 25, posZ),
                boxSize: three.Vector3(1, 1, 1)
              //boxSize: randomVector3()

            );
            boxes.add(fallingBox);
          }
        }
      }
      //size = 2;
    }
    else {
      for(int i = 0; i < boxesContainer.boxes.length; i++){
        var box = boxesContainer.boxes[i];


        var posX = 25 + ((box.endPosition.x) * spacing);
        var posY = ((box.endPosition.y) * spacing);
        var posZ = ((box.endPosition.z) * spacing);

        var fallingBox = FallingBox(
            currPosition: three.Vector3(posX, posY, posZ),
            startPosition: three.Vector3(posX, posY, posZ),
            endPosition: three.Vector3(posX - 25, posY, posZ),
            // currPosition: three.Vector3(posX, posY, posZ),
            // startPosition: three.Vector3(posX, posY, posZ),
            // endPosition: three.Vector3(posX, posY - 25, posZ),
            boxSize: three.Vector3(box.size.x, box.size.y, box.size.z)
          //boxSize: randomVector3()

        );
        boxes.add(fallingBox);
      }
    }


    print("box length : ${boxes.length}");


    scene.add(mesh);
    scene.add(edgeMesh);
    scene.add(greenMesh);
    scene.add(redMesh);
    scene.add(transparentMesh);
  }



  animate() {
    if (!mounted || disposed) {
      return;
    }
    if (currentBoxIndex < boxes.length) {
      FallingBox currentBox = boxes[currentBoxIndex];
      currentBox.update();
      if (currentBox.isDone && currentBoxIndex < boxes.length) {
        currentBoxIndex++;  // 현재 상자 완료 시 다음 상자 시작
      }
    }

    scene.remove(mesh);
    scene.remove(edgeMesh);
    scene.remove(greenMesh);
    scene.remove(redMesh);
    scene.remove(transparentMesh);

    edgeMesh = three.InstancedMesh(geometry, edgeMaterial, 6*6*6);
    greenMesh = three.InstancedMesh(geometry, greenMaterial, 6*6*6);
    redMesh = three.InstancedMesh(geometry, redMaterial, 6*6*6);
    transparentMesh = three.InstancedMesh(geometry, transparentEdgeMaterial, 6*6*6);
    var quaternion = three.Quaternion();
    for(int i = 0; i < boxes.length; i++){
      matrix.setPosition(boxes[i].currPosition!.x, boxes[i].currPosition!.y, boxes[i].currPosition!.z);
      matrix.compose(boxes[i].currPosition!, quaternion, boxes[i].boxSize!);
      if (boxes[i].isTransparent == true) {
        transparentMesh.setMatrixAt(i, matrix.clone());
      }
      else {
        if (boxes[i].boxColor == "green") {
          greenMesh.setMatrixAt(i, matrix.clone());
        }
        else if (boxes[i].boxColor == "red"){
          redMesh.setMatrixAt(i, matrix.clone());
        }
        edgeMesh.setMatrixAt(i, matrix.clone());
      }
    }
    scene.add(greenMesh);
    scene.add(redMesh);
    scene.add(edgeMesh);
    scene.add(transparentMesh);

    int t = DateTime.now().millisecondsSinceEpoch;
    final gl = three3dRender.gl;
    render();
    int t1 = DateTime.now().millisecondsSinceEpoch;
    if (verbose) {
      //print("render cost: ${t1 - t} ");
      //print(renderer!.info.memory);
      //print(renderer!.info.render);
    }
    gl.flush();

    if (!kIsWeb) {
      three3dRender.updateTexture(sourceTexture);
    }
  }

  three.Vector3 randomVector3() {
    var rng = Random();
    var x = 0.1 + rng.nextDouble() * 1.9; // 0.1 ~ 2.0
    var y = 0.1 + rng.nextDouble() * 1.9; // 0.1 ~ 2.0
    var z = 0.1 + rng.nextDouble() * 1.9; // 0.1 ~ 2.0
    return three.Vector3(x, y, z);
  }

  @override
  void dispose() {
    print(" dispose ............. ");

    disposed = true;
    three3dRender.dispose();

    super.dispose();
  }
}

