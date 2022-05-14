import 'package:foods/model/api/food_api.dart';
import 'package:foods/model/food_model.dart';
import 'package:test/test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

import 'food_api_test.mocks.dart';

@GenerateMocks([FoodAPI])
void main() {
  group('FoodAPI', () {
    FoodAPI foodAPI = MockFoodAPI();
    test('get all foods returns data', () async {
      when(foodAPI.getFoods()).thenAnswer(
        (_) async => <Food>[
        Food(id: 1, name: 'a', category: 'snack', price: 5000, description: 's', image: 'img'),
      ],);
      var foods = await foodAPI.getFoods();
      expect(foods.isNotEmpty, true);
    });
  });
}
