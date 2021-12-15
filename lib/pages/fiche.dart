import 'dart:async';
import 'dart:convert';

import 'package:application_pokedex/classes/pokemon.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:developer' as developer;

class Fiche extends StatefulWidget {
  String nom;

  Fiche(this.nom, {Key? key}) : super(key: key);

  @override
  _FicheState createState() => _FicheState();
}

class _FicheState extends State<Fiche> {
  final StreamController<Pokemon> _streamCtrmerPokemon = StreamController();

  @override
  void initState() {
    _telechargerPokemon(widget.nom);
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Fiche de " + widget.nom),
        actions: [],
      ),
      body: StreamBuilder<Pokemon>(
          stream: _streamCtrmerPokemon.stream,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Icon(Icons.warning);
            }
            if (!snapshot.hasData) {
              return const CircularProgressIndicator();
            } else {
              return Column(
                children: [
                  Text(snapshot.data!.nom_fr),
                  Text(snapshot.data!.description),
                ],
              );
            }
          }
      ),
    );
  }

  void _telechargerPokemon(String nom) {
    Future<http.Response> responseLogement = http.get(
      Uri.parse("https://backend-pokedex-vic-affile.herokuapp.com/" + nom),
    );

    responseLogement.then((value) {
      if (value.statusCode == 200) {
        Pokemon pokemon = Pokemon.fromJson(jsonDecode(value.body)[0] as Map<String, dynamic>);
        _streamCtrmerPokemon.sink.add(pokemon);
      }
    },
      onError: (var err) => developer.log(err.toString()),
    );
  }
}
