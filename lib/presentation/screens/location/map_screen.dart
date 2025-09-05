// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:miscelaneos/presentation/providers/providers.dart';

class MapScreen extends ConsumerWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {

    final currentPositionasync = ref.watch(userLocationProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Map'),
      ),
      body: currentPositionasync.when(
          data: (data) => _MapView( initialLat: data.$1, initialLng: data.$2),
          loading: () => const CircularProgressIndicator(),
          error: (error, stack) => Text('Error: $error'),
      ),
    );
  }
}

class _MapView extends StatefulWidget {

  final double initialLat;
  final double initialLng;

  const _MapView({
    Key? key,
    required this.initialLat,
    required this.initialLng,
  }) : super(key: key);

  @override
  State<_MapView> createState() => _MapViewState();
}

class _MapViewState extends State<_MapView> {
  @override
  Widget build(BuildContext context) {
    return GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: CameraPosition(
          target: LatLng(widget.initialLat, widget.initialLng),
          zoom: 12,
        ),
        myLocationEnabled: true,
        myLocationButtonEnabled: false,
        onMapCreated: (GoogleMapController controller) {
          //_controller.complete(controller);
        },
      );
  }
}