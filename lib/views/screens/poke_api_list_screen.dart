import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pokeapi/notifiers/poke_api_notifier.dart';
import 'package:provider/provider.dart';

import 'poke_api_details_screen.dart';

class PokeApiListScreen extends StatelessWidget {
  const PokeApiListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<PokeApiNotifier>(
        create: (context) => _buildNotifier()..fetchData(),
        builder: (context, _) {
          return Consumer<PokeApiNotifier>(builder: (
            context,
            model,
            _,
          ) {
            if (model.currentListSize > 0 && !model.isLoading) {
              return Scaffold(
                appBar: AppBar(
                  backgroundColor: Theme.of(context).colorScheme.inversePrimary,
                  title: const Text('Poke Api'),
                ),
                body: Center(
                  child: ListView.separated(
                    itemBuilder: (_, index) {
                      String? imagePath =
                          model.pokemonList[index].imageLocalPath;
                      return ListTile(
                        title: Text(
                            //TO-DO: Add index offset as a Constant
                            '${index + 1} ${model.pokemonList[index].name.toString().toUpperCase()}'),
                        leading: Image.file(File(imagePath ?? '')),
                        trailing: IconButton(
                          onPressed: () async {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PokeApiDetailsScreen(
                                  //TO-DO: Extract arguments Key to a single file for clean code
                                  arguments: {
                                    'pokemonIndex': index,
                                    'notifier': model,
                                  },
                                ),
                              ),
                            );
                          },
                          icon: const Icon(Icons.arrow_forward_ios),
                        ),
                      );
                    },
                    separatorBuilder: (_, __) {
                      return const Divider();
                    },
                    itemCount: model.pokemonList.length,
                  ),
                ),
                floatingActionButton: FloatingActionButton(
                  onPressed: () {
                    model.fetchMorePokemon();
                    debugPrint('FAB BUTTON');
                  },
                  tooltip: 'List more Pokemons',
                  child: const Icon(Icons.add),
                ),
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          });
        });
  }

  PokeApiNotifier _buildNotifier() {
    return PokeApiNotifier();
  }
}
