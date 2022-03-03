import 'package:flutter/material.dart';
import 'package:momnotebook/constants/sizeConfig.dart';

class OnWaitPage extends StatelessWidget {
  const OnWaitPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset(
          "assets/images/splashscreen.png",
          height: SizeConfig.imageSizeMultiplier * 74,
          width: SizeConfig.imageSizeMultiplier * 74,
        ),
      ),
    );
  }
}
