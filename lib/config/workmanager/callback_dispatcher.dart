import 'package:miscelaneos/domain/datasources/local_db_datasource.dart';
import 'package:miscelaneos/infrastructure/infrastructure.dart';
import 'package:miscelaneos/infrastructure/repositories/local_db_repository_impl.dart';
import 'package:workmanager/workmanager.dart';

const fetchBackgroundTaskKey = "com.andresmolina.miscelaneos.fetch-background-pokemon";
const fetchPeriodicBackgroundTaskKey = "com.andresmolina.miscelaneos.fetch-periodic-background-pokemon";

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {

    switch (task) {
      case fetchBackgroundTaskKey:
        await loadNextPokemon();
        break;

      case fetchPeriodicBackgroundTaskKey:
        await loadNextPokemon();
        break;

      case Workmanager.iOSBackgroundTask:
        print("Native: iOS background fetch task");
        break;

      default:
        print("Native: Unrecognized task: $task");
        break;
    }

    return true;

    /* print("Native: Background task: $task");
    return Future.value(true); */

  });
}

Future loadNextPokemon() async {
  final localDbRepository = LocalDbRepositoryImpl();
  final pokemonRepository = PokemonRepositoryImpl();

  final lastPokemonId = await localDbRepository.pokemonCount() + 1;

  try {

    final ( pokemon, message ) = await pokemonRepository.getPokemon('$lastPokemonId');

    if (pokemon == null) throw message;

    await localDbRepository.insertPokemon(pokemon);
    print("Native: Saved pokemon ${pokemon.name}");

  } catch (e) {
    print("Native: Error saving pokemon $lastPokemonId: $e");
  }
}