import 'package:expandable_widgets/expandable_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_notes/app/routes/app_pages.dart';
import 'package:supabase_notes/uicon.dart';

import '../../../data/models/building_model.dart';
import '../../../data/models/item_model.dart';
import '../../../data/models/recipe_model.dart';
import '../controllers/recipes_controller.dart';

class RecipesView extends GetView<RecipesController> {
  final Item item = Get.arguments;
  bool isExpanded = false;

  RecipesView({super.key});

  Widget itemWidget() {
    return Stack(children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          itemLeading(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                item.description ?? "NO DESCRIPTION",
                style: TextStyle(
                  fontSize: 13,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          )
        ],
      ),
      Positioned(
        right: 10,
        child: IconButton(
          icon: Icon(UIcons.fibspencil, color: Colors.deepOrange),
          onPressed: () {
            Get.toNamed(Routes.EDIT_ITEM, arguments: item);
          },
        ),
      ),
    ]);
  }

  Widget itemLeading() {
    double radius = item.type == ItemType.Solid ? 5 : 60;

    return FutureBuilder(
      future:
          controller.getImageUrl(item.itemImage ?? "ResIcon_Walls_Dark.png"),
      builder: (context, snapshot) {
        return Padding(
          padding: EdgeInsets.all(10),
          child: Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              color: Color.fromARGB(100, 170, 170, 170),
              borderRadius: BorderRadius.circular(radius),
            ),
            child: Padding(
              padding: EdgeInsets.all(5),
              child: Image.network(snapshot.data ??
                  "https://ztbjgzaxhmcadkthnuxl.supabase.co/storage/v1/object/public/satisfactoryItems//ResIcon_Walls_Dark.png"),
            ),
          ),
        );
      },
    );
  }

  Widget? recipeWidget(Recipe recipe) {
    return FutureBuilder(
        future: controller.getRecipeBuilding(recipe.craftedIn),
        builder: (context, snapshot) {
          return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(10, 5, 0, 0),
                          child: Text(
                            recipe.recipeName,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                          child: Text(
                            "Using ${snapshot.data?.buildingName}",
                            style: TextStyle(
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        )
                      ],
                    ),
                    Padding(
                        padding: EdgeInsets.fromLTRB(0, 10, 10, 0),
                        child: Column(children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Icon(UIcons.fibsclock),
                              Text("${recipe.craftingTimeSeconds}s"),
                              recipe.craftingTableHits != null
                                  ? Icon(UIcons.fibshammer) : Icon(UIcons.fibsmodule),
                              Text(recipe.craftingTableHits != null
                                  ? "${recipe.craftingTableHits} hits"
                                  : ""),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Icon(UIcons.fibsbolt),
                              Text(
                                  "${recipe.minimumEnergyConsumption != null || snapshot.data?.minimumEnergyConsumption != null ? "${recipe.minimumEnergyConsumption ?? snapshot.data?.minimumEnergyConsumption} - " : ""}${recipe.energyConsumption ?? snapshot.data?.energyConsumption} MW"),
                            ],
                          ),
                        ]))
                  ],
                ),
                recipe.ingredients.isEmpty
                    ? Padding(
                        padding: EdgeInsets.all(20),
                        child: SizedBox(
                            width: double.infinity,
                            height: 40,
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                "Unlimited power!",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            )))
                    : ListView.builder(
                        shrinkWrap: true,
                        itemCount: recipe.ingredients.length,
                        itemBuilder: (context, index) {
                          return Stack(children: [
                            Row(children: [
                              recipeItemLeading(recipe.ingredients[index].item,
                                  recipe.ingredients[index].amount!),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    recipe.ingredients[index].item.name,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                  Text(
                                      "${recipe.ingredients[index].amount! * 60 / recipe.craftingTimeSeconds!.toDouble()}/min"),
                                ],
                              ),
                            ]),
                          ]);
                        }),
                Center(
                    child:
                        Icon(UIcons.fibsarrowdown, color: Colors.deepOrange)),
                recipe.products.isEmpty
                    ? Padding(
                        padding: EdgeInsets.all(20),
                        child: SizedBox(
                          width: double.infinity,
                          height: 40,
                          child: Text(
                            "This makes... Nothing?!",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ))
                    : ListView.builder(
                        shrinkWrap: true,
                        itemCount: recipe.products.length,
                        itemBuilder: (context, index) {
                          return Stack(children: [
                            Row(children: [
                              recipeItemLeading(recipe.products[index].item,
                                  recipe.products[index].amount!),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    recipe.products[index].item.name,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                  Text(
                                      "${recipe.products[index].amount! * 60 / recipe.craftingTimeSeconds!.toDouble()}/min"),
                                ],
                              ),
                            ]),
                          ]);
                        }),
              ]);
        });
  }

  Widget recipeItemLeading(Item recipeItem, int amount) {
    double radius = recipeItem.type == ItemType.Solid ? 5 : 60;

    return FutureBuilder(
      future: controller
          .getImageUrl(recipeItem.itemImage ?? "ResIcon_Walls_Dark.png"),
      builder: (context, snapshot) {
        return Stack(children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                color: Color.fromARGB(100, 170, 170, 170),
                borderRadius: BorderRadius.circular(radius),
              ),
              child: Padding(
                padding: EdgeInsets.all(5),
                child: Image.network(snapshot.data ??
                    "https://ztbjgzaxhmcadkthnuxl.supabase.co/storage/v1/object/public/satisfactoryItems//ResIcon_Walls_Dark.png"),
              ),
            ),
          ),
          Positioned(
              left: 60 - (7.2 * ("$amount".length - 1)),
              top: 52,
              child: Container(
                  decoration: BoxDecoration(
                    color: Colors.lightBlue,
                    borderRadius: BorderRadius.circular(2),
                  ),
                  alignment: Alignment.bottomRight,
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(3, 2, 3, 2),
                      child: Text(
                        "$amount",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  )))
        ]);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    controller.getItemRecipes(item.id);
    controller.getItemUsages(item.id);

    return Scaffold(
        appBar: AppBar(
          title: Text(
            item.name,
            style: TextStyle(
                color: Colors.deepOrange, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: Column(children: [
          itemWidget(),
          DefaultTabController(
              length: 2,
              child: Column(children: [
                TabBar(tabs: [
                  Tab(
                    text: "Made From",
                  ),
                  Tab(
                    text: "Used For",
                  ),
                ]),
                SizedBox(
                  height: 500,
                  child: TabBarView(
                    children: [
                      Obx(() => controller.itemRecipes.isEmpty
                          ? const Padding(
                              padding: EdgeInsets.all(20),
                              child: Center(
                                child: Text(
                                  "You can't craft this! Try using an extractor instead!",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ))
                          : ListView.builder(
                              shrinkWrap: true,
                              itemCount: controller.itemRecipes.length,
                              itemBuilder: (context, index) {
                                return recipeWidget(
                                    controller.itemRecipes[index]);
                              },
                            )),
                      Obx(() => controller.itemUsages.isEmpty
                          ? const Padding(
                              padding: EdgeInsets.all(20),
                              child: Center(
                                child: Text(
                                  "This item is USELESS >:(",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ))
                          : ListView.builder(
                              shrinkWrap: true,
                              itemCount: controller.itemUsages.length,
                              itemBuilder: (context, index) {
                                return recipeWidget(
                                    controller.itemUsages[index]);
                              },
                            )),
                    ],
                  ),
                ),
              ]))
        ]));
  }
}
