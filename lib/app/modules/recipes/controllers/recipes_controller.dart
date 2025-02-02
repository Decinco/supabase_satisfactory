import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:supabase_notes/app/data/models/building_model.dart';

import '../../../data/models/recipe_model.dart';

class RecipesController extends GetxController {
  RxList itemRecipes = List<Recipe>.empty().obs;
  RxList itemUsages = List<Recipe>.empty().obs;
  SupabaseClient client = Supabase.instance.client;

  Future<void> getItemRecipes(int itemId) async {
    var recipes = await client.from("Recipes")
        .select('*, filter:RecipeProducts!inner(*), RecipeIngredients(item:Items(*), amount), RecipeProducts(item:Items(*), amount)')
        .eq('filter.item', itemId)
        .order('id', ascending: true);
    List<Recipe> recipesData = Recipe.fromJsonList((recipes as List));
    itemRecipes(recipesData);
    itemRecipes.refresh();
  }

  Future<void> getItemUsages(int itemId) async {
    var recipes = await client.from("Recipes")
        .select('*, filter:RecipeIngredients!inner(*), RecipeIngredients(item:Items(*), amount), RecipeProducts(item:Items(*), amount)')
        .eq('filter.item', itemId)
        .order('id', ascending: true);
    List<Recipe> recipesData = Recipe.fromJsonList((recipes as List));
    itemUsages(recipesData);
    itemUsages.refresh();
  }

  Future<Building> getRecipeBuilding(int buildingId) async {
    var recipe = await client.from("Buildings")
        .select()
        .eq('id', buildingId)
        .single();
    Building recipeData = Building.fromJson(recipe);
    return recipeData;
  }

  Future<String> getImageUrl(String filename) async {
    return await client
        .storage
        .from('satisfactoryItems')
        .getPublicUrl(filename);
  }
}