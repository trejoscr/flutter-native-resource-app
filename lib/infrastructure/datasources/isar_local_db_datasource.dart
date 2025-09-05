import 'package:isar/isar.dart';
import 'package:miscelaneos/domain/domain.dart';
import 'package:path_provider/path_provider.dart';

class IsarLocalDbDatasource extends LocalDbDataSource {

  late Future<Isar> db;

  IsarLocalDbDatasource() {
    db = openDB();
  }

  Future<Isar> openDB() async {

    final dir = await getApplicationDocumentsDirectory();

    if (  Isar.instanceNames.isEmpty) {
      return await Isar.open(
        [PokemonSchema],
        directory: dir.path,
      );
    }

    return Future.value(Isar.getInstance());
  }

  @override
  Future<List<Pokemon>> loadPokemons() async {
    final isarDB = await db;
    return await isarDB.pokemons.where().findAll();
  }

  @override
  Future<void> insertPokemon(Pokemon pokemon) async {
    final isarDB = await db;
    final done = await isarDB.writeTxnSync(() => isarDB.pokemons.putSync(pokemon));
    print('Insertado $done');
  }

  @override
  Future<int> pokemonCount() async {
    final isarDB = await db;
    return await isarDB.pokemons.count();
  }
}