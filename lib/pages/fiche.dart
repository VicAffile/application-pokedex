import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Fiche extends StatefulWidget {
  String nom;

  Fiche(this.nom, {Key? key}) : super(key: key);

  @override
  _FicheState createState() => _FicheState();
}

class _FicheState extends State<Fiche> {
  final StreamController<Fiche> _streamCtrmerPokemon = StreamController();

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
    );
  }

  void _telechargerPokemon(String nom) {}
}
