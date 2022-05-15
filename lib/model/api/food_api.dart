import 'package:foods/model/food_model.dart';
import 'package:dio/dio.dart';

class FoodAPI {
  static Future<List<Food>> getFoods() async {
    final response = await Dio()
        .get("https://my-json-server.typicode.com/nuruslaily/pelatihan/menu");

    List<Food> foods = (response.data as List)
        .map((e) => Food(
            id: e['id'],
            category: e['category'],
            name: e['name'],
            price: e['price'],
            description: e['description'],
            image: e['image']))
        .toList();

    return foods;
  }
}
