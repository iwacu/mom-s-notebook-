import 'dart:typed_data';

class Baby {
  final int? id;
  final String picture;
  final String name;
  final String birthDay;
  final String babySex;
  final int premature;
  final String relationship;

  Baby(
      {this.id,
      required this.picture,
      required this.name,
      required this.birthDay,
      required this.babySex,
      required this.premature,
      required this.relationship});

  factory Baby.fromMap(Map<String, dynamic> json) => new Baby(
        id: json['id'],
        picture: json['picture'],
        name: json['name'],
        birthDay: json['birthDay'],
        babySex: json['sex'],
        premature: json['premature'],
        relationship: json['relationship'],
      );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'picture': picture,
      'name': name,
      'birthDay': birthDay,
      'sex': babySex,
      'premature': premature,
      'relationship': relationship,
    };
  }
}
