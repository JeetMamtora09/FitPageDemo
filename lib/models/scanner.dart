import 'package:fitpagedemo/models/criteria.dart';
import 'package:flutter/material.dart';

class Scanner {
  final int id;
  final String name;
  final String tag;
  final Color color;
  final List<Criteria> criteria;

  Scanner._init(
      {required this.id,
      required this.name,
      required this.tag,
      required this.color,
      required this.criteria});

  factory Scanner.fromJson(Map<String, dynamic> response) {
    final color = (response["color"] as String).color;
    final List<dynamic> list = response["criteria"];
    final List<Criteria> criteriaList = [];
    int variableIndex = 1;
    for (var element in list) {
      criteriaList.add(Criteria.init(element,variableIndex,(){
        variableIndex++;
      }));
    }
    return Scanner._init(
        id: response["id"] as int,
        name: response["name"] as String,
        tag: response["tag"] as String,
        color: color,
        criteria: criteriaList);
  }

  @override
  String toString() {
    return 'Scanner{id: $id, name: $name, tag: $tag, color: $color, criteria: $criteria}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Scanner &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          tag == other.tag &&
          color == other.color &&
          criteria == other.criteria;

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      tag.hashCode ^
      color.hashCode ^
      criteria.hashCode;
}

extension ColorGetterExt on String {
  Color get color {
    switch (this) {
      case "green":
        return Colors.green;
      case "red":
        return Colors.red;
      default:
        throw FlutterError("The color is not been added");
    }
  }
}
