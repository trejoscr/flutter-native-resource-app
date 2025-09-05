import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miscelaneos/presentation/providers/providers.dart';

class GyroscopeScreen extends ConsumerWidget {
  const GyroscopeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {

    final gyroscope$ = ref.watch(gyroscopeProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Gyroscope'),
      ),
      body: Center(
        child: gyroscope$.when(
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