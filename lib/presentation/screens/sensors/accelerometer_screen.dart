import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miscelaneos/presentation/providers/providers.dart';

class AccelerometerScreen extends ConsumerWidget {
  const AccelerometerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {

    final accelerometer$ = ref.watch(accelerometerGravityProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Accelerometer'),
      ),
      body: Center(
        child: accelerometer$.when(
          data: (value) => Text(
            value.toString(),
            style: const TextStyle(fontSize: 30),
          ),
          loading: () => const CircularProgressIndicator(),
          error: (error, stack) => Text('Error: $error'),
        ),
      ),
    );
  }
}