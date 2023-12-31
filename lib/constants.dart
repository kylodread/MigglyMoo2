import 'package:flutter/material.dart';

// home screen
const kHomeScreenDisplayTextStyle = TextStyle(
  fontSize: 35,
  fontWeight: FontWeight.w900,
  fontFamily: 'Silkscreen',
  color: Color(0xFF222831),
  // color: Colors.white,
);

final kHomeScreenElevatedButtonStyle = ButtonStyle(
  // Customize button height and width
  minimumSize: MaterialStateProperty.all(const Size(250, 50)),

  // Customize button background color
  backgroundColor: MaterialStateProperty.all(const Color(0xFF393E46)),

  // Customize button border radius
  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
    RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
  ),
);

// game board screen
final kMovingButtonStyle = ButtonStyle(
  fixedSize: MaterialStateProperty.all(const Size(50, 50)),
  elevation: MaterialStateProperty.all(5),
  backgroundColor: MaterialStateProperty.all(const Color(0xFF393E46)),
);

//score screen
const kScoreScreenDisplayTextStyle = TextStyle(
  fontSize: 45,
  fontFamily: 'SilkScreen',
  color: Color(0xFF36FE63),
  fontWeight: FontWeight.w600,
);

final kScoreScreenPlayButtonStyle = ButtonStyle(
  backgroundColor: MaterialStateProperty.all(const Color(0xFF36FE63)),
  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
    RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    ),
  ),
);
