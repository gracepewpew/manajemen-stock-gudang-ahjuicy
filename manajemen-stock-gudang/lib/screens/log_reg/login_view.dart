import 'package:aplikasi/constants.dart';
import 'package:aplikasi/screens/log_reg/register_view.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController username = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  @override
  void initState() {
    super.initState();
    checkKeepLoggedIn();
  }

  Future<void> checkKeepLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    final keepLoggedIn = prefs.getBool('keepLoggedIn') ?? false;
    if (keepLoggedIn) {
      // ignore: use_build_context_synchronously
      Navigator.pushReplacementNamed(context, "/homePage");
    }
  }
  Future<void> logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('keepLoggedIn', false);
  }

  void showSnackbar(BuildContext context, pesan, Color color) {
    final snackBar = SnackBar(
      // ignore: unnecessary_brace_in_string_interps
      content: Text('${pesan}'),
      duration: const Duration(seconds: 3),
      backgroundColor: color,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  bool _passwordVisible = true;

  Future<void> loginUser(BuildContext context) async {
    final usernameText = username.text;
    final emailText = email.text;
    final passwordText = password.text;
    if (usernameText.isEmpty || emailText.isEmpty || passwordText.isEmpty) {
      showSnackbar(
          context, 'Input Box Masih ada yang kosong!', ColorPalette.textColor);
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: ColorPalette.primaryColor,
        padding: const EdgeInsets.all(20.0),
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
                              color: Colors.white,
                              fontStyle: FontStyle.normal,
                            ),
                          ),
                          icon: Icon(Icons.account_circle_outlined),
                          iconColor: Colors.white,
                          border: UnderlineInputBorder(),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white,
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
                              color: Colors.white,
                              fontStyle: FontStyle.normal,
                            ),
                          ),
                          icon: Icon(Icons.alternate_email),
                          iconColor: Colors.white,
                          border: UnderlineInputBorder(),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white,
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
                                : Icons.visibility_off_outlined),
                          ),
                          suffixIconColor: Colors.black,
                          label: Text(
                            'Password',
                            style: TextStyle(
                              color: Colors.white,
                              fontStyle: FontStyle.normal,
                            ),
                          ),
                          icon: Icon(Icons.password),
                          iconColor: Colors.white,
                          border: UnderlineInputBorder(),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white,
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
                        style: TextStyle(color: Color(0xFFECEFF1)),
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
                        onTap: () => loginUser(context),
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
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RegisterPage(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}