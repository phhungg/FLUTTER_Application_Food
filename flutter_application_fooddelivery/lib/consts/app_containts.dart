import 'package:flutter_application_/models/category_model.dart';
import 'package:flutter_application_/services/assets_manager.dart';

class AppContaints {
  static String productImageUrl =
      "https://superfoods.vn/wp-content/uploads/2023/07/banh-mi-hamburger-truyen-thong.jpeg";
  static List<String> bannerIamges = [
    AssetsManager.banner1,
    AssetsManager.banner2,
    AssetsManager.banner3,
    AssetsManager.banner4,
    AssetsManager.banner5,
  ];
  static List<CategoryModel> categoryList = [
    CategoryModel(
      id: "Hamburger",
      images: AssetsManager.hamburgur,
      name: "Hamburgers",
    ),
    CategoryModel(
      id: "Desserts",
      images: AssetsManager.dessets,
      name: "Desserts",
    ),
    CategoryModel(
      id: "Coffee",
      images: AssetsManager.coffee,
      name: "Coffees",
    ),
    CategoryModel(
      id: "Drinks",
      images: AssetsManager.drinks,
      name: "Drinks",
    ),
    CategoryModel(
      id: "Salads",
      images: AssetsManager.salad,
      name: "Salads",
    ),
    CategoryModel(
      id: "Spaghettis",
      images: AssetsManager.spaghetti,
      name: "Spaghettis",
    ),
    CategoryModel(
      id: "Ice Cream",
      images: AssetsManager.icecream,
      name: "Ice Creams",
    ),
    CategoryModel(
      id: "Sandwiches",
      images: AssetsManager.sandwich,
      name: "Sandwiches",
    ),
  ];
  static String apiKey = "AIzaSyD1TDCGYJ3M_q716owGHLBUU9E0yYeWnrg";
  static String appId = "1:914580672958:android:bd1e941d2638fe17e8a9ef";
  static String messagingSenderId = "914580672958";
  static String projectId = "food-delivery-e5255";
  static String storagebucket = "food-delivery-e5255.appspot.com";
}
