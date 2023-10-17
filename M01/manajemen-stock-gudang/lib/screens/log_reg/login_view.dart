import 'package:aplikasi/models/userModel.dart';
import 'package:aplikasi/providers/UsersProviders.dart';
import 'package:aplikasi/screens/log_reg/register_view.dart';
import 'package:flutter/material.dart';
import 'package:aplikasi/constants.dart';
import 'package:aplikasi/screens/index_screen.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController username = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  void showSnackbar(BuildContext context, pesan, Color color) {
    final snackBar = SnackBar(
      content: Text('${pesan}'),
      duration: Duration(seconds: 3),
      backgroundColor: color,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  bool _passwordVisible = true;

  void initState() {
    _passwordVisible = true;
  }

  Future<void> loginUser(BuildContext context) async {
    final provLogin = Provider.of<UsersProvider>(context, listen: false);

    final usernameText = username.text;
    final emailText = email.text;
    final passwordText = password.text;

    if (usernameText.isEmpty || emailText.isEmpty || passwordText.isEmpty) {
      showSnackbar(context, 'Input Box Masih ada yang kosong!', ColorPalette.textColor);
      return;
    }

    final user = provLogin.usersList.firstWhere(
      (user) =>
          user.username == usernameText &&
          user.email == emailText &&
          user.password == passwordText,
    );

    if (user != null) {
      provLogin.userDoLogin(user.id);
      Navigator.pushNamed(context, "/homePage");
    } else {
      showSnackbar(context, 'User Tidak Ditemukan!', ColorPalette.textColor);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: ColorPalette.primaryColor,
        padding: EdgeInsets.all(20.0),
        child: ListView(
          children: <Widget>[
            Center(
              child: Column(
                children: <Widget>[
                  Image.asset(
                    "assets/images/Image Logo App.png",
                    width: 123.0,
                    height: 165.0,
                  ),
                  Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 16.0),
                      ),
                      Text(
                        "SIGN IN",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 48.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 12.0),
                      ),
                      Text(
                        "Untuk tetap terhubung dengan kami, silahkan masuk dengan akun anda",
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 12.0),
                      ),
                      TextFormField(
                        controller: username,
                        decoration: const InputDecoration(
                          label: Text(
                            'Username',
                            style: TextStyle(
                                color: Color(0xFFECEFF1),
                                fontStyle: FontStyle.normal),
                          ),
                          icon: Icon(Icons.account_circle_outlined),
                          iconColor: Colors.white,
                          border: UnderlineInputBorder(),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: ColorPalette.underlineTextField,
                              width: 1.5,
                            ),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white,
                              width: 3.0,
                            ),
                          ),
                        ),
                        style: TextStyle(color: Colors.white),
                        autofocus: false,
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 12.0),
                      ),
                      TextFormField(
                        controller: email,
                        decoration: const InputDecoration(
                          label: Text(
                            'Email',
                            style: TextStyle(
                                color: Color(0xFFECEFF1),
                                fontStyle: FontStyle.normal),
                          ),
                          icon: Icon(Icons.alternate_email),
                          iconColor: Colors.white,
                          border: UnderlineInputBorder(),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: ColorPalette.underlineTextField,
                              width: 1.5,
                            ),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white,
                              width: 3.0,
                            ),
                          ),
                        ),
                        style: TextStyle(color: Colors.white),
                        autofocus: false,
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 12.0),
                      ),
                      TextFormField(
                        controller: password,
                        obscureText: _passwordVisible,
                        decoration: InputDecoration(
                          suffixIcon: InkWell(
                              onTap: () => setState(() {
                                    _passwordVisible = !_passwordVisible;
                                  }),
                              child: Icon(_passwordVisible
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined)),
                          suffixIconColor: Colors.white,
                          label: Text(
                            'Password',
                            style: TextStyle(
                                color: Color(0xFFECEFF1),
                                fontStyle: FontStyle.normal),
                          ),
                          icon: Icon(Icons.password),
                          iconColor: Colors.white,
                          border: UnderlineInputBorder(),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: ColorPalette.underlineTextField,
                              width: 1.5,
                            ),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white,
                              width: 3.0,
                            ),
                          ),
                        ),
                        style: TextStyle(color: Colors.white),
                        autofocus: false,
                      ),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 16.0),
                      ),
                      InkWell(
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 8.0),
                          width: double.infinity,
                          child: Text(
                            'Login',
                            style: TextStyle(color: ColorPalette.primaryColor),
                            textAlign: TextAlign.center,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                        onTap: () {
                          loginUser(context); // Call the login method
                        },
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 16.0),
                      ),
                      Text(
                        'or',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12.0,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 16.0),
                      ),
                      InkWell(
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 8.0),
                          width: double.infinity,
                          child: Text(
                            'Register',
                            style: TextStyle(color: ColorPalette.primaryColor),
                            textAlign: TextAlign.center,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                        onTap: () {
                          Navigator.pushNamed(context, RegisterPage.routeName);
                        },
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
