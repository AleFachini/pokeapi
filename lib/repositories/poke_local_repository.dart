import 'package:hive/hive.dart';
import 'package:pokeapi/data/datamodels/poke_api_pokemon.dart';
import 'package:http/http.dart' as http;

class PokeLocalRepository {
  final String boxName;
  late Box<Pokemon> _box;
  bool _connectivityStatus = true;
  bool get connectivityStatus => _connectivityStatus;
  bool get boxIsNotEmpty => _box.toMap().isNotEmpty;

  PokeLocalRepository({required this.boxName});

  Future<void> init() async {
    //RegisteringAdapters
    Hive
      ..registerAdapter(PokemonAdapter())
      ..registerAdapter(PokemonDetailsAdapter())
      ..registerAdapter(MoveInfoAdapter())
      ..registerAdapter(AbilityInfoAdapter())
      ..registerAdapter(AbilityAdapter())
      ..registerAdapter(MoveAdapter());
    //OpeningBox
    _box = await Hive.openBox<Pokemon>(boxName);

    _connectivityStatus = await _checkConnectivity();
  }

  Future<void> close() async {
    await _box.close();
  }

  Future<void> put(int key, Pokemon value) async {
    await _box.put(key, value);
  }

  Pokemon? get(int key) {
    return _box.get(key);
  }

  List<Pokemon> getAll() {
    if (_box.toMap().isEmpty && !connectivityStatus) {
      throw Exception('No local data');
    }
    return _box.toMap().values.toList();
  }

  Future<void> delete(int key) async {
    await _box.delete(key);
  }

  Future<void> deleteAll() async {
    await _box.clear();
  }

  Future<void> add(Pokemon value) async {
    await _box.add(value);
  }

  Future<void> addAll(List<Pokemon> values) async {
    await _box.addAll(values);
  }

  Future<bool> _checkConnectivity() async {
    try {
      final url = Uri.https('google.com');
      var response = await http.head(url);
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
