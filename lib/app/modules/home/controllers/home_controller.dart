import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../data/models/item_model.dart';

class HomeController extends GetxController {
  RxList allItems = List<Item>.empty().obs;
  SupabaseClient client = Supabase.instance.client;

  Future<void> getAllItems() async {
    var items = await client.from("Items").select().order("id", ascending: true);
    List<Item> itemsData = Item.fromJsonList((items as List));
    allItems(itemsData);
    allItems.refresh();
  }

  Future<String> getImageUrl(String filename) async {
    return await client
        .storage
        .from('satisfactoryItems')
        .getPublicUrl(filename);
  }

  Future<void> deleteItem(int id) async {
    await client.from("Items").delete().match({
      "id": id,
    });
    getAllItems();
  }
}
