import 'package:flutter/material.dart';
import 'package:momnotebook/constants/sizeConfig.dart';

class SplashContent extends StatelessWidget {
  const SplashContent({
    Key? key,
    this.text,
    this.title,
    this.image,
  }) : super(key: key);
  final String? text, title, image;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Image.asset(
          image!,
          height: SizeConfig.imageSizeMultiplier * 74,
          width: SizeConfig.imageSizeMultiplier * 74,
        ),
        Spacer(flex: 2),
        Text(
          title!,
          textAlign: TextAlign.center,
          style:
              TextStyle(fontFamily: 'Montserrat', fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: SizeConfig.heightMultiplier * 1.5,
        ),
        Text(
          text!,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Montserrat',
            color: Colors.black38,
          ),
        ),
      ],
    );
  }
}
