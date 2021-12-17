class Type {
  final String nom;
  final String image;

  Type(this.nom, this.image);

  Type.fromJson(Map<String, dynamic> json) :
        nom = json['nom'],
        image = json['image'];

  Map<String, dynamic> toJson() => {
    'nom': nom,
    'image': image,
  };
}