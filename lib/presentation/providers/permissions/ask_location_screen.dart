import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miscelaneos/presentation/providers/permissions/permissions_provider.dart';

class AskLocationScreen extends ConsumerWidget {
  const AskLocationScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Location Permission'),
      ),
      body: Center(
        child: FilledButton(
          child: const Text('Request Location Permission'),
          onPressed: () {
            ref.read(permissionsProvider.notifier).requestLocationAccess();
          },
        ),
      ),
    );
  }
}