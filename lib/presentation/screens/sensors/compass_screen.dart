import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miscelaneos/presentation/providers/providers.dart';

class CompassScreen extends ConsumerWidget {
  const CompassScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {

    final locationGranted = ref.watch( permissionsProvider ).locationGranted;
    final compassHeading$ = ref.watch( compassProvider );

    if( !locationGranted ) {
      return const AskLocationScreen();
    }

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Compass', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Center(
        child: compassHeading$.when(
          data: (heading) => Compass(heading: heading ?? 0),
          loading: () => const CircularProgressIndicator(),
          error: (error, stack) => Text('Error: $error', style: const TextStyle(color: Colors.red)),
        ),
      )
    );
  }
}

class Compass extends StatefulWidget {
  final double heading;
  const Compass({super.key, required this.heading});

  @override
  State<Compass> createState() => _CompassState();
}

class _CompassState extends State<Compass> {
  late double heading;

  double prevValue = 0.0;
  double turns = 0;

  double getTurns() {

    double? direction = widget.heading;
    direction = (direction < 0) ? (360 + direction): direction;

    double diff = direction - prevValue;
    if(diff.abs() > 180) {

      if(prevValue > direction) {
        diff = 360 - (direction-prevValue).abs();
      } else {
        diff = 360 - (prevValue-direction).abs();
        diff = diff * -1;
      }
    }

    turns += (diff / 360);
    prevValue = direction;

    return turns * -1;
  }

  @override
  void initState() {
    super.initState();
    heading = widget.heading;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text('${heading.ceil()}', style: const TextStyle(color: Colors.white, fontSize: 24)),
        const SizedBox(height: 20),
        Stack(
          alignment: Alignment.center,
          children: [
            //Image.asset('assets/images/compass/quadrant-1.png'),

            /* Transform.rotate(
              angle: (heading * (math.pi / 180) * -1 ), // Convert degrees to radians
              child: Image.asset('assets/images/compass/needle-1.png'),
            ) */

            /* AnimatedRotation(
              curve: Curves.easeInOut,
              turns: getTurns(),
              duration: const Duration(milliseconds: 1),
              child: Image.asset('assets/images/compass/needle-1.png'),
            ) */

           AnimatedRotation(
              curve: Curves.easeInOut,
              turns: getTurns(),
              duration: const Duration(milliseconds: 1),
              child: Image.asset('assets/images/compass/quadrant-1.png'),
            ),

            Image.asset('assets/images/compass/needle-1.png'),

          ],
        )
      ],
    );
  }
}