import 'package:flutter/material.dart';
import 'package:foods/screens/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({ Key? key }) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>{

  @override
  void initState(){
    super.initState();

    const delay = const Duration(seconds: 3);
    Future.delayed(delay, () => onTimerFinished());
  }

  void onTimerFinished(){
    Navigator.of(context).pushReplacement(new MaterialPageRoute(builder: (BuildContext context) {
      return HomeScreen();
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: Image.asset('assets/icon_mayfoods.png'),
        ),
    );
  }
  
}