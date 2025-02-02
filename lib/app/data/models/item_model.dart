import 'package:enum_to_string/enum_to_string.dart';

enum ItemType {
  Solid,
  Liquid,
  Gas
}

class Item {
  late int id;
  late String name;
  int? sinkValue;
  int? powerValue;
  late ItemType type;
  String? itemImage;
  String? description;

  Item({required this.id, required this.name, this.sinkValue, this.powerValue, required this.type, this.itemImage, this.description});

  Item.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    sinkValue = json['sinkValue'];
    powerValue = json['powerValue'];
    type = EnumToString.fromString(ItemType.values, json['type'])!;
    itemImage = json['itemImage'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['sinkValue'] = sinkValue;
    data['powerValue'] = powerValue;
    data['type'] = type;
    data['itemImage'] = itemImage;
    data['description'] = description;
    return data;
  }

  static List<Item> fromJsonList(List? data) {
    if (data == null || data.isEmpty) return [];
    return data.map((e) => Item.fromJson(e)).toList();
  }
}
