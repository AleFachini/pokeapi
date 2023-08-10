import 'package:flutter/material.dart';
import 'package:pokeapi/datamodels/poke_api_pokemon.dart';
import 'package:pokeapi/repositories/poke_api_repository.dart';

class PokeApiNotifier extends ChangeNotifier {
  final PokemonRepository _repository = PokemonRepository();
  //offsetting index with endpoint starting from 001
  static const indexOffSet = 1;

  List<Pokemon> _pokemonList = [];
  List<Pokemon> get pokemonList => _pokemonList;
  int _currentListSize = 0;
  int get currentListSize => _currentListSize;
  bool _isLoading = true;
  bool get isLoading => _isLoading;

  Future<void> fetchData() async {
    await fetchPokemonList(10);
    return;
  }

  Future<void> fetchPokemonList(int limit) async {
    try {
      final list = await _repository.getPokemonList(limit);
      _currentListSize = list.length;
      _pokemonList = list;
      _addImagesUrl();
      await fetchPokemonImages();
      notifyListeners();
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  Future<void> fetchMorePokemon() async {
    try {
      _isLoading = true;
      _currentListSize = _pokemonList.length + 10;
      final list = await _repository.getPokemonList(_currentListSize);
      _pokemonList.addAll(list);
      _addImagesUrl();
      await fetchPokemonImages();
      notifyListeners();
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  Future<void> fetchPokemonDetails(int pokeListIndex) async {
    try {
      final details =
          await _repository.getPokemonDetails(pokeListIndex + indexOffSet);
      _pokemonList[pokeListIndex].details = details;
      notifyListeners();
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  void _addImagesUrl() {
    for (var i = 0; i < _pokemonList.length; i++) {
      _pokemonList[i].imageUrl = _getPathString(i);
    }
  }

  String _getPathString(int index) {
    //small hack for time compliance
    String stringID = '001';
    index = (index + indexOffSet);
    if (index < 10) {
      stringID = '00$index';
    } else if (10 >= index || index < 100) {
      stringID = '0$index';
    } else {
      stringID = index.toString();
    }
    return '${_repository.imageBaseUrl}$stringID.png';
  }

  Future<void> fetchPokemonImages() async {
    try {
      for (var i = 0; i < pokemonList.length; i++) {
        if (pokemonList[i].imageLocalPath == null) {
          pokemonList[i].imageLocalPath =
              await _repository.getPokemonImage(pokemonList[i].imageUrl);
        }
      }
      _isLoading = false;
    } catch (error) {
      debugPrint(error.toString());
    }
  }
}
