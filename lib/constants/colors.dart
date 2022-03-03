import 'package:flutter/material.dart';

// for hex color
class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}

String capitalize(String text) {
  return "${text[0].toUpperCase()}${text.substring(1)}";
}

const primaryColor = Colors.white;
Color buttonBGColor = HexColor("#4EA7F2");
Color greyColor = HexColor("#EEEEEE");
Color gryColor = HexColor("#D4D4D4");
Color almostGrey = HexColor('#E1E1E1');
Color greyOrange = HexColor("#EE8888");
Color whiteGrey = HexColor('#F9F9F9');
Color bluewhite = HexColor("#f4f6f9");
Color greenGray = HexColor('#58C2AB');
Color movGray = HexColor('#7355B6');
Color orGray = HexColor('#F69601');
Color rsGray = HexColor('#E33F7B');
Color greenAccGray = HexColor('#80B239');
Color jnAccGray = HexColor('#D7A913');
Color greyText = HexColor("#232323");
Color bblue = HexColor('#4EA7F2');

Color ggrey = HexColor('#F1F1F1');

// box decoration

BoxDecoration boxDecoration = BoxDecoration(
  borderRadius: BorderRadius.circular(15),
  color: buttonBGColor,
);
