import 'package:miscelaneos/domain/domain.dart';
import 'package:miscelaneos/infrastructure/datasources/pokemons_datasource_impl.dart';

class PokemonRepositoryImpl implements PokemonRepository {

  final PokemonsDataSource dataSource;

  PokemonRepositoryImpl( {PokemonsDataSource? dataSource} )
      : dataSource = dataSource ?? PokemonDataSourceImpl();

  @override
  Future<(Pokemon?, String)> getPokemon(String id) async {
    return dataSource.getPokemon(id);
  }

}