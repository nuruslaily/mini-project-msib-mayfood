import 'package:flutter/material.dart';
import 'package:foods/model/user_model.dart';
import 'package:foods/screens/profile/user_view_model.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  // final int id;

  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    UserViewModel modelView = Provider.of<UserViewModel>(context);
    final userItem = UserModel(
      username: '', 
      email: '', 
      password: '', 
      phone: '', 
      birth: '', 
      address: '');
    final user = modelView.profile.isNotEmpty ? modelView.profile[modelView.profile.length - 1] : userItem;

    // final user = UserPreferences.myUser;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Profile",
          style: TextStyle(fontSize: 17, fontFamily: 'Merriweather'),
        ),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            padding: const EdgeInsets.only(left: 25),
            child: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: ListView(children: [
        const SizedBox(
          height: 24,
        ),
        buildProfile(user),
        const SizedBox(height: 24),
      ]),
    );
  }

  Widget buildProfile(UserModel user) {
    // final user = viewModel.profile;
    return Column(
      children: [
        Text(
          user.username,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
        const SizedBox(height: 4),
        Text(
          user.email,
          style: const TextStyle(fontFamily: 'OpenSans', color: Colors.grey),
        ),
        Text(
          user.phone,
          style: const TextStyle(fontFamily: 'OpenSans', fontSize: 16),
        ),
        Text(
          user.birth,
          style: const TextStyle(fontFamily: 'OpenSans', fontSize: 16),
        ),
        Text(
          user.address,
          style: const TextStyle(fontFamily: 'OpenSans', fontSize: 16),
        )
      ],
    );
  }
}
