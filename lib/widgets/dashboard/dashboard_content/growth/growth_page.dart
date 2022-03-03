import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:momnotebook/constants/colors.dart';
import 'package:momnotebook/constants/sizeConfig.dart';

class GrowthPage extends StatelessWidget {
  const GrowthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            color: bluewhite,
            borderRadius: new BorderRadius.only(
              topLeft: const Radius.circular(30.0),
              topRight: const Radius.circular(30.0),
            )),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: SizeConfig.heightMultiplier * 2.5,
              ),
              Center(
                child: Text(
                  'Development',
                  style: TextStyle(
                      fontSize: SizeConfig.textMultiplier * 3,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w600,
                      color: Colors.black38),
                ),
              ),
              SizedBox(
                height: SizeConfig.heightMultiplier * 4.3,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 12),
                child: Text(
                  'Growth',
                  style: TextStyle(
                      fontSize: SizeConfig.textMultiplier * 2.5,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w600,
                      color: Colors.black38),
                ),
              ),
              SizedBox(
                height: SizeConfig.heightMultiplier * 2,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: SizeConfig.heightMultiplier * 16,
                      width: SizeConfig.widthMultiplier * 36,
                      decoration: BoxDecoration(
                          color: bblue, borderRadius: BorderRadius.circular(5)),
                      child: Center(
                          child: SvgPicture.asset(
                        'assets/icons/baby_growth.svg',
                        height: SizeConfig.heightMultiplier * 13,
                      )),
                    ),
                    SizedBox(
                      width: SizeConfig.widthMultiplier * 6,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Weight',
                              style: TextStyle(
                                  fontSize: SizeConfig.textMultiplier * 2,
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.w300,
                                  color: Colors.black38),
                            ),
                            SizedBox(
                              width: SizeConfig.widthMultiplier * 16,
                            ),
                            SizedBox(
                              width: SizeConfig.widthMultiplier * 14,
                              child: TextFormField(
                                  decoration: InputDecoration(
                                      enabledBorder: new UnderlineInputBorder(
                                          borderSide: new BorderSide(
                                              color: greyColor, width: 0.8)),
                                      hintText: '-')),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              'Height',
                              style: TextStyle(
                                  fontSize: SizeConfig.textMultiplier * 2,
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.w300,
                                  color: Colors.black38),
                            ),
                            SizedBox(
                              width: SizeConfig.widthMultiplier * 16,
                            ),
                            SizedBox(
                              width: SizeConfig.widthMultiplier * 14,
                              child: TextFormField(
                                  decoration: InputDecoration(
                                      enabledBorder: new UnderlineInputBorder(
                                          borderSide: new BorderSide(
                                              color: greyColor, width: 0.8)),
                                      hintText: '-')),
                            )
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: SizeConfig.heightMultiplier * 4,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 12),
                child: Text(
                  'Moments',
                  style: TextStyle(
                      fontSize: SizeConfig.textMultiplier * 2,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w500,
                      color: Colors.black38),
                ),
              ),
              SizedBox(
                height: SizeConfig.heightMultiplier * 4,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Container(
                  height: SizeConfig.heightMultiplier * 24,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image:
                              AssetImage('assets/images/moments_growth.png')),
                      borderRadius: BorderRadius.circular(15)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
