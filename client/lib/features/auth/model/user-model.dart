// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:nightAngle/features/home/models/fav-song-model.dart';

class UserModel {
  String id;
  String name;
  String email;
  String? token;
  List<FavSongModel> favorites;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.token,
    required this.favorites,
  });

  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    String? token,
    List<FavSongModel>? favorites,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      token: token ?? this.token,
      favorites: favorites ?? this.favorites,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'email': email,
      'token': token,
      'favorites': favorites.map((x) => x.toMap()).toList(),
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
      token: map['token'] != null ? map['token'] as String : null,
      favorites: List<FavSongModel>.from(map['favorites']
              ?.map((x) => FavSongModel.fromMap(x as Map<String, dynamic>))
          as Iterable),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(id: $id, name: $name, email: $email, token: $token, favorites: $favorites)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.email == email &&
        other.token == token;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ email.hashCode ^ token.hashCode;
  }
}
