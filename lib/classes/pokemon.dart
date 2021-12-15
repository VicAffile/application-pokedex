import 'dart:ffi';

class Pokemon {
  final String numero;
  final String nom_fr;
  final String nom_jap;
  final List<dynamic> type;
  final String categorie;
  final String taille;
  final String poids;
  final String description;

  Pokemon.fromJson(Map<String, dynamic> json) :
        numero = json['numero'],
        nom_fr = json['nom_fr'],
        nom_jap = json['nom_jap'],
        type = json["type"],
        categorie = json["categorie"],
        taille = json["taille"],
        poids = json["poids"],
        description = json["description"];

  Map<String, dynamic> toJson() => {
    'numero': numero,
    'nom_fr': nom_fr,
    'nom_jap': nom_jap,
    "type": type,
    "categorie": categorie,
    "taille": taille,
    "poids": poids,
    "description": description,
  };
}