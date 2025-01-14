
import 'dart:convert';
import 'package:get/get.dart';

String filterModelToJson(List<FilterModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FilterModel {
  String name;
  String key;
  List<Option> options;
  RxMap<int, Option> selectedOptions;

  FilterModel({
    required this.name,
    required this.key,
    required this.options,
    required this.selectedOptions,
  });

  Map<String, dynamic> toJson() => {
    "name": name,
    "key": key,
    "options": List<dynamic>.from(options.map((x) => x.toJson())),
    "selectedOptions": selectedOptions.map((k, v) => MapEntry(k.toString(), v.toJson())),
  };
}

List<Option> filterOptionsFromJson(String str, String nameKey) => List<Option>.from(json.decode(str).map((x) => Option.fromJson(x, nameKey)));

class Option {
  int id;
  String name;
  double? min; 
  double? max;

  Option({
    required this.id,
    required this.name,
    this.min,
    this.max,
  });

  factory Option.fromJson(Map<String, dynamic> json, String namekey) => Option(
    id: json["id"],
    name: json[namekey],
    min: json.containsKey("min") ? json["min"].toDouble() : null,
    max: json.containsKey("max") ? json["max"].toDouble() : null,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    if (min != null) "min": min,
    if (max != null) "max": max,
  };
}
