class User {
  final int? id;
  final String name;
  final int babyId;

  User({this.id, required this.name, required this.babyId});

  factory User.fromMap(Map<String, dynamic> json) =>
      new User(id: json['id'], name: json['name'], babyId: json['baby_id']);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'baby_id': babyId,
    };
  }
}
