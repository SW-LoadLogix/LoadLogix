import 'dart:math';

import 'package:auto_route/annotations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gl/flutter_gl.dart';
import 'package:load_frontend/animated_login/animated_login.dart';
import 'package:load_frontend/routes/app_router.dart';
import 'package:three_dart/three3d/math/math.dart';
import 'package:three_dart/three_dart.dart' as three;
import 'package:three_dart_jsm/three_dart_jsm.dart' as three_jsm;
import 'package:three_dart_jsm/three_dart_jsm/loaders/mtl_loader.dart';
import 'package:three_dart_jsm/three_dart_jsm/loaders/mtl_loader.dart';
import 'package:three_dart_jsm/three_dart_jsm/loaders/mtl_loader.dart';
import 'package:three_dart_jsm/three_dart_jsm/loaders/mtl_loader.dart';
import 'package:three_dart_jsm/three_dart_jsm/loaders/obj_loader.dart';

import '../../models/good_data.dart';
import '../../services/goods_functions.dart';
import 'box.dart';

@RoutePage()
class BoxSimulation3dSecondPage extends StatefulWidget {
  const BoxSimulation3dSecondPage({super.key});

  @override
  _BoxSimulation3dSecondPage createState() => _BoxSimulation3dSecondPage();
}

class _BoxSimulation3dSecondPage extends State<BoxSimulation3dSecondPage>
    with TickerProviderStateMixin, WidgetsBindingObserver {
  late FlutterGlPlugin three3dRender;
  three.WebGLRenderer? renderer;
  Ticker? _ticker;
  GoodsService? goodsService = GoodsService();

  int? fboId;
  late double width;
  late double height;

  Size? screenSize;

  static late three.Scene scene;
  late three.Camera camera;
  late three.Mesh mesh;

  double dpr = 1.0;

  var amount = 4;

  bool verbose = true;
  bool disposed = false;

  late three.WebGLRenderTarget renderTarget;

  dynamic sourceTexture;

  final GlobalKey<three_jsm.DomLikeListenableState> _globalKey =
      GlobalKey<three_jsm.DomLikeListenableState>();

  late three_jsm.OrbitControls controls;
  bool kIsWeb = const bool.fromEnvironment('dart.library.js_util');

  late three.Matrix4 matrix;

  List<Box> boxes = [];

  // 각 구역 별 색상을 변경하고 최적화를 진행하기 위함
  List<three.MeshPhongMaterial> materials = [];
  List<three.InstancedMesh> meshes = [];

  three.Vector3 truckPosition = three.Vector3(5, 6, 8);

  static const List<Color> distinctColors = [
    Color(0xFFFF6347), // 토마토색
    Color(0xFF4682B4), // 강철청색
    Color(0xFF3CB371), // 중간해초록
    Color(0xFFFFD700), // 금색
    Color(0xFF6A5ACD), // 슬레이트블루
    Color(0xFFFF69B4), // 핫핑크
    Color(0xFFDA70D6), // 난초색
    Color(0xFF00FA9A), // 미들스프링그린
    Color(0xFF48D1CC), // 중간터쿼이즈
    Color(0xFFC71585), // 중간바이올렛레드
  ];

  late three.MeshPhongMaterial edgeMaterial = three.MeshPhongMaterial({
    "color": 0xFFFFFF,
    "flatShading": true,
    "transparent": true,
    "opacity": 1.0,
    "wireframe": true,
  });
  late three.InstancedMesh edgeMesh =
      three.InstancedMesh(geometry, edgeMaterial, 100);
  late three.MeshPhongMaterial transparentEdgeMaterial =
      three.MeshPhongMaterial({
    "color": 0xFFFFFF,
    "flatShading": true,
    "transparent": true,
    "opacity": 0.3,
    "wireframe": false,
  });
  late three.InstancedMesh transparentEdgeMesh =
      three.InstancedMesh(geometry, transparentEdgeMaterial, 100);

  //이것 하나만 가지고 전체 mesh를 관리
  three.BoxGeometry geometry = three.BoxGeometry(1, 1, 1);

  three.BoxGeometry adjustBoxGeometryPivot(three.BoxGeometry geometry,
      double offsetX, double offsetY, double offsetZ) {
    var vertices = geometry.attributes['position'];

    if (vertices != null) {
      for (int i = 0; i < vertices.count; i++) {
        var x = vertices.getX(i);
        var y = vertices.getY(i);
        var z = vertices.getZ(i);
        vertices.setXYZ(i, x - offsetX, y - offsetY, z - offsetZ);
      }
    }
    geometry.attributes['position'].needsUpdate = true;

    return geometry;
  }

  void adjustMeshPivot(
      three.InstancedMesh mesh, double width, double height, double depth) {
    // 피봇을 이동시킬 행렬 생성
    var pivotMatrix = three.Matrix4();
    pivotMatrix.makeTranslation(width / 2, height / 2, depth / 2);

    // 각 인스턴스에 대해 피봇 조정 행렬 적용
    for (int? i = 0; i! < mesh.count!; i++) {
      var originalMatrix = three.Matrix4();
      mesh.getMatrixAt(i, originalMatrix);

      // 피봇 조정 행렬을 원래 행렬에 곱함
      originalMatrix.multiply(pivotMatrix);

      // 수정된 행렬을 메시에 다시 설정
      mesh.setMatrixAt(i, originalMatrix);
    }

    // 메시의 모든 변경사항을 업데이트
    mesh.instanceMatrix?.needsUpdate = true;
  }

  void adjustPivot(
      three.Object3D object, double offsetX, double offsetY, double offsetZ) {
    var tempObject = three.Object3D();
    while (object.children.isNotEmpty) {
      tempObject.add(object.children.first);
    }

    if (object.geometry != null) {
      object.geometry!.translate(-offsetX, -offsetY, -offsetZ);
    }

    // 임시 컨테이너의 자식들을 원래 오브젝트로 다시 이동
    while (tempObject.children.isNotEmpty) {
      object.add(tempObject.children.first);
    }

    // 객체 자체 위치를 수정
    object.position.set(offsetX, offsetY, offsetZ);
  }

  makeInstanced(geometry) {
    for (int i = 0; i < 10; i++) {
      materials.add(three.MeshPhongMaterial({
        "color": distinctColors[i].value,
        "flatShading": true,
        "transparent": true,
        "opacity": 0.6,
      }));
    }
    edgeMaterial = three.MeshPhongMaterial({
      "color": 0x00000000,
      "flatShading": true,
      "transparent": false,
      "opacity": 1.0,
      "wireframe": true,
    });
    transparentEdgeMaterial = three.MeshPhongMaterial({
      "color": 0x0,
      "flatShading": true,
      "transparent": true,
      "opacity": 0.3,
      "wireframe": true,
    });
  }

  three.Vector3 truckSize =
      three.Vector3(280 * gScale, 160 * gScale, 160 * gScale);
  static late three.Object3D object = three.Object3D();
  static late three.Texture texture;
  bool done = false;
  static late MTLLoader mtlLoader;
  static late MaterialCreator material;
  static bool isLoaded = false; // 상태 플래그
  static OBJLoader objLoader = OBJLoader(null);

  List<String> allowedMaterialNames = [
    'wire_087224198',
    'wire_028089177',
    'wire_143224087',
    'wire_224086086',
    'wire_229166215',
    'wire_224198087',
    'wire_177028149',
    'wire_134006006',
    'wire_134110008',
    'wire_006134006'
  ];

  loadTruck() async {
    if (isLoaded == false) {
      mtlLoader = MTLLoader(three.LoadingManager());
      mtlLoader.setPath('assets/textures/');
      print("material1");
      material = await mtlLoader.loadAsync('truck.mtl');
      print("material2");
      await material.preload();
      print("material3");
      objLoader.setMaterials(material);
      object = await objLoader.loadAsync('/assets/3dmodels/3d-model.obj');
      print("object");

      for (var child in object.children) {
        if (child is three.Mesh) {
          three.Mesh mesh = child as three.Mesh;
          // 각 메쉬의 재질 이름을 확인하고 조건에 따라 처리
          if (mesh.material is three.Material &&
              (mesh.material as three.Material).name == 'wire_006134006') {
            mesh.visible = false;
          }
        }
      }


      for (var child in object.children) {
        if (child is three.Mesh) {
          three.Mesh mesh = child as three.Mesh;
          // 각 메쉬의 재질 이름을 확인하고 조건에 따라 처리
          if (mesh.material is three.Material) {
            three.Material material = mesh.material as three.Material;
            // 재질 이름이 허용된 리스트에 없으면 visible을 false로 설정
            if (!allowedMaterialNames.contains(material.name)) {
              mesh.visible = false;
            }
          }
        }
      }

      print("object loaded");
      object.rotation.y = three.Math.pi / 2;
      object.scale.set(0.005, 0.005, 0.005);
      object.position.set(5, -6, 8);
      scene.add(object);
      isLoaded = true;
    } else {
      object.position.set(5, -6, 8);
      scene.add(object);
    }
  }

  Future<void> initPlatformState() async {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    three3dRender = FlutterGlPlugin();

    Map<String, dynamic> options = {
      "antialias": true,
      "alpha": false,
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
  initState() {
    super.initState();
  }

  @override
  void dispose() {
    disposed = true;
    if (_ticker != null) {
      _ticker!.dispose(); // Ticker가 활성화된 경우 해제
    }
    three3dRender.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  FocusNode _focusNode = FocusNode();

  String positionText = "Position: x=0, y=0, z=0";
  double x = 0, y = 0, z = 0; // 트럭의 초기 위치

  void _handleKeyEvent(KeyEvent event) {
    if (event.runtimeType == KeyDownEvent) {
      double increment = 0.1; // 이동 거리 설정
      setState(() {
        switch (event.logicalKey.keyId) {
          case 119: // 'W'
            y += increment;
            break;
          case 115: // 'S'
            y -= increment;
            break;
          case 100: // 'D'
            x += increment;
            break;
          case 97: // 'A'
            x -= increment;
            break;
          case 113: // 'Q'
            z += increment;
            break;
          case 101: // 'E'
            z -= increment;
            break;
        }
        positionText = "Position: x=$x, y=$y, z=$z";
        print(positionText);
        //truckPosition.set(x, y, z);
        // 여기에서 three.js or three.dart 객체의 위치를 업데이트하는 로직을 추가
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Focus(
        focusNode: _focusNode,
        autofocus: true,
        onKeyEvent: (node, event) {
          _handleKeyEvent(event);
          return KeyEventResult.handled;
        },
        child: Builder(
          builder: (BuildContext context) {
            initSize(context);
            return Expanded(child: _build(context));
            //return SingleChildScrollView(child: _build(context));
          },
        ),
      ),
    );
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
                      width: MediaQuery.of(context).size.width * 0.8,
                      height:MediaQuery.of(context).size.height * 0.8,
                      color: Colors.black,
                      child: Builder(builder: (BuildContext context) {
                        if (kIsWeb) {
                          return three3dRender.isInitialized
                              ? HtmlElementView(
                                  viewType: three3dRender.textureId!.toString())
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

  render() {
    renderer!.render(scene, camera);
    if (!kIsWeb) {
      three3dRender.updateTexture(sourceTexture);
    }
  }

  initRenderer() {
    Map<String, dynamic> options = {
      "width": MediaQuery.of(context).size.width,
      "height": MediaQuery.of(context).size.height,
      "gl": three3dRender.gl,
      "antialias": true,
      "canvas": three3dRender.element,
      "alpha": true,
    };
    renderer = three.WebGLRenderer(options);
    renderer!.setPixelRatio(dpr);
    renderer!.setSize(MediaQuery.of(context).size.width,
        MediaQuery.of(context).size.height, false);
    //renderer!.shadowMap.enabled = false;

    if (!kIsWeb) {
      var pars = three.WebGLRenderTargetOptions({
        "minFilter": three.LinearFilter,
        "magFilter": three.LinearFilter,
        "format": three.RGBAFormat
      });
      renderTarget = three.WebGLRenderTarget(
          (MediaQuery.of(context).size.width * dpr).toInt(),
          (MediaQuery.of(context).size.height * dpr).toInt(),
          pars);
      renderTarget.samples = 4;
      renderer!.setRenderTarget(renderTarget);
      sourceTexture = renderer!.getRenderTargetGLTexture(renderTarget);
    }
  }

  initScene() {
    initRenderer();
    initPage();
  }

  initPage() async {
    scene = three.Scene();
    scene.background = three.Color(0xffffff);
    //scene.fog = three.FogExp2(0xcccccc, 0.002);

    camera = three.PerspectiveCamera(60, width / height, 1, 20000000);
    camera.position.set(45, 20, 34);

    // controls

    controls = three_jsm.OrbitControls(camera, _globalKey);
    //controls.listenToKeyEvents( window );
    //controls.addEventListener( 'change', render ); // call this only in static scenes (i.e., if there is no animation loop)

    controls.enableDamping =
        true; // an animation loop is required when either damping or auto-rotation are enabled
    controls.dampingFactor = 0.05;

    controls.screenSpacePanning = false;

    controls.minDistance = 10;
    controls.maxDistance = 20000000;

    controls.maxPolarAngle = three.Math.pi / 2;

    var floorGeometry = three.PlaneGeometry(10000, 10000); // 크기는 필요에 맞게 조절
    var floorMaterial = three.MeshPhongMaterial({
      "color": 0xffffffff, // 바닥 색상
      "side": three.DoubleSide,
    });
    var floorMesh = three.Mesh(floorGeometry, floorMaterial);
    floorMesh.rotation.x = -three.Math.pi / 2; // X축을 따라 90도 회전하여 수평 배치
    floorMesh.position.set(0, -6, 0); // 바닥 위치 조정, 필요에 따라 조절
    scene.add(floorMesh);

    // world

    makeInstanced(geometry);

    initBox();

    // var dirLight1 = three.DirectionalLight(0xffffff);
    // dirLight1.position.set(1, 1, 1);
    // scene.add(dirLight1);
    //
    // var dirLight2 = three.DirectionalLight(0x000000);
    // dirLight2.position.set(-1, -1, -1);
    // scene.add(dirLight2);
    //
    // var ambientLight = three.AmbientLight(0x777777);
    // scene.add(ambientLight);

    // 강력한 주광 조명
    var dirLight1 = three.DirectionalLight(0xffffff, 1); // 강도 1로 설정
    dirLight1.position.set(0, 10, 10);
    dirLight1.castShadow = true;
    scene.add(dirLight1);

// 약간의 보조 광
    var dirLight2 = three.DirectionalLight(0); // 강도 0.5로 밝기 감소
    dirLight2.position.set(-5, -5, -5);
    scene.add(dirLight2);

// 스포트라이트 추가, 특정 영역에 초점을 맞추고 그림자 생성
//     var spotLight = three.SpotLight(0xffffff, 0.8);
//     spotLight.position.set(65, 60, 65);
//     spotLight.angle = three.Math.pi / 6;
//     spotLight.penumbra = 0.2; // 빛의 경계 부드러움
//     spotLight.decay = 2;
//     spotLight.distance = 200;
//     spotLight.castShadow = true;
//     scene.add(spotLight);

// 환경 조명, 전체적인 밝기와 색감을 부드럽게 조정
//     var ambientLight = three.AmbientLight(0x404040); // 더 어두운 색상으로 변경
//     scene.add(ambientLight);

    await loadTruck();

    _ticker = createTicker(_onTick)..start();
  }

  _onTick(Duration elapsed) {
    animate();
  }

  animate() async {
    if (!mounted || disposed) {
      return;
    }
    onTickBox();
    render();
  }

  three.Vector3 randomVector3(double maxX, double maxY, double maxZ) {
    Random random = Random();

    // 각 축에 대해 0과 최대값 사이의 랜덤한 값 생성
    double x = random.nextDouble() * maxX;
    double y = random.nextDouble() * maxY;
    double z = random.nextDouble() * maxZ;

    return three.Vector3(x, y, z);
  }

  void initBox() async {
    geometry = adjustBoxGeometryPivot(geometry, -0.5, -0.5, -0.5);

    List<GoodsData>? goods = await goodsService?.getGoods();
    matrix = three.Matrix4();

    for (int i = 0; i < goods!.length; i++) {
      var randomValue = goods![i].position;
      //randomVector3(truckSize.x, truckSize.y, truckSize.z);
      boxes.add(Box(
          goods![i].type,
          three.Vector3(randomValue.x + 25, randomValue.y, randomValue.z),
          three.Vector3(randomValue.x + 25, randomValue.y, randomValue.z),
          three.Vector3(randomValue.x, randomValue.y, randomValue.z),
          three.Vector3(2, 2, 2),
          goods![i].goodsId,
          goods![i].areaId));
    }

    for (int i = 0; i < boxes.length; i++) {
      boxes[i].init();
    }

    /* 처음에 한번 집어 넣어줘야함 */
    for (int i = 0; i < 10; i++) {
      meshes.add(three.InstancedMesh(geometry, materials[i], boxes.length));
    }
    edgeMesh = three.InstancedMesh(geometry, edgeMaterial, boxes.length);
    transparentEdgeMesh =
        three.InstancedMesh(geometry, transparentEdgeMaterial, boxes.length);

    var quaternion = three.Quaternion();
    for (int i = 0; i < boxes.length; i++) {
      var box = boxes[i];
      if (box.isDone) {
        continue;
      }
      matrix.setPosition(
          box.currPosition!.x, box.currPosition!.y, box.currPosition!.z);
      matrix.compose(box.currPosition!, quaternion, box.boxSize!);
      meshes[box.areaId].setMatrixAt(i, matrix.clone());
    }

    for (int i = 0; i < 10; i++) {
      scene.add(meshes[i]);
    }
    scene.add(edgeMesh);
    scene.add(transparentEdgeMesh);
  }

  int currentBoxIndex = 0; // 현재 애니메이션 중인 상자 인덱스
  void onTickBox() {
    if (currentBoxIndex < boxes.length) {
      Box currentBox = boxes[currentBoxIndex];
      currentBox.update();
      if (currentBox.isDone && currentBoxIndex < boxes.length) {
        currentBoxIndex++; // 현재 상자 완료 시 다음 상자 시작
      }
    }

    scene.remove(edgeMesh);
    scene.remove(transparentEdgeMesh);
    for (int i = 0; i < 10; i++) {
      scene.remove(meshes[i]);
    }

    //loadTruck();

    matrix = three.Matrix4();
    for (int i = 0; i < 10; i++) {
      meshes[i] = three.InstancedMesh(geometry, materials[i], boxes.length);
    }
    edgeMesh = three.InstancedMesh(geometry, edgeMaterial, boxes.length);
    transparentEdgeMesh =
        three.InstancedMesh(geometry, transparentEdgeMaterial, boxes.length);

    var quaternion = three.Quaternion();

    for (int i = 0; i < currentBoxIndex + 1 && i < boxes.length; i++) {
      var box = boxes[i];

      matrix.setPosition(
          box.currPosition!.x, box.currPosition!.y, box.currPosition!.z);
      matrix.compose(box.currPosition!, quaternion, box.boxSize!);

      meshes[box.areaId].setMatrixAt(i, matrix.clone());
      edgeMesh.setMatrixAt(i, matrix.clone());
    }

    matrix.setPosition(0, 0, 0);
    matrix.compose(three.Vector3(0, 0, 0), quaternion, truckSize);
    transparentEdgeMesh.setMatrixAt(0, matrix.clone());

    // for(int i =0; i< 10; i++){
    //   adjustMeshPivot(meshes[i], 1, 1, 1);
    // }
    // adjustMeshPivot(transparentEdgeMesh, 1,1,1);
    // adjustMeshPivot(edgeMesh, 1, 1, 1);

    for (int i = 0; i < 10; i++) {
      //adjustMeshPivot(meshes[i], 1, 1, 1);
      scene.add(meshes[i]);
    }

    //adjustMeshPivot(transparentEdgeMesh, 1,1,1);
    //adjustMeshPivot(edgeMesh, 1, 1, 1);

    //scene.add(object);
    scene.add(edgeMesh);
    scene.add(transparentEdgeMesh);
  }
}
