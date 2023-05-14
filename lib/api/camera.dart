import 'package:camera/camera.dart';
import 'package:riverpod/riverpod.dart';

final cameraProvider = FutureProvider<CameraDescription>((ref) async {
  final cameras = await availableCameras();

  if (cameras.isNotEmpty) {
    return cameras[0];
  } else {
    return Future.error("Camera is null");
  }
});

final cameraControllerProvider = FutureProvider.autoDispose<CameraController>((ref) async {
  try {
    final camera = await ref.watch(cameraProvider.future);
    final controller = CameraController(camera, ResolutionPreset.max);

    try {
      await controller.initialize();
      return controller;
    } catch (e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            return Future.error('Camera Access Denied');
          default:
            return Future.error('Unknown error occurred');
        }
      }
      return Future.error('Unknown error occurred');
    }
  } catch (e) {
    return Future.error(e);
  }
});
