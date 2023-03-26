import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'functions/camera.dart';

class CameraPreiewPage extends StatefulWidget {
  const CameraPreiewPage({super.key});

  @override
  State<CameraPreiewPage> createState() => _CameraPreviweStaew();
}

class _CameraPreviweStaew extends State<CameraPreiewPage> {
  bool isControllerInitialized = false;
  @override
  void initState() {
    super.initState();
    isControllerInitialized = iscontrollerInitialized();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: isControllerInitialized
            ? CameraPreview(getCameraController())
            : const Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }
}
