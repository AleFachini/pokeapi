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
            if (model.currentListSize >= 0 && !model.isLoading) {
              return Scaffold(
                appBar: AppBar(
                  backgroundColor: Theme.of(context).colorScheme.inversePrimary,
                  title: const Text('Poke Api'),
                  actions: [
                    IconButton(
                      onPressed: () {
                        model.toggleSearchBar();
                      },
                      icon: const Icon(Icons.search),
                    )
                  ],
                  bottom: _searchBar(model),
                ),
                body: model.currentListSize == 0
                    ? const Center(
                        child: Text('No local Data'),
                      )
                    : Center(
                        child: ListView.separated(
                          itemCount: model.getListLength(),
                          itemBuilder: (_, index) {
                            String? imagePath = model.getImageLocalPath(
                              model.getCurrentPokemon(index).keyForDetails ?? 0,
                            );
                            return ListTile(
                              title: model.getPokemonText(index),
                              leading: Image.file(File(imagePath ?? '')),
                              trailing: IconButton(
                                onPressed: () async {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          PokeApiDetailsScreen(
                                        //TO-DO: Extract arguments Key to a single file for clean code
                                        arguments: {
                                          //Important: while the List index is dynamic the keyForDetails
                                          //is Fixed for each Pokemon
                                          'pokemon':
                                              model.getCurrentPokemon(index),
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

  PreferredSize _searchBar(PokeApiNotifier model) {
    return PreferredSize(
      preferredSize: Size.fromHeight(model.searchOn ? 80 : 0),
      child: model.searchOn
          ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: model.controller,
                      decoration: InputDecoration(
                        hintText: 'Search...',
                        // Add a clear button to the search bar
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            model.controller?.clear();
                          },
                        ),
                        // Add a search icon or button to the search bar
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                      onChanged: (value) {
                        model.searchPokemons(value);
                      },
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.send),
                    onPressed: () {
                      // Perform the search here
                      model.searchPokemons(model.controller?.text ?? '');
                    },
                  ),
                ],
              ),
            )
          : Container(),
    );
  }

  PokeApiNotifier _buildNotifier() {
    return PokeApiNotifier();
  }
}
