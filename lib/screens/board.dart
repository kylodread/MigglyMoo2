import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tetris/game_components/piece.dart';
import 'package:tetris/game_components/pixel.dart';
import 'package:tetris/game_components/values.dart';
import 'package:tetris/constants.dart';
import 'package:tetris/screens/score.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:shared_preferences/shared_preferences.dart';

List<List<Tetromino?>> gameBoard = List.generate(
  colLength,
  (i) => List.generate(
    rowLength,
    (j) => null,
  ),
);

class GameBoard extends StatefulWidget {
  static const String id = "board_screen";
  const GameBoard({super.key});

  @override
  State<GameBoard> createState() => _GameBoardState();
}

enum SwipeDirection {
  none,
  left,
  right,
  up,
  down,
}

Map<Tetromino, Color> tetrominoColors = {
  Tetromino.I: Colors.cyan,
  Tetromino.J: Colors.blue,
  Tetromino.L: Colors.orange,
  Tetromino.O: Colors.yellow,
  Tetromino.S: Colors.green,
  Tetromino.T: Colors.purple,
  Tetromino.Z: Colors.red,
};

class _GameBoardState extends State<GameBoard> {
  SwipeDirection swipeDirection = SwipeDirection.none;
  final player = AudioPlayer();
  Piece currentPiece = Piece(type: Tetromino.L);
  int currentScore = 0;
  int highScore = 0; // Track the high score
  bool gameOver = false;
  bool isPaused = false; // Track the pause state
  Timer? timer;
  int linesCleared = 0; // Track the number of lines cleared
  int linesClearedHighScore = 0; // Add this line to define the variable

  static const Duration fastDropDelay =
      Duration(milliseconds: 50); // Set the time delay for fast drop

  @override
  void dispose() {
    timer?.cancel();
    player.dispose(); // Dispose the audio player to release resources

    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    loadHighScores();
    startGame();
  }

  void startGame() {
    player.play(AssetSource('tetris_gameStart.wav'));
    currentPiece.initializePiece();
    resetScores(); // Reset the scores when starting a new game
    gameLoop(const Duration(milliseconds: 600));
  }

  void gameLoop(Duration frameRate) {
    timer = Timer.periodic(frameRate, (timer) {
      if (!isPaused && mounted) {
        setState(() {
          clearLines();
          checkLanding();

          if (gameOver) {
            timer.cancel();
            resetGame();
            player.play(AssetSource('tetris_gameOver.wav'));
            Navigator.pushReplacementNamed(
              context,
              Score.id,
              arguments: currentScore,
            );
          }
          currentPiece.movePiece(Direction.down);
        });
      }
    });
  }

  void togglePause() {
    setState(() {
      isPaused = !isPaused;
      if (isPaused) {
        timer?.cancel();
      } else {
        gameLoop(const Duration(milliseconds: 600));
      }
    });
  }

  void showGameOverDialog() async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Game Over'),
        content: Text(
            "Your score is: $currentScore\nLines cleared: $linesCleared"), // Display lines cleared in the dialog
        actions: [
          TextButton(
            onPressed: () {
              resetGame();
              Navigator.pop(context);
            },
            child: const Text('Play Again!'),
          ),
        ],
      ),
    );

    // Update the high score if needed
    if (currentScore > highScore) {
      setState(() {
        highScore = currentScore;
      });
      final prefs = await SharedPreferences.getInstance();
      prefs.setInt('highScore', highScore);
    }

    // Save the lines cleared high score
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('linesClearedHighScore', linesClearedHighScore);

    // ignore: use_build_context_synchronously
    Navigator.pushReplacementNamed(
      context,
      Score.id,
      arguments: {
        'userScore': currentScore,
        'highScore': highScore,
        'linesScleared': linesCleared,
        'linesClearedHighScore': linesClearedHighScore,
      },
    );
  }

  Future<void> loadHighScores() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      highScore = prefs.getInt('highScore') ?? 0;
      linesClearedHighScore = prefs.getInt('linesClearedHighScore') ?? 0;
    });
  }

  void resetGame() {
    gameBoard = List.generate(
      colLength,
      (i) => List.generate(
        rowLength,
        (j) => null,
      ),
    );

    gameOver = false;
    resetScores(); // Reset the scores when starting a new game
    createNewPiece();
  }

  void resetScores() {
    setState(() {
      currentScore = 0;
      linesCleared = 0;
    });
  }

  bool checkCollision(Direction direction) {
    for (int i = 0; i < currentPiece.position.length; i++) {
      int row = (currentPiece.position[i] / rowLength).floor();
      int col = (currentPiece.position[i] % rowLength);

      if (direction == Direction.left) {
        col -= 1;
      } else if (direction == Direction.right) {
        col += 1;
      } else if (direction == Direction.down) {
        row += 1;
      }

      if (row >= colLength ||
          col < 0 ||
          col >= rowLength ||
          (row >= 0 &&
              col >= 0 &&
              row < colLength &&
              col < rowLength &&
              gameBoard[row][col] != null)) {
        return true;
      }
    }
    return false;
  }

  void checkLanding() {
    if (checkCollision(Direction.down)) {
      for (int i = 0; i < currentPiece.position.length; i++) {
        int row = (currentPiece.position[i] / rowLength).floor();
        int col = (currentPiece.position[i] % rowLength);

        if (row >= 0 && col >= 0) {
          gameBoard[row][col] = currentPiece.type;
        }
      }

      player.play(AssetSource('tetris_landing.wav'));
      createNewPiece();
    }
  }

  void createNewPiece() {
    Random rand = Random();
    Tetromino randomType =
        Tetromino.values[rand.nextInt(Tetromino.values.length)];
    currentPiece = Piece(type: randomType);
    currentPiece.initializePiece();

    if (isGameOver()) {
      gameOver = true;
    }
  }

  void clearLines() {
    for (int row = colLength - 1; row >= 0; row--) {
      bool rowIsFull = true;

      for (int col = 0; col < rowLength; col++) {
        if (gameBoard[row][col] == null) {
          rowIsFull = false;
          break;
        }
      }

      if (rowIsFull) {
        for (int r = row; r > 0; r--) {
          gameBoard[r] = List.from(gameBoard[r - 1]);
        }

        gameBoard[0] = List.generate(rowLength, (index) => null);

        player.play(AssetSource('tetris_clearLine.wav'));
        currentScore += 10;
        linesCleared++; // Increment the lines cleared count
      }
    }
  }

  bool isGameOver() {
    for (int col = 0; col < rowLength; col++) {
      if (gameBoard[0][col] != null) {
        return true;
      }
    }
    return false;
  }

  void onSwipeLeft() {
    if (swipeDirection != SwipeDirection.left) {
      swipeDirection = SwipeDirection.left;
      moveLeft();
    }
  }

  void onSwipeRight() {
    if (swipeDirection != SwipeDirection.right) {
      swipeDirection = SwipeDirection.right;
      moveRight();
    }
  }

  void onSwipeDown() {
    if (swipeDirection != SwipeDirection.down) {
      swipeDirection = SwipeDirection.down;
      moveDown();
    }
  }

  void onSwipeUp() {
    if (swipeDirection != SwipeDirection.up) {
      swipeDirection = SwipeDirection.up;
      rotatePiece();
    }
  }

  void resetSwipe() {
    swipeDirection = SwipeDirection.none;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        const Text(
                          'Score / HS',
                          style: TextStyle(
                            fontSize: 14, // Smaller font size
                            color: Colors.white,
                            fontFamily: 'Silkscreen',
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          '$currentScore / $highScore',
                          style: const TextStyle(
                            fontSize: 18, // Smaller font size
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontFamily: 'Silkscreen',
                          ),
                        ),
                      ],
                    ),
                    FloatingActionButton(
                      onPressed: togglePause,
                      child: Icon(isPaused ? Icons.play_arrow : Icons.pause),
                    ),
                    Column(
                      children: [
                        const Text(
                          'Lines / HS',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                            fontFamily: 'Silkscreen',
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          '$linesCleared / $linesClearedHighScore',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontFamily: 'Silkscreen',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: Container(
                margin: const EdgeInsets.only(
                    top: 0, right: 40, left: 40, bottom: 8),
                decoration: const BoxDecoration(
                  color: Color(0xFF222831),
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                child: Material(
                  elevation: 10,
                  borderRadius: const BorderRadius.all(Radius.circular(30)),
                  color: Colors.transparent,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 31, left: 10, right: 10, bottom: 31),
                    child: Material(
                      elevation: 5,
                      color: Colors.transparent,
                      child: Container(
                        decoration: const BoxDecoration(
                          border: Border.symmetric(
                            horizontal: BorderSide(
                              width: 1.0,
                              color: Color(0xFF393E46),
                            ),
                          ),
                        ),
                        child: GridView.builder(
                            itemCount: rowLength * colLength,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: rowLength),
                            itemBuilder: (context, index) {
                              int row = (index / rowLength).floor();
                              int col = (index % rowLength);

                              if (currentPiece.position.contains(index)) {
                                return Pixel(
                                  colour: tetrominoColors[currentPiece.type] ??
                                      Colors.white,
                                  childWidget: index,
                                );
                              } else if (gameBoard[row][col] != null) {
                                final Tetromino? tetrominoType =
                                    gameBoard[row][col];
                                return Pixel(
                                    colour: tetrominoColors[tetrominoType] ??
                                        Colors.white,
                                    childWidget: index);
                              } else {
                                return Pixel(
                                    colour: Colors.transparent,
                                    childWidget: index);
                              }
                            }),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.only(left: 50, right: 50, bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      style: kMovingButtonStyle.copyWith(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                      onPressed: moveDown,
                      child: const Icon(
                        Icons.keyboard_arrow_down,
                        size: 30,
                      ),
                    ),
                    ElevatedButton(
                      style: kMovingButtonStyle.copyWith(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              bottomLeft: Radius.circular(20),
                            ),
                          ),
                        ),
                      ),
                      onPressed: moveLeft,
                      child: const Icon(
                        Icons.arrow_back_ios,
                      ),
                    ),
                    ElevatedButton(
                      style: kMovingButtonStyle.copyWith(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(20),
                              bottomRight: Radius.circular(20),
                            ),
                          ),
                        ),
                      ),
                      onPressed: moveRight,
                      child: const Icon(
                        Icons.arrow_forward_ios,
                      ),
                    ),
                    ElevatedButton(
                      style: kMovingButtonStyle.copyWith(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                      onPressed: rotatePiece,
                      child: const Icon(
                        Icons.rotate_right,
                        size: 30,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void moveLeft() {
    player.play(AssetSource('tetris_move.wav'));
    if (!checkCollision(Direction.left)) {
      setState(() {
        currentPiece.movePiece(Direction.left);
      });
    }
  }

  void moveRight() {
    player.play(AssetSource('tetris_move.wav'));
    if (!checkCollision(Direction.right)) {
      setState(() {
        currentPiece.movePiece(Direction.right);
      });
    }
  }

  void moveDown() {
    player.play(AssetSource('tetris_move.wav'));
    while (!checkCollision(Direction.down)) {
      setState(() {
        currentPiece.movePiece(Direction.down);
      });
      Future.delayed(fastDropDelay, () {});
    }
    checkLanding(); // Perform the landing logic after the fast drop ends
  }

  void rotatePiece() {
    if (!checkCollision(Direction.left) && !checkCollision(Direction.right)) {
      currentPiece.rotatePiece();
    }
  }
}
