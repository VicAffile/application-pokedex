import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:developer' as developer;

import 'package:application_pokedex/classes/carte.dart';

class Acceuil extends StatefulWidget {
  const Acceuil({Key? key}) : super(key: key);

  @override
  _AcceuilState createState() => _AcceuilState();
}

class _AcceuilState extends State<Acceuil> {TextEditingController tecMessage = TextEditingController();
  final StreamController<List<Carte>> _streamCtrmerPkms = StreamController();

  @override
  void initState() {
    _downloadPkms();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pokédex"),
        actions: [],
      ),
      body: StreamBuilder<List<Carte>>(
          stream: _streamCtrmerPkms.stream,
          builder: (context, snapshot) {
            if(snapshot.hasError){
              return Icon(Icons.warning);
            }
            if (!snapshot.hasData) {
              return const CircularProgressIndicator();
            } else {
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (BuildContext context, int index) => _construireListe(snapshot.data![index]),
                    ),
                  ),
                ],
              );
            }
          }),
    );
  }

  Widget _construireListe(Carte carte) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Card(
        child: InkWell(
          child: ListTile(
            title: Text(carte.numero + " - " + carte.nom),
            subtitle: Text(_afficherTypes(carte)),
          ),
        ),
      ),
    );
  }

  void _downloadPkms() {
    Future<http.Response> responsePokemons = http.get(
      Uri.parse("https://backend-pokedex-vic-affile.herokuapp.com"),
    );

    responsePokemons.then((value) {
      if (value.statusCode == 200) {
        List<dynamic> listePokemonsJson = jsonDecode(value.body);
        List<Carte> listePokemons = <Carte>[];
        for (var pokemon in listePokemonsJson) {
          pokemon['type'].add("Aucun");
          listePokemons.add(Carte.fromJson(pokemon as Map<String, dynamic>));
        }
        _streamCtrmerPkms.sink.add(listePokemons);
      }
    },
      onError: (var err) => developer.log(err.toString()),
    );
  }

  String _afficherTypes(Carte carte) {
    if (carte.type_2 != "Aucun") {
      return carte.type_1 + " - " + carte.type_2;
    }
    return carte.type_1;
  }
}

