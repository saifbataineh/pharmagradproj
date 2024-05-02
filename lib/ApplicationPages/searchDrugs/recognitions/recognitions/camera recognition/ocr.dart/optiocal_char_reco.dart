import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:grad_test_1/ApplicationPages/searchDrugs/recognitions/recognitions/camera%20recognition/ocr.dart/result_screen.dart';
import 'package:grad_test_1/generated/l10n.dart';
import 'package:permission_handler/permission_handler.dart';


class OpitcalChar extends StatefulWidget {
  const OpitcalChar({super.key});

  @override
  State<OpitcalChar> createState() => _OpitcalCharState();
}

class _OpitcalCharState extends State<OpitcalChar> with WidgetsBindingObserver {
  bool _ispermissionGranted = false;
  late final Future<void> _future;
  CameraController? _cameraController;
  final _textRecognizer = TextRecognizer();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _stopCamera();
    _textRecognizer.close();
    _future = _requestCameraPemission();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
@override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (_cameraController == null || !_cameraController!.value.isInitialized) {
      return;
    }
    if (state == AppLifecycleState.inactive) {
      _stopCamera();
    } else if (state == AppLifecycleState.resumed &&
        _cameraController != null &&
        _cameraController!.value.isInitialized) {
      _startCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _future,
        builder: (context, snapshot) {
          return Stack(
            children: [
              if (_ispermissionGranted)
                FutureBuilder<List<CameraDescription>>(
                    future: availableCameras(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        _instanceCameraController(snapshot.data!);
                        return Center(child: CameraPreview(_cameraController!));
                      } else {
                        return const LinearProgressIndicator();
                      }
                    }),
              Scaffold(
                  appBar: AppBar(
                    title:  Text(S.of(context).titleCamera),
                  ),
                  backgroundColor:
                      _ispermissionGranted ? Colors.transparent : null,
                  body: _ispermissionGranted
                      ? Column(children: [
                          Expanded(
                            child: Container(),
                          ),
                          Container(
                            padding: const EdgeInsets.only(bottom: 30),
                            child: Center(
                              child: ElevatedButton(
                                onPressed: _scanImage,
                                child:  Text(S.of(context).checkPhoto),
                              ),
                            ),
                          )
                        ])
                      : Center(
                          child: Container(
                            padding: const EdgeInsets.only(left: 24, right: 24),
                            child: (Text(
                              S.of(context).cameraPermission,
                              textAlign: TextAlign.center,
                            )),
                          ),
                        ))
            ],
          );
        });
  }

  Future<void> _requestCameraPemission() async {
    final status = await Permission.camera.request();
    _ispermissionGranted = status == PermissionStatus.granted;
  }

  void _startCamera() {
    if (_cameraController != null) {
      _cameraSelected(_cameraController!.description);
    }
  }

  void _stopCamera() {
    if (_cameraController != null) {
      _cameraController?.dispose();
    }
  }

  void _instanceCameraController(List<CameraDescription> cameras) {
    if (_cameraController != null) {
      return;
    }
    CameraDescription? camera;
    for (var i = 0; i < cameras.length; i++) {
      final CameraDescription current = cameras[i];
      if (current.lensDirection == CameraLensDirection.back) {
        camera = current;
        break;
      }
    }
    if (camera != null) {
      _cameraSelected(camera);
    }
  }

  Future<void> _cameraSelected(CameraDescription camera) async {
    _cameraController =
        CameraController(camera, ResolutionPreset.max, enableAudio: false);
    await _cameraController?.initialize();
    if (!mounted) {
      return;
    }
    setState(() {});
  }

  Future<void> _scanImage() async {
    if (_cameraController == null) return;
    try {
      final pictureFile = await _cameraController!.takePicture();
      final file = File(pictureFile.path);
      final inputImage = InputImage.fromFile(file);
      final recognizedText = await _textRecognizer.processImage(inputImage);
      if (!context.mounted) return;
      await Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ResultScreen(text: recognizedText.text)));
              
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
           SnackBar(content: Text(S.of(context).camraError)));
    }
  }
}
