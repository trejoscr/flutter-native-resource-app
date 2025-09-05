/* import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miscelaneos/config/config.dart';
import 'package:miscelaneos/presentation/providers/providers.dart';

class BadgeScreen extends ConsumerWidget {
  const BadgeScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {

    final badgeCounter = ref.watch(badgeCounterProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('App Badge'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Badge(
              isLabelVisible: badgeCounter > 0,
              label: Text('$badgeCounter'),
              child: const Icon(Icons.notifications, size: 100),
            ),
            
            FilledButton(
              onPressed: () {
                ref.invalidate( badgeCounterProvider );
                AppBadgePlugin.removeBadge();
              },
              child: Text('Borrar Badge')
            )
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref.read( badgeCounterProvider.notifier ).update((state) => state + 1);
          AppBadgePlugin.updateBadge(badgeCounter + 1);
        },
        child: Icon(Icons.plus_one),
      ),

    );
  }
} */