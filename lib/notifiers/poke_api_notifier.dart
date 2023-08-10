import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pokeapi/data/datamodels/poke_api_pokemon.dart';
import 'package:pokeapi/repositories/poke_api_repository.dart';
import 'package:pokeapi/repositories/poke_local_repository.dart';

class PokeApiNotifier extends ChangeNotifier {
  final PokemonRepository _repository = PokemonRepository();
  late final PokeLocalRepository _localRepository;
  //offsetting index with endpoint starting from 001
  static const indexOffSet = 1;
  late File imageFile;

  List<Pokemon> _pokemonList = [];
  List<Pokemon> get pokemonList => _pokemonList;
  List<Pokemon> pokemonSearchList = [];

  int _currentListSize = 0;
  int get currentListSize => _currentListSize;
  bool _isLoading = true;
  bool get isLoading => _isLoading;

  TextEditingController? _controller;
  TextEditingController? get controller => _controller;

  bool _searchOn = false;

  bool get searchOn => _searchOn;

  void toggleSearchBar() {
    _searchOn = !_searchOn;
    _controller = TextEditingController();
    notifyListeners();
  }

  void searchPokemons(String name) {
    pokemonSearchList.clear();
    for (var pokemon in _pokemonList) {
      final pokeName = pokemon.name ?? '';
      if (pokeName.contains(name)) {
        pokemonSearchList.add(pokemon);
      }
    }

    notifyListeners();
  }

  Future<void> fetchData() async {
    //initLocalRepo
    _localRepository = PokeLocalRepository(boxName: 'pokemon_box');
    await _localRepository.init();
    //fetch Data
    await _fetchPokemonList(10);
    await _fetchPokeLocalList();
    return;
  }

  File readNewImage(Pokemon pokemon) {
    //Update Data
    return File(pokemon.imageLocalPath ?? '');
  }

  Future<void> _fetchPokeLocalList() async {
    try {
      if (_localRepository.connectivityStatus) {
        //add list to local Repo
        _addNewPokemonsToLocalDB();
      } else {
        //get list from local Repo
        _pokemonList = _localRepository.getAll();
        _currentListSize = _pokemonList.length;
      }
    } catch (error) {
      debugPrint(error.toString());
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> _addNewPokemonsToLocalDB() async {
    final localListSize = _localRepository.getAll().length;
    if (localListSize < _currentListSize) {
      await _localRepository.deleteAll();
      await _localRepository.addAll(_pokemonList);
    }
    return Future.value();
  }

  Future<void> _fetchPokemonList(int limit) async {
    try {
      final list = await _repository.getPokemonList(limit);
      _currentListSize = list.length;
      _pokemonList = list;
      _addImagesUrl();
      await fetchPokemonImages();
    } catch (error) {
      debugPrint(error.toString());
    }
    notifyListeners();
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
      final localRepoPokemon = _localRepository.get(pokeListIndex);
      PokemonDetails? details =
          await _repository.getPokemonDetails(pokeListIndex + indexOffSet);

      if (localRepoPokemon != null && details != null) {
        localRepoPokemon.details = details;
        _localRepository.put(
          pokeListIndex,
          localRepoPokemon,
        );
      } else {
        details = localRepoPokemon?.details;
      }
      _pokemonList[pokeListIndex].details = details;
    } catch (error) {
      debugPrint(error.toString());
    }
    notifyListeners();
  }

  void _addImagesUrl() {
    for (var i = 0; i < _pokemonList.length; i++) {
      _pokemonList[i].imageUrl = _getPathString(i);
      _pokemonList[i].keyForDetails = i;
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
      _addNewPokemonsToLocalDB();
      _isLoading = false;
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  int getListLength() {
    if (searchOn) {
      return pokemonSearchList.length;
    } else {
      return pokemonList.length;
    }
  }

  String? getImageLocalPath(int index) {
    String? path;
    path = _pokemonList[index].imageLocalPath;
    return path;
  }

  Widget getPokemonText(int index) {
    String name;
    if (searchOn) {
      name = pokemonSearchList[index].name.toString().toUpperCase();
    } else {
      name = pokemonList[index].name.toString().toUpperCase();
    }
    return Text('${index + indexOffSet} $name');
  }

  Pokemon getCurrentPokemon(int index) {
    Pokemon current;
    if (searchOn) {
      current = pokemonSearchList[index];
    } else {
      current = pokemonList[index];
    }
    return current;
  }

  Future<void> pickFromGallery(Pokemon currentPokemon) async {
    final ImagePicker picker = ImagePicker();
    XFile? pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      File imagenFile = File(pickedFile.path);
      //replace the file on directory
      final currentImagePath = currentPokemon.imageLocalPath;
      File file = File(
        currentImagePath ?? '',
      );
      //save File at path
      await file.writeAsBytes(imagenFile.readAsBytesSync());
    }
    imageFile = readNewImage(currentPokemon);
    notifyListeners();
    return;
  }

  Future<void> changeImage(
    Pokemon currentPokemon,
    ImageSource imageSource,
  ) async {
    final ImagePicker picker = ImagePicker();
    XFile? pickedFile = await picker.pickImage(
      source: imageSource,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      File imagenFile = File(pickedFile.path);
      //replace the file on directory
      final currentImagePath = currentPokemon.imageLocalPath;
      File file = File(
        currentImagePath ?? '',
      );
      //save File at path
      await file.writeAsBytes(imagenFile.readAsBytesSync());
    }
    imageFile = readNewImage(currentPokemon);
    notifyListeners();
    return;
  }
}
