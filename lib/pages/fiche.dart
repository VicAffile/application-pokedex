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
              return Center(
                  child: const CircularProgressIndicator(),
              );
            } else {
              return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text("N°" + snapshot.data!.numero),
                          const Spacer(),
                          Text(snapshot.data!.nom_fr + " (" + snapshot.data!.nom_jap + ")"),
                        ]
                      ),
                      Image.network("https://backend-pokedex-vic-affile.herokuapp.com/" + snapshot.data!.nom_fr + "/sprite"),
                      Text(snapshot.data!.categorie),
                      Text(_afficherTypes(snapshot.data!.type)),
                      Row(
                        children: [
                          const Spacer(),
                          Text("Taille : " + snapshot.data!.taille),
                          const Spacer(),
                          Text("/"),
                          const Spacer(),
                          Text("Poids : " + snapshot.data!.poids),
                          const Spacer(),
                        ],
                      ),
                      Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("Description :"),
                              Text(snapshot.data!.description, textAlign: TextAlign.justify,),
                            ],
                          ),
                      ),
                    ],
                  ),
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

  String _afficherTypes(List<dynamic> type) {
    if (type.length == 2) {
      return type[0] + " / " + type[1];
    }
    return type[0];
  }
}
