import 'package:camera/camera.dart';

late CameraController _cameraController;

Future availCamera() async {
  final camerasList = await availableCameras();
  return camerasList;
}

Future initCamera(CameraDescription cameraDescription) async {
// create a CameraController
  _cameraController =
      CameraController(cameraDescription, ResolutionPreset.high);
// Next, initialize the controller. This returns a Future.
  try {
    await _cameraController.initialize().then((_) {
      return _;
    });
  } on CameraException catch (e) {
    print("camera error $e");
  }
}

Future disposeCamera() async {
  await _cameraController.dispose();
}

bool iscontrollerInitialized() {
  return _cameraController.value.isInitialized;
}

getCameraController() {
  return _cameraController;
}
