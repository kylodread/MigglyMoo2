import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'screens/splash.dart';
import 'screens/home.dart';
import 'screens/about.dart';
import 'screens/board.dart';
import 'screens/score.dart';
import 'screens/settings.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: Splash.id,
      routes: {
        Splash.id: (context) => const Splash(),
        HomeScreen.id: (context) => const HomeScreen(),
        About.id: (context) => const About(),
        GameBoard.id: (context) => const GameBoard(),
        ScoreScreen.id: (context) => ScoreScreen(
          userScore: 0, // Provide initial values here
          highScore: 0,
          linesCleared: 0,
        ),
        SettingsScreen.id: (context) => const SettingsScreen(),
      },
    );
  }
}
