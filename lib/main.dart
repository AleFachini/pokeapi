import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pokeapi/views/screens/poke_api_list_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //Move this to Repository Init for production, maybe
  //get.it serviceLocator could be Used
  Directory documentDirectory = await getApplicationDocumentsDirectory();
  Hive.init(documentDirectory.path); // Initialize Hive
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pokemon List',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const PokeApiListScreen(),
    );
  }
}
