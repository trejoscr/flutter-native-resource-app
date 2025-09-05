import 'package:miscelaneos/domain/domain.dart';
import 'package:dio/dio.dart';

import '../mappers/pokemon_mapper.dart';

class PokemonDataSourceImpl implements PokemonsDataSource {

  final Dio dio;

  PokemonDataSourceImpl() : dio = Dio(BaseOptions(
    baseUrl: 'https://pokeapi.co/api/v2/'
  ));

  @override
  Future<(Pokemon?, String)> getPokemon(String id) async {
    
    try {

      final resp = await dio.get('/pokemon/$id');
      final pokemon = PokemonMapper.pokeApiPokemonToEntity(resp.data);
      return (pokemon, '');
      
    } catch (e) {
      return (null, 'Error fetching Pokémon data');
    }

  }

}