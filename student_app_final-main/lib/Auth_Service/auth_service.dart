import 'package:local_auth/local_auth.dart';

class AuthService {
  final LocalAuthentication auth = LocalAuthentication();

  Future<bool> checkBiometrics() async {
    try {
      return await auth.canCheckBiometrics;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> authenticateWithBiometrics() async {
    bool authenticated = false;
    try {
      authenticated = await auth.authenticate(
        localizedReason: 'Scan your fingerprint (or face or whatever) to authenticate',
        options: const AuthenticationOptions(biometricOnly: true),
      );
    } catch (e) {
      print(e);
    }
    return authenticated;
  }
}
