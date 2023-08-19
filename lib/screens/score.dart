import 'package:flutter/material.dart';
import 'package:tetris/constants.dart';
import 'package:tetris/screens/board.dart';

class ScoreScreen extends StatelessWidget {
  static const String id = "score_screen";

  final int userScore;
  final int highScore;
  final int linesCleared;

  const ScoreScreen({
    Key? key,
    required this.userScore,
    required this.highScore,
    required this.linesCleared,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: const Color(0xFF222831),
      backgroundColor: Color.fromARGB(255, 0, 0, 0),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Expanded(
                flex: 9,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Hero(
                    //  tag: 'logo',
                    // child: Image.asset(
                    //  'images/tetris_block.png',
                    //  scale: 1.2,
                    //  ),
                    // ),
                    const SizedBox(
                      height: 25,
                    ),
                    const Text(
                      'GAME OVER',
                      style: kScoreScreenDisplayTextStyle,
                    ),
                    const SizedBox(
                      height: 100,
                    ),
                    const Text(
                      'Score',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'SilkScreen',
                        fontSize: 30,
                        fontWeight: FontWeight.w200,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      '$userScore',
                      style: const TextStyle(
                        color: Colors.white,
                        fontFamily: 'SilkScreen',
                        fontSize: 35,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    // Display the high score
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'High Score',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'SilkScreen',
                        fontSize: 30,
                        fontWeight: FontWeight.w200,
                      ),
                    ),
                    Text(
                      '$highScore', // Display the actual high score
                      style: const TextStyle(
                        color: Colors.white,
                        fontFamily: 'SilkScreen',
                        fontSize: 35,
                        fontWeight: FontWeight.w700,
                      ),
                    ),

                    // Display the lines cleared
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'Lines Cleared',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'SilkScreen',
                        fontSize: 30,
                        fontWeight: FontWeight.w200,
                      ),
                    ),
                    Text(
                      '$linesCleared', // Display the actual lines cleared
                      style: const TextStyle(
                        color: Colors.white,
                        fontFamily: 'SilkScreen',
                        fontSize: 35,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const Text(
                      'Lines Cleared HS',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'SilkScreen',
                        fontSize: 30,
                        fontWeight: FontWeight.w200,
                      ),
                    ),
                    Text(
                      '$linesCleared', // Display the actual high score
                      style: const TextStyle(
                        color: Colors.white,
                        fontFamily: 'SilkScreen',
                        fontSize: 35,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          'BACK TO HOME',
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'SilkScreen',
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      ElevatedButton(
                        style: kScoreScreenPlayButtonStyle,
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, GameBoard.id);
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(15.0),
                          child: Text(
                            'PLAY AGAIN',
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'SilkScreen',
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class Score extends StatelessWidget {
  static const String id = "score_screen";

  const Score({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, int> arguments =
        ModalRoute.of(context)?.settings.arguments as Map<String, int>;

    return ScoreScreen(
      userScore: arguments['userScore'] ?? 0,
      highScore: arguments['highScore'] ?? 0,
      linesCleared: arguments['linesCleared'] ?? 0,
    );
  }
}
