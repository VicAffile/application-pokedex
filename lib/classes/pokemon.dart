import 'dart:ffi';

class Pokemon {
  final String numero;
  final String nom_fr;
  final String nom_jap;
  final List<dynamic> type;
  final String categorie;
  final String description;

  Pokemon.fromJson(Map<String, dynamic> json) :
        numero = json['numero'],
        nom_fr = json['nom_fr'],
        nom_jap = json['nom_jap'],
        type = json["type"],
        categorie = json["categorie"],
        description = json["description"];

  Map<String, dynamic> toJson() => {
    'numero': numero,
    'nom_fr': nom_fr,
    'nom_jap': nom_jap,
    "type": type,
    "categorie": categorie,
    "description": description,
  };
}