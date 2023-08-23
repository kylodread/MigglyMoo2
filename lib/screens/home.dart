import 'package:flutter/material.dart';
import 'package:tetris/constants.dart';
import 'package:tetris/screens/board.dart';
import 'package:audioplayers/audioplayers.dart';
import 'about.dart';
import 'package:tetris/screens/settings.dart';

class HomeScreen extends StatefulWidget {
  static const String id = "home_screen";
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

final player = AudioPlayer();

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    player.play(AssetSource('tetris_soundtrack.mp3'));
  }

  bool isMusicOn = true;

  void toggleMusic() {
    setState(() {
      isMusicOn = !isMusicOn;
      isMusicOn ? player.setVolume(0.5) : player.setVolume(0.0);
    });
  }

  void openSettings() {
    Navigator.pushNamed(context, SettingsScreen.id);
  }

  @override
  void dispose() {
    super.dispose();
    player.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Stack(
        children: [
          Positioned(
            top: 20, // Adjust this value to position the button as desired
            right: 20, // Adjust this value to position the button as desired
            child: TextButton(
              onPressed: toggleMusic,
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
              ),
              child: isMusicOn
                  ? const Icon(
                      Icons.music_note_sharp,
                      color: Colors.black87,
                    )
                  : const Icon(
                      Icons.music_off,
                      color: Colors.black87,
                    ),
            ),
          ),

          // Settings Button
          Positioned(
            top: 20, // Adjust this value to position the button as desired
            left: 20, // Adjust this value to position the button as desired
            child: TextButton(
              onPressed: openSettings,
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
              ),
              child: const Icon(
                Icons.settings,
                color: Colors.black87,
              ),
            ),
          ),
          //ui of the whole app
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Hero(
                  tag: 'logo',
                  child: Image.asset(
                    'images/tetris.png',
                    scale: 4.0,
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                const Text(
                  'MigglyMoo 2',
                  style: kHomeScreenDisplayTextStyle,
                ),
                const SizedBox(
                  height: 80,
                ),
                ElevatedButton(
                  style: kHomeScreenElevatedButtonStyle,
                  onPressed: () {
                    toggleMusic();
                    Navigator.pushNamed(context, GameBoard.id);
                  },
                  child: const Text(
                    'PLAY',
                    style: TextStyle(fontSize: 18, fontFamily: 'Silkscreen'),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                ElevatedButton(
                  style: kHomeScreenElevatedButtonStyle,
                  onPressed: () {
                    Navigator.pushNamed(context, About.id);
                  },
                  child: const Text(
                    'ABOUT',
                    style: TextStyle(fontSize: 18, fontFamily: 'Silkscreen'),
                  ),
                ),
              ],
            ),
          ),
        ],
      )),
    );
  }
}
