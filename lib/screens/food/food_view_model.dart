import 'package:flutter/cupertino.dart';
import 'package:foods/model/amount_model.dart';
import 'package:foods/model/api/food_api.dart';
import 'package:foods/model/food_model.dart';
import 'package:foods/model/view_state.dart';

class FoodViewModel with ChangeNotifier {
  List<Food> _foods = [];

  List<Food> get foods => _foods;

  List<Amount> _amount = [];

  List<Amount> get amount => _amount;

  ViewState _state = ViewState.none;
  ViewState get state => _state;

  changeState(ViewState s) {
    _state = s;
    notifyListeners();
  }

  getAllFoods() async {
    // changeState(FoodViewState.loading);

    try {
      final f = await FoodAPI.getFoods();
      _foods = f;
      notifyListeners();
      changeState(ViewState.none);
    } catch (e) {
      print('----------- error : ');
      print(e);
      changeState(ViewState.error);
    }
  }

  List<Food> _cartList = [];

  List<Food> get cartList => _cartList;

  void addCart(Food foodMenu) {
    _cartList.add(foodMenu);
    notifyListeners();
  }

  void updateCart(int index, Food foodMenu){
    _cartList.removeAt(index);
    _cartList.add(foodMenu);
    notifyListeners();
  }

  List<String> _category = [];

  List<String> get category => _category;

  List<Food> _favorite = [];
  List<Food> get favorite => _favorite;

  List<Food> _filteredFood = [];
  List<Food> get filteredFood => _filteredFood;

  void favoriteFood(Food menu) {
    _favorite.add(menu);
    notifyListeners();
  }

  // void filterCategory(Food menu){
  //   _category.fillRange(start, end)
  // }
}

List<Widget> getChildrenWithSeparator(
    {required List<Widget> widgets,
    required Widget separator,
    bool addToLastChild = true}) {
  List<Widget> children = [];
  if (widgets.isNotEmpty) {
    children.add(separator);

    for (int i = 0; i < widgets.length; i++) {
      children.add(widgets[i]);

      if (widgets.length - i == 1) {
        if (addToLastChild) {
          children.add(separator);
        }
      } else {
        children.add(separator);
      }
    }
  }
  return children;
}
