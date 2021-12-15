import 'dart:ffi';

class Carte {
  final String numero;
  final String nom_fr;
  final String nom_jap;
  final String type_1;
  final String type_2;

  Carte.fromJson(Map<String, dynamic> json) :
        numero = json['numero'],
        nom_fr = json['nom_fr'],
        nom_jap = json['nom_jap'],
        type_1 = json["type"][0],
        type_2 = json["type"][1];

  Map<String, dynamic> toJson() => {
    'numero': numero,
    'nom_fr': nom_fr,
    'nom_jap': nom_jap,
    "type_1": type_1,
    "type_2": type_2,
  };
}