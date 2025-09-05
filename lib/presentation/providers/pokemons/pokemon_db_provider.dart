import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miscelaneos/domain/domain.dart';
import 'package:miscelaneos/infrastructure/repositories/local_db_repository_impl.dart';

final pokemonDbProvider = FutureProvider.autoDispose<List<Pokemon>>((ref) async {

  final localDb = LocalDbRepositoryImpl();
  final pokemons = await localDb.loadPokemons();

  return pokemons;

});