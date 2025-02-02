// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_notes/app/data/models/notes_model.dart';
import 'package:supabase_notes/app/modules/home/controllers/home_controller.dart';

import '../../../data/models/item_model.dart';
import '../controllers/edit_item_controller.dart';

class EditItemView extends GetView<EditItemController> {
  Item item = Get.arguments;
  HomeController homeC = Get.find();

  EditItemView({super.key});
  @override
  Widget build(BuildContext context) {
    controller.nameC.text = item.name;
    controller.sinkValueC.text = item.sinkValue.toString();
    controller.powerValueC.text = item.powerValue.toString();
    controller.typeC.text = item.type.name;
    return Scaffold(
        appBar: AppBar(
          title: const Text('Edit Item'),
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
              height: 25,
            ),
            Obx(() => ElevatedButton(
                onPressed: () async {
                  if (controller.isLoading.isFalse) {
                    bool res = await controller.editNote(item.id);
                    if (res == true) {
                      await homeC.getAllItems();
                      Get.back();
                    }
                    controller.isLoading.value = false;
                  }
                },
                child: Text(
                    controller.isLoading.isFalse ? "Edit item" : "Loading...")))
          ],
        ));
  }
}
