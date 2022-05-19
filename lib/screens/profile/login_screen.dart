import 'package:flutter/material.dart';
import 'package:foods/screens/food/food_screen.dart';
import 'package:foods/screens/profile/user_view_model.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:email_validator/email_validator.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginScreen extends StatefulWidget {
  // final Function(UserModel) onCreate;
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  late final SharedPreferences logindata;
  String email = '';
  String password = '';
  late bool newUser;

  final formKey = GlobalKey<FormState>();

  checkLogin() async {
    logindata = await SharedPreferences.getInstance();
    setState(() {
      email = logindata.getString('email').toString();
      password = logindata.getString('password').toString();
    });
    newUser = logindata.getBool('login') ?? true;
    if (newUser == false) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const FoodScreen()),
          (route) => false);
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<UserViewModel>(context, listen: false).getAllUser();
    });
  }

  @override
  void initState() {
    super.initState();

    checkLogin().whenComplete(() {
      setState(() {
        email = _emailController.text;
        password = _passwordController.text;
      });
    });
    _emailController.addListener(() {
      setState(() {
        email = _emailController.text;
      });
    });
    _passwordController.addListener(() {
      setState(() {
        password = _passwordController.text;
      });
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    UserViewModel modelView = Provider.of<UserViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Login',
            style: TextStyle(fontFamily: 'Merriweather', fontSize: 17)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            key: formKey,
            child: ListView(children: [
              TextFormField(
                controller: _emailController,
                cursorColor: Colors.black,
                style: const TextStyle(color: Colors.black),
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.email),
                    hintText: 'Email',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    focusColor: Colors.black),
                validator: (email) {
                  if (email != null && EmailValidator.validate(email)) {
                    return null;
                  } else {
                    return 'Enter a valid email';
                  }
                },
              ),
              const SizedBox(
                height: 8,
              ),
              TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  cursorColor: Colors.black,
                  style: const TextStyle(color: Colors.black),
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.lock),
                      hintText: 'Password',
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      focusColor: Colors.black),
                  validator: (value) {
                    if (value != null && value.length > 5) {
                      return null;
                    } else {
                      return 'Enter min. 5 characters';
                    }
                  }),
              const SizedBox(
                height: 16,
              ),
              ElevatedButton(
                child: const Text(
                  'Login',
                  style: TextStyle(fontFamily: 'OpenSans'),
                ),
                onPressed: () => getButtonLogin(modelView),
              ),
            ]),
          ),
        ),
      ),
    );
  }

  getButtonLogin(UserViewModel modelView) {
    var statusLogin = false;
    var userValid;
    print('di klik');

    email = _emailController.text;
    password = _passwordController.text;

    for (var users in modelView.user) {

      if (users.email == email && users.password == password) {
        print("berhasil login");
        // simpan data valid user ke storage
        statusLogin = true;
        userValid = users;
      }
    }

    if (statusLogin) {
      setState(() {
        modelView.saveUserinStrorage(userValid);
      });
      Navigator.push(
        context,
        PageRouteBuilder(pageBuilder: (context, animation, secondaryAnimation) {
          return const FoodScreen();
        }, transitionsBuilder: (context, animation, secondaryAnimation, child) {
          final tween = Tween(begin: 0.0, end: 1.0);
          return FadeTransition(opacity: animation.drive(tween), child: child);
        }),
      );
    } else {
      Fluttertoast.showToast(
          msg: "invalid email or password",
          toastLength: Toast.LENGTH_SHORT,
          // gravity: ToastGravity.CENTER,
          backgroundColor: Colors.black,
          timeInSecForIosWeb: 1,
          textColor: Colors.white,
          fontSize: 16.0);
    }

  }

}
