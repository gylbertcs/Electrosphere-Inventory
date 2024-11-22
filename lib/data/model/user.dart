class User {
  User({
    this.idUser,
    this.name,
    this.email,
    this.level,
    this.createdAt,
    this.updatedAt,
  });

  int? idUser;
  String? name;
  String? email;
  String? level;
  String? createdAt;
  String? updatedAt;

  factory User.fromJson(Map<String, dynamic> json) => User(
        idUser: json["id_user"] != null ? int.parse(json["id_user"].toString()) : null,
        name: json["name"],
        email: json["email"],
        level: json["level"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id_user": idUser,
        "name": name,
        "email": email,
        "level": level,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
