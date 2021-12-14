import 'dart:ffi';

class Carte {
  final String numero;
  final String nom;
  final String type_1;
  final String type_2;

  Carte.fromJson(Map<String, dynamic> json) :
        numero = json['numero'],
        nom = json['nom'],
        type_1 = json["type"][0],
        type_2 = json["type"][1];

  Map<String, dynamic> toJson() => {
    'numero': numero,
    'nom': nom,
    "type_1": type_1,
    "type_2": type_2,
  };
}