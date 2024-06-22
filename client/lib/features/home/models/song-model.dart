// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

// ignore_for_file: non_constant_identifier_names

class SongModel {
  String id;
  String song_name;
  String thumbnail_url;
  String song_url;
  String artist;
  String hex_color;
  String userId;

  SongModel({
    required this.id,
    required this.song_name,
    required this.thumbnail_url,
    required this.song_url,
    required this.artist,
    required this.hex_color,
    required this.userId,
  });

  SongModel copyWith({
    String? id,
    String? song_name,
    String? thumbnail_url,
    String? song_url,
    String? artist,
    String? hex_color,
    String? userId,
  }) {
    return SongModel(
      id: id ?? this.id,
      song_name: song_name ?? this.song_name,
      thumbnail_url: thumbnail_url ?? this.thumbnail_url,
      song_url: song_url ?? this.song_url,
      artist: artist ?? this.artist,
      hex_color: hex_color ?? this.hex_color,
      userId: userId ?? this.userId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'song_name': song_name,
      'thumbnail_url': thumbnail_url,
      'song_url': song_url,
      'artist': artist,
      'hex_color': hex_color,
      'userId': userId,
    };
  }

  factory SongModel.fromMap(Map<String, dynamic> map) {
    return SongModel(
      id: map['id'] as String,
      song_name: map['song_name'] as String,
      thumbnail_url: map['thumbnail_url'] as String,
      song_url: map['song_url'] as String,
      artist: map['artist'] as String,
      hex_color: map['hex_color'] as String,
      userId: map['userId'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory SongModel.fromJson(String source) => SongModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'SongModel(id: $id, song_name: $song_name, thumbnail_url: $thumbnail_url, song_url: $song_url, artist: $artist, hex_color: $hex_color, userId: $userId)';
  }

  @override
  bool operator ==(covariant SongModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.song_name == song_name &&
      other.thumbnail_url == thumbnail_url &&
      other.song_url == song_url &&
      other.artist == artist &&
      other.hex_color == hex_color &&
      other.userId == userId;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      song_name.hashCode ^
      thumbnail_url.hashCode ^
      song_url.hashCode ^
      artist.hashCode ^
      hex_color.hashCode ^
      userId.hashCode;
  }
}
