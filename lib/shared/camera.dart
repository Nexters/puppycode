import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => CameraScreenState();
}

class CameraScreenState extends State<CameraScreen>
    with WidgetsBindingObserver {
  CameraController? _controller;
  bool _isCameraInitialized = false;
  late final List<CameraDescription> _cameras;

  get camera => CameraDescription;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    initCamera();
  }

  Future<void> initCamera() async {
    _cameras = await availableCameras();
    await onNewCameraSelected(_cameras.first);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final CameraController? cameraController = _controller;

    if (cameraController == null || !cameraController.value.isInitialized) {
      return;
    }

    if (state == AppLifecycleState.inactive) {
      cameraController.dispose();
    } else if (state == AppLifecycleState.resumed) {
      onNewCameraSelected(cameraController.description);
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  Future<void> onNewCameraSelected(CameraDescription description) async {
    final previousCameraController = _controller;
    setState(() {
      _isCameraInitialized = false;
    });

    final CameraController cameraController = CameraController(
      description,
      ResolutionPreset.high,
      imageFormatGroup: ImageFormatGroup.jpeg,
      enableAudio: false,
    );

    try {
      await cameraController.initialize();
    } on CameraException catch (e) {
      debugPrint('Error initializing camera: $e');
    }
    await previousCameraController?.dispose();

    if (mounted) {
      setState(() {
        _controller = cameraController;
      });
    }

    if (mounted) {
      setState(() {
        _isCameraInitialized = _controller!.value.isInitialized;
      });
    }
  }

  void _takePhoto() async {
    //final navigator = Navigator.of(context);
    final xFile = await capturePhoto();
    if (xFile != null) {
      //print(xFile.toString());
      //if (xFile.path.isNotEmpty) {
      //  navigator.push(
      //    MaterialPageRoute(
      //      builder: (context) => PreviewPage(
      //        imagePath: xFile.path,
      //      ),
      //    ),
      //  );
      //}
    }
  }

  void _flipCameraDirection() {
    var isFront =
        _controller!.description.lensDirection == CameraLensDirection.front;
    var cameraIndex = isFront ? 0 : 1;
    onNewCameraSelected(_cameras[cameraIndex]);
  }

  @override
  Widget build(BuildContext context) {
    if (_isCameraInitialized) {
      return Container(
        color: Colors.black,
        child: Stack(children: [
          Container(
            margin: const EdgeInsets.only(top: 120),
            child: AspectRatio(
              aspectRatio: 0.75,
              child: ClipRect(
                  child: FittedBox(
                fit: BoxFit.fitWidth,
                child: SizedBox(
                  width: _controller!.value.previewSize!.height,
                  height: _controller!.value.previewSize!.width,
                  child: CameraPreview(_controller!),
                ),
              )),
            ),
          ),
          Positioned(
            top: 55,
            left: 20,
            child: IconButton(
              icon: const Icon(Icons.flash_off, color: Colors.white, size: 25),
              onPressed: () {
                // 플래시 토글 기능 추가
              },
            ),
          ),
          Positioned(
            bottom: 70,
            left: 0,
            right: 0,
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    child: const Text(
                      '취소',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                    onPressed: () {
                      dispose();
                      Get.back();
                    },
                  ),
                  const SizedBox(width: 80),
                  GestureDetector(
                    onTap: () {
                      _takePhoto();
                    },
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 4),
                      ),
                    ),
                  ),
                  const SizedBox(width: 80),
                  IconButton(
                    icon: const Icon(Icons.cameraswitch,
                        color: Colors.white, size: 30),
                    onPressed: () {
                      // FIXME flip resume될 때만 되는 이슈
                      _flipCameraDirection();
                    },
                  ),
                ],
              ),
            ),
          ),
        ]),
      );
    } else {
      return const Center(
        child: CupertinoActivityIndicator(
          radius: 20,
        ),
      );
    }
  }

  Future<XFile?> capturePhoto() async {
    final CameraController? cameraController = _controller;
    if (cameraController!.value.isTakingPicture) {
      // A capture is already pending, do nothing.
      return null;
    }
    try {
      await cameraController.setFlashMode(FlashMode.off);
      XFile file = await cameraController.takePicture();
      return file;
    } on CameraException catch (e) {
      debugPrint('Error occured while taking picture: $e');
      return null;
    }
  }
}
