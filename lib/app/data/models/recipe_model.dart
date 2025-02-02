import 'package:supabase_notes/app/data/models/recipe_component_model.dart';

import 'building_model.dart';

class Recipe {
  late int id;
  late String recipeName;
  late int craftedIn;
  double? energyConsumption;
  double? minimumEnergyConsumption;
  int? craftingTableHits;
  int? craftingTimeSeconds;
  late List<RecipeComponent> ingredients;
  late List<RecipeComponent> products;

  Recipe({
    required this.id,
    required this.recipeName,
    required this.craftedIn,
    this.energyConsumption,
    this.minimumEnergyConsumption,
    this.craftingTableHits,
    this.craftingTimeSeconds,
    required this.ingredients,
    required this.products,
  });

  Recipe.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    recipeName = json['recipeName'];
    craftedIn = json['craftedIn'];
    energyConsumption = json['energyConsumption'] != null ? double.parse(json['energyConsumption'].toString()) : null;
    minimumEnergyConsumption = json['minimumEnergyConsumption'] != null ? double.parse(json['minimumEnergyConsumption'].toString()) : null;
    craftingTableHits = json['craftingTableHits'];
    craftingTimeSeconds = json['craftingTimeSeconds'];
    ingredients = RecipeComponent.fromJsonList(json['RecipeIngredients']);
    products = RecipeComponent.fromJsonList(json['RecipeProducts']);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['recipe_name'] = recipeName;
    data['crafted_in'] = craftedIn;
    data['energy_consumption'] = energyConsumption;
    data['minimum_energy_consumption'] = minimumEnergyConsumption;
    data['crafting_table_hits'] = craftingTableHits;
    data['crafting_time_seconds'] = craftingTimeSeconds;
    data['RecipeIngredients'] = ingredients.map((i) => i.toJson()).toList();
    data['RecipeProducts'] = products.map((p) => p.toJson()).toList();
    return data;
  }

  static List<Recipe> fromJsonList(List? data) {
    if (data == null || data.isEmpty) return [];
    return data.map((e) => Recipe.fromJson(e)).toList();
  }
}
