import 'package:foods/model/api/user_api.dart';
import 'package:foods/model/user_model.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:test/test.dart';

import 'user_api_test.mocks.dart';

@GenerateMocks([UserAPI])
void main() {
  group('UserAPI', () {
    UserAPI userAPI = MockUserAPI();
    test('get all users returns data', () async {
      when(userAPI.getUser()).thenAnswer((_) async => <UserModel>[
        UserModel(
          username: 'a', 
          email: 'b', 
          password: 'c', 
          phone: 'd', 
          birth: 'e', 
          address: 'f')
      ]);
    var users = await userAPI.getUser();
    expect(users.isNotEmpty, true);
  });
  });
  // test('post user returns data', () async {
  //   var users = await UserAPI.postUsers();
  //   expect(users, true);
  // });
}