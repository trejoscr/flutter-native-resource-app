import 'package:flutter/services.dart';
import 'package:local_auth/error_codes.dart' as auth_error;
import 'package:local_auth/local_auth.dart';

class LocalAuthPlugin {

  static final LocalAuthentication auth = LocalAuthentication();

  static availableBiometrics() async {

    final List<BiometricType> availableBiometrics =
    await auth.getAvailableBiometrics();

    if (availableBiometrics.isNotEmpty) {
      // Some biometrics are enrolled.
    }

    if (availableBiometrics.contains(BiometricType.strong) ||
        availableBiometrics.contains(BiometricType.face)) {
      // Specific types of biometrics are available.
      // Use checks like this with caution!
    }

  }

  static Future<bool> canCheckBiometrics() async {
    return await auth.canCheckBiometrics;
  }

  static Future<(bool, String)> authenticate({ bool biometricOnly = false }) async {

    try {

      final bool didAuthenticate = await auth.authenticate(
        localizedReason: 'Please authenticate to show account balance',
        options: AuthenticationOptions(
          biometricOnly: biometricOnly
        )
      );

      return (didAuthenticate, didAuthenticate ? 'Authentication successful' : 'Authentication failed');

    } on PlatformException catch (e) {
      print(e);

      if (e.code == auth_error.notEnrolled) return (false, 'No biometrics enrolled');
      if (e.code == auth_error.lockedOut) return (false, 'Biometric authentication locked out');
      if (e.code == auth_error.notAvailable) return (false, 'Biometric authentication not available');
      if (e.code == auth_error.passcodeNotSet) return (false, 'Passcode not set');
      if (e.code == auth_error.permanentlyLockedOut) return (false, 'Biometric authentication permanently locked out');
      return (false, 'Unknown error: ${e.message}');


    }
  }

}