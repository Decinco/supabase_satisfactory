// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:supabase_notes/app/modules/home/controllers/home_controller.dart';

import '../controllers/add_item_controller.dart';

class AddItemView extends GetView<AddItemController> {
  HomeController homeC = Get.find();

  AddItemView({super.key}); // get controller from another controller
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Add Note'),
          centerTitle: true,
        ),
        body: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            TextField(
              controller: controller.nameC,
              decoration: const InputDecoration(
                labelText: "Name",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            TextField(
              controller: controller.sinkValueC,
              decoration: const InputDecoration(
                labelText: "Sink Value",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            TextField(
              controller: controller.powerValueC,
              decoration: const InputDecoration(
                labelText: "Power Value",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            DropdownMenu(
                width: double.infinity,
                controller: controller.typeC,
                label: const Text("Item Type"),
                dropdownMenuEntries: [
                  DropdownMenuEntry<String>(
                    label: "Solid",
                    value: "Solid",
                  ),
                  DropdownMenuEntry<String>(
                    label: "Liquid",
                    value: "Liquid",
                  ),
                  DropdownMenuEntry<String>(
                    label: "Gas",
                    value: "Gas",
                  ),
                ]
            ),
            const SizedBox(
              height: 20,
            ),
            Obx(() => ElevatedButton(
                onPressed: () async {
                  if (controller.isLoading.isFalse) {
                    bool res = await controller.addNote();
                    if (res == true) {
                      await homeC.getAllItems();
                      Get.back();
                    }
                    controller.isLoading.value = false;
                  }
                },
                child: Text(
                    controller.isLoading.isFalse ? "Add note" : "Loading...")))
          ],
        ));
  }
}
