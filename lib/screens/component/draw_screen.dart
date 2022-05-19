import 'package:flutter/material.dart';
import 'package:foods/model/user_model.dart';
import 'package:foods/screens/cart/cart_screen.dart';
import 'package:foods/screens/category/category_screen.dart';
import 'package:foods/screens/component/favorite_screen.dart';
import 'package:foods/screens/food/food_view_model.dart';
import 'package:foods/screens/profile/login_screen.dart';
import 'package:foods/screens/profile/profile_screen.dart';
import 'package:foods/screens/profile/user_view_model.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DrawWidget extends StatefulWidget {
  const DrawWidget({Key? key}) : super(key: key);

  @override
  State<DrawWidget> createState() => _DrawWidgetState();
}

class _DrawWidgetState extends State<DrawWidget> {
  SharedPreferences? logindata;
  String email = '';
  String password = '';

  initial() async {
    logindata = await SharedPreferences.getInstance();
    setState(() {
      email = logindata!.getString('email').toString();
    });
  }

  @override
  void initState() {
    super.initState();
    initial().whenComplete(() {
      setState(() {
        email = logindata!.getString('email').toString();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    FoodViewModel viewModel = Provider.of<FoodViewModel>(context);

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          _header(),
          _item(
            icon: Icons.person,
            text: 'Profile',
            // ignore: avoid_print
            onTap: () => {
              Navigator.push(
                context,
                PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) {
                  return ProfileScreen();
                }, transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                  final tween = Tween(begin: 0.0, end: 1.0);
                  return FadeTransition(
                      opacity: animation.drive(tween), child: child);
                }),
              )
            },
          ),
          _item(
            icon: Icons.shopping_cart,
            text: 'Cart',
            // ignore: avoid_print
            onTap: () => {
              Navigator.push(
                context,
                PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) {
                  return CartScreen();
                }, transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                  final tween = Tween(begin: 0.0, end: 1.0);
                  return FadeTransition(
                      opacity: animation.drive(tween), child: child);
                }),
              )
            },
          ),
          _item(
              icon: Icons.category,
              text: 'Category',
              // ignore: avoid_print
              onTap: () => {
                    // initial data filteredFood for category page
                    for (var food in viewModel.foods)
                      {viewModel.filteredFood.add(food)},
                    Navigator.push(
                      context,
                      PageRouteBuilder(pageBuilder:
                          (context, animation, secondaryAnimation) {
                        return const CategoryScreen();
                      }, transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        final tween = Tween(begin: 0.0, end: 1.0);
                        return FadeTransition(
                            opacity: animation.drive(tween), child: child);
                      }),
                    )
                  }),
          _item(
              icon: Icons.favorite,
              text: 'Favorite',
              // ignore: avoid_print
              onTap: () => {
                    Navigator.push(
                      context,
                      PageRouteBuilder(pageBuilder:
                          (context, animation, secondaryAnimation) {
                        return const FavoriteScreen();
                      }, transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        final tween = Tween(begin: 0.0, end: 1.0);
                        return FadeTransition(
                            opacity: animation.drive(tween), child: child);
                      }),
                    )
                  }),

          const Divider(height: 25, thickness: 1),

          _item(
              icon: Icons.outbox,
              text: 'Log out',
              // ignore: avoid_print
              onTap: () => logout()),
          // const Padding(
          //   padding: EdgeInsets.only(left: 20.0, top: 10, bottom: 10),
          //   child: Text("Labels",
          //       style: TextStyle(
          //         fontSize: 16,
          //         color: Colors.blue,
          //       )),
          // ),
        ],
      ),
    );
  }

  void logout() {
    final modelView = Provider.of<UserViewModel>(context, listen: false);
    modelView.logout();
    Navigator.push(
      context,
      PageRouteBuilder(pageBuilder: (context, animation, secondaryAnimation) {
        return const LoginScreen();
      }, transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final tween = Tween(begin: 0.0, end: 1.0);
        return FadeTransition(opacity: animation.drive(tween), child: child);
      }),
    );
  }

  Widget _header() {
    // final user = UserPreferences.myUser;
    UserViewModel modelView = Provider.of<UserViewModel>(context);
    final userItem = UserModel(
      username: '', 
      email: '', 
      password: '', 
      phone: '', 
      birth: '', 
      address: '');
    final user = modelView.profile.isNotEmpty ? modelView.profile[modelView.profile.length - 1] : userItem;
    return UserAccountsDrawerHeader(
      currentAccountPicture: ClipOval(
        child: CircleAvatar(
            child: Text(
          user.username[0],
          style: const TextStyle(fontSize: 20),
        )),
      ),
      accountName:
          Text(user.username, style: const TextStyle(fontFamily: 'OpenSans')),
      accountEmail:
          Text(user.email, style: const TextStyle(fontFamily: 'OpenSans')),
    );
  }

  Widget _item({IconData? icon, String? text, GestureTapCallback? onTap}) {
    return ListTile(
      title: Row(
        children: <Widget>[
          Icon(icon),
          Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child: Text(
              text!,
              style: const TextStyle(
                fontFamily: 'OpenSans',
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ],
      ),
      onTap: onTap,
    );
  }
}
