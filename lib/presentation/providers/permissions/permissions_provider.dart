import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';

// state notifier provider

final permissionsProvider = StateNotifierProvider<PermissionNotifier, PermissionState>((ref) {
  return PermissionNotifier();
});

class PermissionNotifier extends StateNotifier<PermissionState> {
  PermissionNotifier() : super(PermissionState());

  // TODO: checkPermissions()

  Future<void> checkPermissions() async {

    final permissionsArray = await Future.wait([
      Permission.camera.status,
      Permission.photos.status,
      Permission.sensors.status,
      Permission.location.status,
      Permission.locationAlways.status,
      Permission.locationWhenInUse.status,
    ]);

    state = state.copyWith(
      camera: permissionsArray[0],
      photoLibrary: permissionsArray[1],
      sensors: permissionsArray[2],
      location: permissionsArray[3],
      locationAlways: permissionsArray[4],
      locationWhenInUse: permissionsArray[5],
    );
  }

  openSettingsScreen() {
    openAppSettings();
  }

  void _checkPermissionsState(PermissionStatus status) {
    if (status.isPermanentlyDenied) {
      openSettingsScreen();
    }
  }

  requestCameraAccess() async {
    final status = await Permission.camera.request();
    state = state.copyWith(camera: status);

    _checkPermissionsState(status);
  }

  requestPhotoLibraryAccess() async {
    final status = await Permission.photos.request();
    state = state.copyWith(photoLibrary: status);

    _checkPermissionsState(status);
  }

  requestSensorsAccess() async {
    final status = await Permission.sensors.request();
    state = state.copyWith(sensors: status);

    _checkPermissionsState(status);
  }

  requestLocationAccess() async {
    final status = await Permission.location.request();
    state = state.copyWith(location: status);

    _checkPermissionsState(status);
  }

  requestLocationAlwaysAccess() async {
    final status = await Permission.locationAlways.request();
    state = state.copyWith(locationAlways: status);

    _checkPermissionsState(status);
  }

  requestLocationWhenInUseAccess() async {
    final status = await Permission.locationWhenInUse.request();
    state = state.copyWith(locationWhenInUse: status);

    _checkPermissionsState(status);
  }

}

class PermissionState{
  final PermissionStatus camera;
  final PermissionStatus photoLibrary;
  final PermissionStatus sensors;

  final PermissionStatus location;
  final PermissionStatus locationAlways;
  final PermissionStatus locationWhenInUse;

  PermissionState({
    this.camera = PermissionStatus.denied,
    this.photoLibrary = PermissionStatus.denied,
    this.sensors = PermissionStatus.denied,
    this.location = PermissionStatus.denied,
    this.locationAlways = PermissionStatus.denied,
    this.locationWhenInUse = PermissionStatus.denied,
  });

  get cameraGranted {
    return camera == PermissionStatus.granted;
  }

  get photoLibraryGranted {
    return photoLibrary == PermissionStatus.granted;
  }

  get sensorsGranted {
    return sensors == PermissionStatus.granted;
  }

  get locationGranted {
    return location == PermissionStatus.granted;
  }

  get locationAlwaysGranted {
    return locationAlways == PermissionStatus.granted;
  }

  get locationWhenInUseGranted {
    return locationWhenInUse == PermissionStatus.granted;
  }

  PermissionState copyWith({
    PermissionStatus? camera,
    PermissionStatus? photoLibrary,
    PermissionStatus? sensors,
    PermissionStatus? location,
    PermissionStatus? locationAlways,
    PermissionStatus? locationWhenInUse,
  }) => PermissionState(
      camera: camera ?? this.camera,
      photoLibrary: photoLibrary ?? this.photoLibrary,
      sensors: sensors ?? this.sensors,
      location: location ?? this.location,
      locationAlways: locationAlways ?? this.locationAlways,
      locationWhenInUse: locationWhenInUse ?? this.locationWhenInUse,
    );
}