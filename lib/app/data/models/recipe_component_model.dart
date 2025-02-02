import 'package:enum_to_string/enum_to_string.dart';

import 'item_model.dart';

class RecipeComponent {
  late Item item;
  int? amount;

  RecipeComponent({
    required this.item,
    this.amount,
  });

  RecipeComponent.fromJson(Map<String, dynamic> json) {
    item = Item.fromJson(json['item']);
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = item.toString();
    data['amount'] = amount;
    return data;
  }

  static List<RecipeComponent> fromJsonList(List? data) {
    if (data == null || data.isEmpty) return [];
    return data.map((e) => RecipeComponent.fromJson(e)).toList();
  }
}
