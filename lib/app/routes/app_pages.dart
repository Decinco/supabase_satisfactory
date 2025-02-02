import 'package:supabase_notes/app/modules/recipes/bindings/recipes_binding.dart';
import 'package:supabase_notes/app/modules/recipes/views/recipes_view.dart';

// ignore_for_file: constant_identifier_names

import 'package:get/get.dart';

import 'package:supabase_notes/app/modules/add_item/bindings/add_item_binding.dart';
import 'package:supabase_notes/app/modules/add_item/views/add_item_view.dart';
import 'package:supabase_notes/app/modules/edit_item/bindings/edit_item_binding.dart';
import 'package:supabase_notes/app/modules/edit_item/views/edit_item_view.dart';
import 'package:supabase_notes/app/modules/home/bindings/home_binding.dart';
import 'package:supabase_notes/app/modules/home/views/home_view.dart';
import 'package:supabase_notes/app/modules/login/bindings/login_binding.dart';
import 'package:supabase_notes/app/modules/login/views/login_view.dart';
import 'package:supabase_notes/app/modules/profile/bindings/profile_binding.dart';
import 'package:supabase_notes/app/modules/profile/views/profile_view.dart';
import 'package:supabase_notes/app/modules/register/bindings/register_binding.dart';
import 'package:supabase_notes/app/modules/register/views/register_view.dart';


part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => const RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.ADD_ITEM,
      page: () => AddItemView(),
      binding: AddItemBinding(),
    ),
    GetPage(
      name: _Paths.EDIT_ITEM,
      page: () => EditItemView(),
      binding: EditItemBinding(),
    ),
    GetPage(
      name: _Paths.RECIPES,
      page: () => RecipesView(),
      binding: RecipesBinding(),
    ),
  ];
}
