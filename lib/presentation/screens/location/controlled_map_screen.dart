import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:miscelaneos/presentation/providers/providers.dart';

class ControlledMapScreen extends ConsumerWidget {
  const ControlledMapScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {

    final userInitialLocation = ref.watch(userLocationProvider);

    return Scaffold(
      body: userInitialLocation.when(
        data: (data) => MapAndControls(
          latitude: data.$1,
          longitude: data.$2,
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }
}

class MapAndControls extends ConsumerWidget {
  final double latitude;
  final double longitude;

  const MapAndControls({super.key, required this.latitude, required this.longitude});

  @override
  Widget build(BuildContext context, ref) {

    final mapControllerState = ref.watch(mapControllerProvider);

    return Stack(
      children: [
        _MapView(
          initialLat: latitude,
          initialLng: longitude,
        ),

        //! boton para salir
        Positioned(
          top: 40,
          left: 20,
          child: IconButton.filledTonal(
            onPressed: () {
              context.pop();
            },
            icon: const Icon(Icons.arrow_back),
          ),
        ),

        //! ir a la posicion del usuario
        Positioned(
          bottom: 40,
          left: 20,
          child: IconButton.filledTonal(
            onPressed: () {
              ref.read(mapControllerProvider.notifier).finUser();
            },
            icon: const Icon(Icons.location_searching),
          ),
        ),

        //! seguir usuarios
        Positioned(
          bottom: 90,
          left: 20,
          child: IconButton.filledTonal(
            onPressed: () {
              ref.read(mapControllerProvider.notifier).toggleFollowUser();
            },
            icon: Icon(
              mapControllerState.followUser
                ? Icons.directions_run
                : Icons.accessibility_new_outlined
            ),
          ),
        ),

        //! crear marcador
        Positioned(
          bottom: 140,
          left: 20,
          child: IconButton.filledTonal(
            onPressed: () {
              ref.read(mapControllerProvider.notifier).addMarkerCurrentPosition();
            },
            icon: const Icon(Icons.pin_drop),
          ),
        ),
      ],
    );
  }
}

class _MapView extends ConsumerStatefulWidget {

  final double initialLat;
  final double initialLng;

  const _MapView({
    Key? key,
    required this.initialLat,
    required this.initialLng,
  }) : super(key: key);

  @override
  _MapViewState createState() => _MapViewState();
}

class _MapViewState extends ConsumerState<_MapView> {
  @override
  Widget build(BuildContext context) {

    final mapController = ref.watch(mapControllerProvider);

    return GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: CameraPosition(
          target: LatLng(widget.initialLat, widget.initialLng),
          zoom: 12,
        ),
        myLocationEnabled: true,
        zoomControlsEnabled: false,
        myLocationButtonEnabled: false,
        onMapCreated: (GoogleMapController controller) {
          //_controller.complete(controller);
          ref.read(mapControllerProvider.notifier).setMapController(controller);
        },
        onLongPress: (latLng) {
          ref.read(mapControllerProvider.notifier).addMarker(latLng.latitude, latLng.longitude, 'Marcador Personalizado');
        },
      );
  }
}