import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miscelaneos/config/config.dart';
import 'package:miscelaneos/domain/domain.dart';
import 'package:miscelaneos/presentation/providers/providers.dart';
import 'package:share_plus/share_plus.dart';

class PokemonScreen extends ConsumerWidget {

  final String pokemonId;

  const PokemonScreen({
    super.key,
    required this.pokemonId
  });

  @override
  Widget build(BuildContext context, ref) {

    final pokemonAsync = ref.watch(pokemonProvider(pokemonId));

    return pokemonAsync.when(
      data: (pokemon) => _PokemonView(pokemon: pokemon),
      error: (error, stack) => _ErrorWidget(message: error.toString()),
      loading: () => const _LoadingWidget(),
    );
  }
}

class _PokemonView extends StatelessWidget {
  final Pokemon pokemon;
  const _PokemonView({required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(pokemon.name),
        actions: [
          IconButton(
            icon: const Icon(Icons.share_outlined),
            onPressed: () {
              SharePlugin.share(
                'https://trejoscr.github.io/flutter-deep-linking-webapp/pokemons/${pokemon.id}',
                'Mira este pokemon',
              );
            },
          )
        ]
      ),
      body: Center(
        child: Image.network(
          pokemon.spriteFront,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}

class _ErrorWidget extends StatelessWidget {
  final String message;
  const _ErrorWidget({required this.message});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(message),
      ),
    );
  }
}

class _LoadingWidget extends StatelessWidget {
  const _LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}