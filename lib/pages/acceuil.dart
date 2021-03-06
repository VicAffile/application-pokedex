import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:developer' as developer;

import 'package:application_pokedex/pages/fiche.dart';
import 'package:application_pokedex/classes/carte.dart';
import 'package:application_pokedex/classes/type.dart';

class Acceuil extends StatefulWidget {
  const Acceuil({Key? key}) : super(key: key);

  @override
  _AcceuilState createState() => _AcceuilState();
}

class _AcceuilState extends State<Acceuil> {TextEditingController tecMessage = TextEditingController();
  final StreamController<List<Carte>> _streamCtrmerPkms = StreamController();

  @override
  void initState() {
    _telechargerPokemons();
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
              return Center(
                  child: const CircularProgressIndicator(),
              );
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

  Widget _construireListe(Carte pokemon) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Card(
        child: InkWell(
          onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=> Fiche(pokemon.nom_fr))),
          child: ListTile(
            leading: Image.network("https://backend-pokedex-vic-affile.herokuapp.com/" + pokemon.nom_fr + "/mignature"),
            title: Text("N°" + pokemon.numero + " - " + pokemon.nom_fr),
            subtitle: _afficherTypes(pokemon),
          ),
        ),
      ),
    );
  }

  void _telechargerPokemons() {
    Future<http.Response> reponsePokemons = http.get(
      Uri.parse("https://backend-pokedex-vic-affile.herokuapp.com"),
    );

    reponsePokemons.then((value) {
      if (value.statusCode == 200) {
        List<dynamic> listePokemonsJson = jsonDecode(value.body);
        List<Carte> listePokemons = <Carte>[];
        for (var pokemon in listePokemonsJson) {
          listePokemons.add(Carte.fromJson(pokemon as Map<String, dynamic>));
        }
        _streamCtrmerPkms.sink.add(listePokemons);
      }
    },
      onError: (var err) => developer.log(err.toString()),
    );
  }

  Widget _afficherTypes(Carte pokemon) {
    if (pokemon.type.length != 1) {
      return Row(
        children: [
          Image.network("https://backend-pokedex-vic-affile.herokuapp.com/types/" + pokemon.type[0] + "/image", width: 67.5, height: 15),
          const Text(" / "),
          Image.network("https://backend-pokedex-vic-affile.herokuapp.com/types/" + pokemon.type[1] + "/image", width: 67.5, height: 15),
        ],
      );
    }
    return Row(
      children: [
        Image.network("https://backend-pokedex-vic-affile.herokuapp.com/types/" + pokemon.type[0] + "/image", width: 67.5, height: 15),
      ],
    );
  }
}

