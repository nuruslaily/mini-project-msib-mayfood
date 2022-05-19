import 'package:dio/dio.dart';
import 'package:foods/model/user_model.dart';

class UserAPI {
   Future<List<UserModel>> getUser() async {
    final response = await Dio().get(
        "https://my-json-server.typicode.com/nuruslaily/pelatihan/profile");

    List<UserModel> user = (response.data as List)
        .map((e) => UserModel(
            id: e['id'],
            username: e['username'],
            email: e['email'],
            password: e['password'],
            phone: e['phone'],
            birth: e['birth'],
            address: e['address']))
        .toList();

    return user;
  }

   Future postUsers(UserModel user) async {
    final response =
        await Dio().post("http://localhost:3000/profile", data: user.toJson());
    print(response);
    return response.data;
  }
}
