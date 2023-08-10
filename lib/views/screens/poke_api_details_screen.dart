import 'package:flutter/material.dart';
import 'package:pokeapi/notifiers/poke_api_notifier.dart';
import 'package:pokeapi/views/widgets/poke_api_details_view.dart';

class PokeApiDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> arguments;
  late PokeApiNotifier modelNotifier;

  PokeApiDetailsScreen({
    super.key,
    required this.arguments,
  }) : modelNotifier = arguments.containsKey('notifier')
            ? arguments['notifier'] as PokeApiNotifier
            : PokeApiNotifier();

  @override
  Widget build(BuildContext context) {
    int idx = 0;
    if (arguments.containsKey('pokemonIndex')) {
      idx = arguments['pokemonIndex'] as int;
    }

    return FutureBuilder<void>(
        future: modelNotifier.fetchPokemonDetails(idx),
        builder: (
          context,
          snapshot,
        ) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Scaffold(
              appBar: AppBar(
                title: Text(
                    '${modelNotifier.pokemonList[idx].name?.toUpperCase()} Details'),
              ),
              body: Center(
                child:
                    PokeApiDetailsView(pokemon: modelNotifier.pokemonList[idx]),
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }
}
