import 'package:flutter/material.dart';
import 'package:foods/screens/component/splash_screen.dart';
import 'package:foods/screens/food/food_screen.dart';
import 'package:foods/screens/food/food_view_model.dart';
import 'package:foods/screens/home_screen.dart';
import 'package:foods/screens/profile/login_screen.dart';
import 'package:foods/screens/profile/register_screen.dart';
import 'package:foods/screens/profile/user_view_model.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => FoodViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => UserViewModel(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'MayFoods',
        theme: ThemeData(
          primarySwatch: Colors.red,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
