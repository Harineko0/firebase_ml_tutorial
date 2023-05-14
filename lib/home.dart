import 'package:camera/camera.dart';
import 'package:firebase_ml_tutorial/api/common_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

final _annotatedTextProvider = StateNotifierProvider<StringNotifier, String>((ref) => StringNotifier(''));

class HomePage extends ConsumerStatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends ConsumerState<HomePage> {
  final TextRecognizer _textRecognizer = TextRecognizer(script: TextRecognitionScript.japanese);
  late CameraController _cameraController;
  late CameraDescription _camera;
  bool scanNext = false;
  bool camReady = false;

  @override
  void initState() {
    super.initState();
    initCamera();
  }

  @override
  void dispose() {
    _cameraController.dispose();
    _textRecognizer.close();
    super.dispose();
  }

  Future<void> initCamera() async {
    final cameras = await availableCameras();
    _camera = cameras[0];

    _cameraController = CameraController(_camera, ResolutionPreset.max);

    await _cameraController.initialize().catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            print('User denied camera access.');
            break;
          default:
            print('Handle other errors.');
            break;
        }
      }
    });

    if (!mounted) {
      return;
    }

    // _cameraController.startImageStream(_takePicture);

    setState(() {
      camReady = true;
    });
  }

  void _takePicture() async {
    if (!camReady) {
      return;
    }

    final xFile = await _cameraController.takePicture();

    // final inputImage = convert(
    //   camera: _camera,
    //   cameraImage: availableImage,
    // );
    final inputImage = InputImage.fromFilePath(xFile.path);

    final recognizedText = await _textRecognizer.processImage(inputImage);
    final text = recognizedText.text;

    // final text = await annotateImage(File(xFile.path));
    ref.read(_annotatedTextProvider.notifier).setState(text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          camReady ? CameraPreview(_cameraController) : const Center(child: CircularProgressIndicator()),
          Text(ref.watch(_annotatedTextProvider))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _takePicture(),
        child: const Icon(Icons.camera_alt),
      ),
    );
  }
}
