import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MainItem {
  final String title;
  final IconData icon;
  final String route;

  MainItem( this.title, this.icon, this.route );
}

final menuItems = <MainItem>[
  MainItem( 'Giroscopio', Icons.downloading, '/gyroscope' ),
  MainItem( 'Acelerómetro', Icons.speed, '/accelerometer' ),
  MainItem( 'Magnetometro', Icons.device_thermostat, '/magnetometer' ),

  MainItem('Giroscopio Ball', Icons.ballot, '/gyroscope-ball'),
  MainItem( 'Brújula', Icons.compass_calibration, '/compass' ),

  MainItem( 'Pokémons', Icons.catching_pokemon, '/pokemons' ),
  MainItem( 'Background Process', Icons.storage_rounded, '/db-pokemons' ),

  MainItem( 'Biometría', Icons.fingerprint, '/biometrics' ),

  MainItem( 'Ubicación', Icons.pin_drop, '/location' ),
  MainItem( 'Mapa', Icons.map_outlined, '/map' ),
  MainItem( 'Mapa Controlado', Icons.gamepad_outlined, '/controlled-map' ),

  //MainItem( 'Badge', Icons.notification_important, '/badge' ),

];

class MainMenu extends StatelessWidget {
  const MainMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverGrid.count(
      crossAxisCount: 3,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      children: menuItems.map((item) => HomeMenuItems(
        title: item.title,
        icon: item.icon,
        route: item.route,
      )).toList(),
    );
  }
}

class HomeMenuItems extends StatelessWidget {

  final String title;
  final IconData icon;
  final String route;
  final List<Color> bgColors;

  const HomeMenuItems({
    super.key,
    required this.title,
    required this.icon,
    required this.route,
    this.bgColors = const [Colors.lightBlue, Colors.blue],
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push(route),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            colors: bgColors,
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),  
        ),
     
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: Colors.white),
            const SizedBox(height: 8),
            Text(title, textAlign: TextAlign.center, style: const TextStyle(color: Colors.white)),
          ],
        ),
      ),
    );
  }
}