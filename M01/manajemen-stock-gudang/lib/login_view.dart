import 'package:aplikasi/constants.dart';
import 'package:aplikasi/providers/UsersProviders.dart';
import 'package:aplikasi/screens/log_reg/register_view.dart';
import 'package:flutter/material.dart';     
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  static const routeName = "/loginPage";
  const LoginPage({super.key});
  
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController username = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  
  var _loginStream;

  @override
  void initState() {
    super.initState();
    checkKeepLoggedIn();
  }

  Future<void> checkKeepLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    final keepLoggedIn = prefs.getBool('keepLoggedIn') ?? false;
    if (keepLoggedIn) {
      // Jika pengguna sudah login, arahkan ke halaman HomePage
      Navigator.pushReplacementNamed(context, "/homePage");
    }
  }


  void showSnackbar(BuildContext context, pesan, Color color) {
    final snackBar = SnackBar(
      content: Text('${pesan}'),
      duration: const Duration(seconds: 3),
      backgroundColor: color,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  bool _passwordVisible = true;

  Future<void> loginUser(BuildContext context) async {
    final provLogin = Provider.of<UsersProvider>(context, listen: false);
    final usernameText = username.text;
    final emailText = email.text;
    final passwordText = password.text;

    if (usernameText.isEmpty || emailText.isEmpty || passwordText.isEmpty) {
      showSnackbar(context, 'Mohon masukkan akun anda !', ColorPalette.textColor);
      return;
    }
    
    final user = provLogin.usersList.firstWhere(
      (user) =>
          user.username == usernameText &&
          user.email == emailText &&
          user.password == passwordText,
    );

    if (user != null) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('keepLoggedIn', true); // Ubah nilai menjadi true saat login.
      await prefs.setString('userId', user.id); // Menyimpan user.id ke dalam SharedPreferences.
      provLogin.userDoLogin(user.id);
      Navigator.pushReplacementNamed(context, "/homePage");
    } else {
      showSnackbar(context, 'User Tidak Ditemukan!', ColorPalette.textColor);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: ColorPalette.primaryColor,
        padding: const EdgeInsets.all(20.0),
        child: StreamBuilder<bool>(
          stream: _loginStream, // Replace with your actual login stream
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator(); // Show loading indicator.
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return ListView(
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
                          children: const <Widget>[
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
                            const Padding(
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
                              style: const TextStyle(color: Colors.white),
                              autofocus: false,
                            ),
                            const Padding(
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
                              style: const TextStyle(color: Colors.white),
                              autofocus: false,
                            ),
                            const Padding(
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
                                suffixIconColor: Colors.white,
                                label: const Text(
                                  'Password',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontStyle: FontStyle.normal,
                                  ),
                                ),
                                icon: const Icon(Icons.password),
                                iconColor: Colors.white,
                                border: const UnderlineInputBorder(),
                                enabledBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.white,
                                    width: 1.5,
                                  ),
                                ),
                                focusedBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.white,
                                    width: 3.0,
                                  ),
                                ),
                              ),
                              style: const TextStyle(color: Color(0xFFECEFF1)),
                              autofocus: false,
                            ),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            const Padding(
                              padding: EdgeInsets.only(top: 16.0),
                            ),
                            InkWell(
                              child: Container(
                                padding: const EdgeInsets.symmetric(vertical: 8.0),
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
                            const Padding(
                              padding: EdgeInsets.only(top: 16.0),
                            ),
                            const Text(
                              'or',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12.0,
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(top: 16.0),
                            ),
                            InkWell(
                              child: Container(
                                padding: const EdgeInsets.symmetric(vertical: 8.0),
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
              );
            }
          }
        )
      )
    );
  }
}