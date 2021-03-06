class Carte {
  final String numero;
  final String nom_fr;
  final String nom_jap;
  final List<dynamic> type;

  Carte.fromJson(Map<String, dynamic> json) :
        numero = json['numero'],
        nom_fr = json['nom_fr'],
        nom_jap = json['nom_jap'],
        type = json["type"];

  Map<String, dynamic> toJson() => {
    'numero': numero,
    'nom_fr': nom_fr,
    'nom_jap': nom_jap,
    "type": type,
  };
}