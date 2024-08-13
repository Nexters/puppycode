import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:puppycode/pages/feeds/photo_preview.dart';

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
    final xFile = await capturePhoto();
    if (xFile != null) {
      if (xFile.path.isNotEmpty) {
        Get.to(() => PhotoPreviewPage(imagePath: xFile.path));
      }
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
      return SafeArea(
        child: Container(
          color: Colors.black,
          child: Stack(alignment: Alignment.center, children: [
            Container(
              margin: const EdgeInsets.only(bottom: 48),
              child: AspectRatio(
                aspectRatio: 0.75,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: FittedBox(
                      fit: BoxFit.fitWidth,
                      child: SizedBox(
                        width: _controller?.value.previewSize!.height,
                        height: _controller?.value.previewSize!.width,
                        child: _controller != null
                            ? CameraPreview(_controller!)
                            : null,
                      ),
                    )),
              ),
            ),
            Positioned(
              top: 15,
              left: 20,
              child: GestureDetector(
                onTap: () {
                  dispose();
                  Get.back();
                },
                child: SvgPicture.asset('assets/icons/close.svg'),
              ),
            ),
            Positioned(
              bottom: 20,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 40,
                      height: 40,
                      child: Container(
                        color: Colors.yellow,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        _takePhoto();
                      },
                      child: SvgPicture.asset('assets/icons/camera_button.svg'),
                    ),
                    GestureDetector(
                      child: SvgPicture.asset('assets/icons/camera_flip.svg'),
                      onTap: () {
                        // FIXME flip resume될 때만 되는 이슈
                        _flipCameraDirection();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ]),
        ),
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
