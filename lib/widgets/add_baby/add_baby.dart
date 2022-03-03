import 'package:flutter/material.dart';
import 'package:momnotebook/constants/defaultButton.dart';
import 'package:momnotebook/constants/sizeConfig.dart';

class AddBaby extends StatelessWidget {
  const AddBaby({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            SizedBox(
              height: SizeConfig.heightMultiplier * 8,
            ),
            Center(
              child: Image.asset(
                "assets/images/baby_1.png",
                height: SizeConfig.imageSizeMultiplier * 74,
                width: SizeConfig.imageSizeMultiplier * 74,
              ),
            ),
            SizedBox(
              height: SizeConfig.heightMultiplier * 2,
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: Text(
                  "If you are here, means some adorable baby needs your attention That's so exiting!! Let us help with the routine writing, so you could put all your love to the cute one! Tell us more about your baby!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: 'Montserrat', fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Spacer(),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.widthMultiplier * 8),
              child: DefaultButtonBsz(
                text: 'Add My Baby',
                press: () => Navigator.of(context).pushNamed('/add_baby_form'),
              ),
            ),
            SizedBox(
              height: SizeConfig.heightMultiplier * 7,
            ),
          ],
        ),
      ),
    );
  }
}
