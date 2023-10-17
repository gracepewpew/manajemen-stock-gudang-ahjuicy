import 'dart:async';
import 'package:aplikasi/constants.dart';
import 'package:aplikasi/screens/log_reg/login_view.dart';
import 'package:flutter/material.dart';
// ignore: implementation_imports, unnecessary_import
import 'package:flutter/src/widgets/framework.dart';
// ignore: implementation_imports, unused_import
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'bottomnavigation/homepage_view.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    checkLoggedInStatus();
  }
    void checkLoggedInStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    if (isLoggedIn) {
      // Jika pengguna sudah masuk sebelumnya, beralih ke HomePage
      Navigator.pushReplacementNamed(context, HomePage.routeName);
    } else {
      // Jika belum masuk, tampilkan halaman login setelah tampilan SplashScreen
      Timer(Duration(seconds: 5), () {
        Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) {
            return LoginPage();
          },
        ));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            color: ColorPalette.primaryColor,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SpinKitFadingCube(
                  color: ColorPalette.hintColor,
                  size: 150,
                ),
                SizedBox(
                  height: 100,
                ),
                Material(
                    color: Colors.transparent,
                    child: Text(
                      textAlign: TextAlign.center,
                      'Management Stock Gudang',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 36,
                          fontWeight: FontWeight.bold),
                    ))
              ],
            )));
  }
}
