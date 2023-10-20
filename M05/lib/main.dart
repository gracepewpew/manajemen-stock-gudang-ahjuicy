import 'package:flutter/material.dart';
import 'package:projectbaru/providers/UsersProviders.dart';
import 'package:projectbaru/screens/activation_view.dart';
import 'package:projectbaru/screens/bottomnavigation/profile_view.dart';
import 'package:projectbaru/screens/log_reg/login_view.dart';
import 'package:projectbaru/screens/log_reg/register_view.dart';
import 'package:projectbaru/screens/splashScreen.dart';
import 'package:provider/provider.dart';
import 'screens/index_screen.dart';


void main() {
  runApp(
    MultiProvider(
    providers: [ChangeNotifierProvider(create: (context) => UsersProvider())],
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Sansita'),
      title: "Manajemen Stock Gudang",
      initialRoute: "/",
      routes: {
        "/": (context) => const SplashScreen(),
        LoginPage.routeName:(context) => const LoginPage(),
        RegisterPage.routeName: (context) => RegisterPage(),
        IndexScreen.routeName: (context) => const IndexScreen(),
        Activation.routeName: (context) => Activation(),
        ProfilePage.routeName: (context) => const ProfilePage(),
      },
    ),
  ));
}
