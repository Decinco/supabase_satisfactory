import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class EditItemController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isHidden = true.obs;
  TextEditingController idC = TextEditingController();
  TextEditingController nameC = TextEditingController();
  TextEditingController sinkValueC = TextEditingController();
  TextEditingController powerValueC = TextEditingController();
  TextEditingController typeC = TextEditingController();
  SupabaseClient client = Supabase.instance.client;

  Future<bool> editNote(int id) async {
    try {
      if (nameC.text.isNotEmpty && typeC.text.isNotEmpty) {
        isLoading.value = true;
        await client.from("Items").update({
          "name": nameC.text,
          "sinkValue": int.tryParse(sinkValueC.text),
          "powerValue": int.tryParse(powerValueC.text),
          "type": typeC.text,
        }).match({
          "id": id,
        });
        return true;
      } else {
        return false;
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
      return false;
    }
  }
}
