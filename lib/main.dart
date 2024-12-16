import 'package:flutter/material.dart';
import 'package:tvmaze/screens/bottomNavigation.dart';
import 'package:tvmaze/screens/detail.dart';
import 'package:tvmaze/screens/search.dart';
import 'package:tvmaze/screens/splash.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie App',
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/home': (context) => BottomNavScreen(),
        '/search': (context) => SearchScreen(),
        '/details': (context) => DetailsScreen(),
      },
      theme: ThemeData.dark(),
    );
  }
}
