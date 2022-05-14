import 'package:flutter/cupertino.dart';
import 'package:foods/model/api/user_api.dart';
import 'package:foods/model/user_model.dart';
import 'package:foods/model/view_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserViewModel with ChangeNotifier {
  List<UserModel> _user = [];

  List<UserModel> get user => _user;

  List<UserModel> _profile = [];

  List<UserModel> get profile => _profile;

  ViewState _state = ViewState.none;
  ViewState get state => _state;

  changeState(ViewState s) {
    _state = s;
    notifyListeners();
  }

  getAllUser() async {
    // changeState(FoodViewState.loading);

    try {
      final u = await UserAPI.getUser();
      _user = u;
      notifyListeners();
      changeState(ViewState.none);
    } catch (e) {
      changeState(ViewState.error);
    }
  }

   void addUser(UserModel userModel) {
    _user.add(userModel);    
    notifyListeners();
  }

  postUser(UserModel userModel) async {
    await UserAPI.postUsers(userModel);
    _user.add(userModel);
    notifyListeners();
  }

 void saveUserinStrorage(UserModel userModel) {
    _profile.add(userModel);
    notifyListeners();
  }

  void logout(UserModel userModel){
    _profile.remove(userModel);
    notifyListeners();
  }
}
