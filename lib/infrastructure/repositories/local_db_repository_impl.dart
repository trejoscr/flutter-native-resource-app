import 'package:miscelaneos/domain/domain.dart';

import '../infrastructure.dart';

class LocalDbRepositoryImpl extends LocalDbRepository {
  final LocalDbDataSource _dataSource;

  LocalDbRepositoryImpl([LocalDbDataSource? dataSource])
      : _dataSource = dataSource ?? IsarLocalDbDatasource();

  @override
  Future<List<Pokemon>> loadPokemons() {
    return _dataSource.loadPokemons();
  }

  @override
  Future<int> pokemonCount() {
    return _dataSource.pokemonCount();
  }

  @override
  Future<void> insertPokemon(Pokemon pokemon) {
    return _dataSource.insertPokemon(pokemon);
  }
}