import 'package:flutter/material.dart';
import './pages/home.dart';

// Colours
const PrimaryColorDark = const Color(0xFF6B6054);
const PrimaryColor = const Color(0xFF929487);
const PrimaryColorLight = const Color(0xFFA1B0AB);

const SecondaryColor = const Color(0xFFC3DAC3);
const SecondaryColorLight = const Color(0xFFD5ECD4);
const SecondaryColorDark = const Color(0xFFA7C4A7);

const Background = const Color(0xFFfffdf7);
const TextColor = const Color(0xFFffffff);

void main() {
  runApp(const MyApp());
}

// Main widget
class MyApp extends StatelessWidget {
  const MyApp(
      {super.key}); // Keys used to track state of widgets when they move around in the widget subtree. Not needed in stateless widgets.

  // builds a widget containing other widgets
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TextMemoirs',
      theme: ThemeData(
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.transparent,
            foregroundColor: PrimaryColorDark,
            elevation: 0,
            titleTextStyle: TextStyle(
                fontFamily: 'Arial',
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: PrimaryColorDark),
          ),
          backgroundColor: Background,
          primaryColor: PrimaryColor,
          primaryColorDark: PrimaryColorDark,
          primaryColorLight: PrimaryColorLight),
      home: const HomePage(),
    );
  }
}
