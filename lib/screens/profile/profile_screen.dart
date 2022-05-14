import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:foods/model/user_model.dart';
import 'package:foods/screens/profile/user_preferences.dart';
import 'package:foods/screens/profile/user_view_model.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  // final int id;

  ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    UserViewModel modelView = Provider.of<UserViewModel>(context);
    final user = modelView.profile[0];
   
    // final user = UserPreferences.myUser;
    
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
            "Profile",
            style: TextStyle(fontSize: 17, fontFamily: 'Merriweather'),
          ),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            padding: EdgeInsets.only(left: 25),
            child: Icon(
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
        SizedBox(height: 24),
      ]),
    );
  }

  Widget buildProfile(UserModel user){
    // final user = viewModel.profile;
    return Column(
      children: [
        Text(
          user.username,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
        SizedBox(height: 4),
        Text(
          user.email,
          style: TextStyle(color: Colors.grey),
        ),
        Text(
          user.phone,
          style: TextStyle(fontSize: 16),
        ),
        Text(
          user.address,
          style: TextStyle(fontSize: 16),
        )
      ],
    );
  }
}
