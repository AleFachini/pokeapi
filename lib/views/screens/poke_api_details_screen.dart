import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pokeapi/data/datamodels/poke_api_pokemon.dart';
import 'package:pokeapi/notifiers/poke_api_notifier.dart';
import 'package:pokeapi/views/widgets/poke_api_details_view.dart';
import 'package:provider/provider.dart';

class PokeApiDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> arguments;
  final PokeApiNotifier modelNotifier;

  PokeApiDetailsScreen({
    super.key,
    required this.arguments,
  }) : modelNotifier = arguments.containsKey('notifier')
            ? arguments['notifier'] as PokeApiNotifier
            : PokeApiNotifier();

  @override
  Widget build(BuildContext context) {
    Pokemon current;
    int idx = 0;
    if (arguments.containsKey('pokemon')) {
      current = arguments['pokemon'] as Pokemon;
      idx = current.keyForDetails ?? 0;
    }

    return FutureBuilder<void>(
        future: modelNotifier.fetchPokemonDetails(idx),
        builder: (
          context,
          snapshot,
        ) {
          final pokemon = modelNotifier.pokemonList[idx];
          if (snapshot.connectionState == ConnectionState.done ||
              pokemon.details != null) {
            return Scaffold(
              appBar: AppBar(
                title: Text('${pokemon.name?.toUpperCase()} Details'),
              ),
              body: ChangeNotifierProvider.value(
                  value: modelNotifier,
                  builder: (context, _) {
                    return Center(
                      child: Consumer<PokeApiNotifier>(builder: (
                        context,
                        model,
                        _,
                      ) {
                        String? imagePath = model.getImageLocalPath(
                          (pokemon.keyForDetails ?? 0),
                        );
                        model.imageFile = File(imagePath ?? '');
                        model.imageFile.readAsBytesSync;
                        return PokeApiDetailsView(pokemon: pokemon);
                      }),
                    );
                  }),
            );
          } else if (snapshot.hasError) {
            return const Center(child: Text('No Internet and No local Data'));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }
}
