import 'package:miscelaneos/domain/domain.dart';

abstract class PokemonsDataSource {

  Future<(Pokemon?, String)> getPokemon(String id);

}