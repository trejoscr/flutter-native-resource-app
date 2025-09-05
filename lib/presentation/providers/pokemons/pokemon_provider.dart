import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miscelaneos/domain/domain.dart';

import '../../../infrastructure/repositories/pokemons_repository_impl.dart';

final pokemonsRepositoryProvider = Provider<PokemonRepository>((ref) {
  // Aquí podrías inyectar dependencias si es necesario
  return PokemonRepositoryImpl();
});

final pokemonProvider = FutureProvider.family<Pokemon, String>((ref, id) async {
  final pokemonRepository = ref.watch( pokemonsRepositoryProvider );
  final (pokemon, error) = await pokemonRepository.getPokemon(id);

  if (pokemon != null) return pokemon;

  throw error;
});