import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pokeapi/data/datamodels/poke_api_pokemon.dart';
import 'package:pokeapi/notifiers/poke_api_notifier.dart';
import 'package:provider/provider.dart';

class PokeApiDetailsView extends StatelessWidget {
  final Pokemon pokemon;
  const PokeApiDetailsView({
    Key? key,
    required this.pokemon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<PokeApiNotifier>(context);
    final screenSize = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: [
          GestureDetector(
            onLongPress: () {
              debugPrint('Testing longPress');
              model.changeImage(pokemon, ImageSource.gallery);
            },
            onDoubleTap: () {
              debugPrint('Testing Double Tap');
              model.changeImage(pokemon, ImageSource.camera);
            },
            child: SizedBox(
              height: screenSize.height * 0.30,
              width: screenSize.width * 0.30,
              child: Image.memory(
                model.imageFile.readAsBytesSync(),
              ),
            ),
          ),
          const Text(
            'Long Press Image to change Image\nDouble Tap to take Picture.',
            style: TextStyle(
              fontStyle: FontStyle.italic,
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
      itemCount: pokemon.details?.abilities.length ?? 0,
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
      itemCount: pokemon.details?.moves.length ?? 0,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text('${pokemon.details?.moves[index].move.name}'),
        );
      },
    );
  }
}
