// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import 'package:hive/hive.dart';

@HiveType(typeId: 0)
class NotesPad extends HiveObject {
  @HiveField(0)
  String title;
  @HiveField(1)
  String description;
  NotesPad({
    required this.title,
    required this.description,
  });
  
  
  

  NotesPad copyWith({
    String? title,
    String? description,
  }) {
    return NotesPad(
      title: title ?? this.title,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'description': description,
    };
  }

  factory NotesPad.fromMap(Map<String, dynamic> map) {
    return NotesPad(
      title: map['title'] as String,
      description: map['description'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory NotesPad.fromJson(String source) => NotesPad.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'NotesPad(title: $title, description: $description)';

  @override
  bool operator ==(covariant NotesPad other) {
    if (identical(this, other)) return true;
  
    return 
      other.title == title &&
      other.description == description;
  }

  @override
  int get hashCode => title.hashCode ^ description.hashCode;
}
