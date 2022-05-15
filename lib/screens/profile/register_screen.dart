import 'package:flutter/material.dart';
import 'package:foods/model/user_model.dart';
import 'package:foods/screens/profile/user_view_model.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:email_validator/email_validator.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

class RegisterScreen extends StatefulWidget {
  final Function(UserModel) onCreate;
  const RegisterScreen({Key? key, required this.onCreate}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _phoneController = TextEditingController();
  final _birthController = TextEditingController();
  final _addressController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  String username = '';
  String email = '';
  String password = '';
  String phone = '';
  String birth = '';
  String address = '';

  late SharedPreferences logindata;
  late bool newUser;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
    _birthController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  void initial() async {
    // Function(UserModel) onCreate;
    logindata = await SharedPreferences.getInstance();
    newUser = logindata.getBool('register') ?? true;
    setState(() {
      username = logindata.getString('username').toString();
      email = logindata.getString('email').toString();
      password = logindata.getString('password').toString();
      phone = logindata.getString('phone').toString();
      birth = logindata.getString('birth').toString();
      address = logindata.getString('address').toString();
    });
    newUser = logindata.getBool('register') ?? true;
    if (newUser == false) {
      // Navigator.pushAndRemoveUntil(
      //     context,
      //     MaterialPageRoute(builder: (context) => LoginScreen(onCreate: (user) {

      //     },)),
      //     (route) => false);
    }
  }

  @override
  void initState() {
    super.initState();
    initial();
    _nameController.addListener(() {
      setState(() {
        username = _nameController.text;
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
    _phoneController.addListener(() {
      setState(() {
        phone = _phoneController.text;
      });
    });
    _birthController.addListener(() {
      setState(() {
        birth = _birthController.text;
      });
    });
    _addressController.addListener(() {
      setState(() {
        address = _addressController.text;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    UserViewModel modelView = Provider.of<UserViewModel>(context);
    
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Register',
            style: TextStyle(fontFamily: 'Merriweather', fontSize: 17),
          ),
        ),
        body: Padding(
            padding: const EdgeInsets.all(16),
            child: Center(
              child: Form(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  key: formKey,
                  child: ListView(
                    children: [
                      TextFormField(
                        controller: _nameController,
                        cursorColor: Colors.black,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.account_circle_rounded),
                          hintText: 'Username',
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
                        ),
                        validator: (value) {
                          if (value != null && value.length > 4) {
                            return null;
                          } else {
                            return 'Enter at least 4 characters';
                          }
                        },
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      TextFormField(
                        controller: _emailController,
                        cursorColor: Colors.black,
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
                        ),
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
                        cursorColor: Colors.black,
                        obscureText: true,
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
                        ),
                        validator: (value) {
                          if (value != null && value.length > 5) {
                            return null;
                          } else {
                            return 'Enter min. 5 characters';
                          }
                        },
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      TextFormField(
                        controller: _phoneController,
                        cursorColor: Colors.black,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.call),
                          hintText: 'Phone',
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
                        ),
                        validator: (phone) {
                          if (phone != null && phone.length <= 12) {
                            return null;
                          } else {
                            return 'Enter max 12 number';
                          }
                        },
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      buildDatePicker(context),
                      const SizedBox(
                        height: 8,
                      ),
                      TextFormField(
                        controller: _addressController,
                        cursorColor: Colors.black,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.home),
                          hintText: 'Address',
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
                        ),
                        validator: (value) {
                          if (value != null) {
                            return null;
                          }
                        },
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                          onPressed: () {
                            // print(username);
                            // print(address);
                            // print(_nameController.text);
                            final userItem = UserModel(
                                username: _nameController.text,
                                email: _emailController.text,
                                password: _passwordController.text,
                                phone: _phoneController.text,
                                birth: _birthController.text,
                                address: _addressController.text);
                            print(userItem);
                            
                            widget.onCreate(userItem);
                          },
                          autofocus: false,
                          child: const Text('Register',
                              style: TextStyle(fontFamily: 'OpenSans'))),
                      const SizedBox(
                        height: 8,
                      ),
                    ],
                  )),
            )));
  }

  Widget buildDatePicker(BuildContext context) {
    final format = DateFormat("dd-MM-yy");
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DateTimeField(
          format: format,
          onShowPicker: (context, currentValue) {
            return showDatePicker(
                firstDate: DateTime(1900),
                initialDate: DateTime.now(),
                lastDate: DateTime(DateTime.now().year + 5),
                context: context);
          },
          decoration: const InputDecoration(
            prefixIcon: Icon(Icons.calendar_month),
            hintText: 'Birth(dd/mm/yyyy)',
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
          ),
          validator: (value) {
            if ((value.toString().isEmpty)) {
              return 'Please Enter Valid Date';
            } else {
              return null;
            }
          },
          onChanged: (value) {
            setState(() => birth = value.toString());
          },
        ),
      ],
    );
  }
}
