import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'screens/board.dart';
import 'screens/home.dart';
import 'screens/score.dart'; // Import the updated ScoreScreen class
import 'screens/about.dart';
import 'screens/splash.dart';
import 'screens/settings.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // Define your variables here
  final int userScore = 0; // Provide default values or update with appropriate values
  final int highScore = 0;
  final int linesCleared = 0;

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
          userScore: userScore,
          highScore: highScore,
          linesCleared: linesCleared,
        ),
        SettingsScreen.id: (context) => const SettingsScreen(),
      },
    );
  }
}

