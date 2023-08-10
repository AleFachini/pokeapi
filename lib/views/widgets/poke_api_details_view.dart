import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pokeapi/datamodels/poke_api_pokemon.dart';

class PokeApiDetailsView extends StatelessWidget {
  final Pokemon pokemon;
  const PokeApiDetailsView({
    Key? key,
    required this.pokemon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: screenSize.height * 0.30,
            width: screenSize.width * 0.30,
            child: Image.file(
              File(pokemon.imageLocalPath ?? ''),
            ),
          ),
          const Divider(),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Abilities',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          _abilitiesList(),
          const Divider(),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Moves',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          _moveList(),
          const Divider(),
        ],
      ),
    );
  }

  Widget _abilitiesList() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: pokemon.details?.abilities.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text('${pokemon.details?.abilities[index].ability.name}'),
        );
      },
    );
  }

  Widget _moveList() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: pokemon.details?.moves.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text('${pokemon.details?.moves[index].move.name}'),
        );
      },
    );
  }
}
