import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miscelaneos/presentation/providers/providers.dart';

class BiometricScreen extends ConsumerWidget {
  const BiometricScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {

    final canCheckBiometrics = ref.watch(canCheckBiometricsProvider);
    final localAuthState = ref.watch(localAuthProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Biometric Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FilledButton(
              onPressed: () {
                ref.read(localAuthProvider.notifier).authenticateUser();
              },
              child: const Text('Authenticate with Biometrics'),
            ),

            canCheckBiometrics.when(
              data: ( canCheck ) => Text('Biometric check available: $canCheck'),
              loading: () => const CircularProgressIndicator(),
              error: (error, stack) => Text('Error: $error'),
            ),

            const SizedBox(height: 40),
            const Text('Estado del biometrico', style: TextStyle(fontSize: 30),  ),
            Text('Estado ${localAuthState.status}', style: TextStyle(fontSize: 30),  )

          ],
        ),
      ),
    );
  }
}