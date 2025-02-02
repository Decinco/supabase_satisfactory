import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_notes/app/routes/app_pages.dart';

import '../../../../uicon.dart';
import '../../../data/models/item_model.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  Widget leading(Item item) {
    return FutureBuilder(
        future:
            controller.getImageUrl(item.itemImage ?? "ResIcon_Walls_Dark.png"),
        builder: (context, snapshot) {
          if (item.type == ItemType.Solid) {
            return Padding(
                padding: EdgeInsets.all(10),
                child: Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(100, 170, 170, 170),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Padding(
                        padding: EdgeInsets.all(5),
                        child: Image(
                          image: NetworkImage(snapshot.data ??
                              "https://ztbjgzaxhmcadkthnuxl.supabase.co/storage/v1/object/public/satisfactoryItems//ResIcon_Walls_Dark.png"),
                        ))));
          } else {
            return Padding(
                padding: EdgeInsets.all(10),
                child: Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(100, 170, 170, 170),
                      borderRadius: BorderRadius.circular(60),
                    ),
                    child: Padding(
                        padding: EdgeInsets.all(5),
                        child: Image(
                            image: NetworkImage(snapshot.data ??
                                "https://ztbjgzaxhmcadkthnuxl.supabase.co/storage/v1/object/public/satisfactoryItems//ResIcon_Walls_Dark.png  ")
                        ))));
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Satisfactory Items',
            style: TextStyle(
                color: Colors.deepOrange, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: FutureBuilder(
            future: controller.getAllItems(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              return Obx(() => controller.allItems.isEmpty
                  ? const Center(
                      child: Text(
                        "Inefficient! (No items found)",
                        style: TextStyle(color: Colors.deepOrange),
                      ),
                    )
                  : ListView.builder(
                      itemCount: controller.allItems.length,
                      itemBuilder: (context, index) {
                        Item item = controller.allItems[index];
                        return InkWell(
                            onTap: () => Get.toNamed(
                                  Routes.RECIPES,
                                  arguments: item,
                                ),
                            child: Stack(children: [
                              Row(children: [
                                leading(item),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item.name,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontStyle: FontStyle.italic,
                                      ),
                                    ),
                                    Text(item.type.name),
                                  ],
                                ),
                              ]),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(20),
                                    child: IconButton(
                                      onPressed: () async =>
                                          await controller.deleteItem(item.id),
                                      icon: Icon(UIcons.fibstrash,
                                          color: Colors.deepOrange),
                                    ),
                                  )
                                ],
                              ),
                            ]));
                      },
                    ));
            }),
    );
  }
}
