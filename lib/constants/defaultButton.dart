import 'package:flutter/material.dart';
import 'package:momnotebook/constants/colors.dart';
import 'package:momnotebook/constants/sizeConfig.dart';

class DefaultButton extends StatelessWidget {
  const DefaultButton({
    Key? key,
    this.text,
    this.press,
  }) : super(key: key);
  final String? text;
  final GestureTapCallback? press;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: SizeConfig.widthMultiplier * 48,
      height: SizeConfig.heightMultiplier * 8,
      child: GestureDetector(
        onTap: press,
        child: Container(
          decoration: boxDecoration,
          child: Center(
            child: Text(
              text!,
              style: TextStyle(
                  fontSize: 18,
                  color: primaryColor,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w500),
            ),
          ),
        ),
      ),
    );
  }
}

class DefaultButtonBsz extends StatelessWidget {
  const DefaultButtonBsz({
    Key? key,
    this.text,
    this.press,
  }) : super(key: key);
  final String? text;
  final GestureTapCallback? press;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: SizeConfig.heightMultiplier * 8,
      child: GestureDetector(
        onTap: press,
        child: Container(
          decoration: boxDecoration,
          child: Center(
            child: Text(
              text!,
              style: TextStyle(
                  fontSize: 18,
                  color: primaryColor,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w500),
            ),
          ),
        ),
      ),
    );
  }
}

class DefaultButtonNoColor extends StatelessWidget {
  const DefaultButtonNoColor({
    Key? key,
    this.text,
    this.press,
  }) : super(key: key);
  final String? text;
  final GestureTapCallback? press;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: SizeConfig.widthMultiplier * 48,
      height: SizeConfig.heightMultiplier * 8,
      child: GestureDetector(
        onTap: press,
        child: Container(
          // decoration: boxDecoration,
          child: Center(
            child: Text(
              text!,
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w700),
            ),
          ),
        ),
      ),
    );
  }
}
