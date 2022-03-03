import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:momnotebook/constants/sizeConfig.dart';
import 'package:momnotebook/cubit/cubit/auth_cubit_cubit.dart';
import 'package:momnotebook/models/baby.dart';

import 'boxIcon.dart';

appBar(BuildContext context, String text, GestureTapCallback press) {
  return SafeArea(
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 18, vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          BoxIcon(
            svgSrc: 'assets/icons/back-icon.svg',
            numOfitem: 0,
            press: () => Navigator.pop(context),
          ),
          Text(
            text,
            style: TextStyle(
                fontSize: SizeConfig.textMultiplier * 2.3,
                fontFamily: 'Muli',
                color: Colors.black38),
          ),
        ],
      ),
    ),
  );
}

appBarM(BuildContext context, String text, GestureTapCallback press,
    GestureTapCallback reset) {
  return SafeArea(
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 18, vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          BoxIcon(
            svgSrc: 'assets/icons/back-icon.svg',
            numOfitem: 0,
            press: () => Navigator.pop(context),
          ),
          SizedBox(
            width: SizeConfig.widthMultiplier * 6,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 3),
            child: Text(
              text,
              style: TextStyle(
                  fontSize: SizeConfig.textMultiplier * 3,
                  fontFamily: 'Montserrat',
                  color: Colors.black38),
            ),
          ),
          Spacer(),
          BoxIcon(
            svgSrc: 'assets/icons/delete-icon.svg',
            numOfitem: 0,
            press: () => Navigator.pop(context),
          )
        ],
      ),
    ),
  );
}

appBarDashboard(
    BuildContext context, GestureTapCallback press, GestureTapCallback reset) {
  return BlocBuilder<AuthCubitCubit, AuthCubitState>(
    builder: (context, state) {
      if (state is AuthCubitInitial) {
        return Center(child: Text('A moment Please'));
      } else if (state is AuthCubitUser) {
        return Container(
          color: Colors.white,
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 18, vertical: 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  state.baby.picture == ''
                      ? Container(
                          padding:
                              EdgeInsets.all(SizeConfig.heightMultiplier * 1.5),
                          height: SizeConfig.heightMultiplier * 6,
                          width: SizeConfig.widthMultiplier * 10,
                          decoration: BoxDecoration(
                            // color: kSecondaryColor.withOpacity(0.1),
                            image: DecorationImage(
                                image:
                                    AssetImage('assets/images/user_icon.png')),
                            shape: BoxShape.circle,
                          ),
                        )
                      : CircleAvatar(
                          backgroundImage: FileImage(File(state.baby.picture)),
                          radius: SizeConfig.widthMultiplier * 5,
                          backgroundColor: Colors.white,
                        ),
                  SizedBox(
                    width: SizeConfig.widthMultiplier * 4,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(state.baby.name,
                        style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: SizeConfig.textMultiplier * 2.8,
                            fontWeight: FontWeight.bold,
                            color: Colors.black38)),
                  ),
                ],
              ),
            ),
          ),
        );
      }
      return Container();
    },
  );
}

appBarDashboardAccount(BuildContext context, String text,
    GestureTapCallback press, GestureTapCallback reset) {
  return Container(
    color: Colors.white,
    child: SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
                fontSize: SizeConfig.textMultiplier * 3,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w700,
                color: Colors.black38),
          ),
        ),
      ),
    ),
  );
}

appBarDashboardW(Baby baby, BuildContext context, GestureTapCallback press,
    GestureTapCallback reset) {
  return Container(
    color: Colors.white,
    child: SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BoxIcon(
              svgSrc: 'assets/icons/back-icon.svg',
              numOfitem: 0,
              press: () => Navigator.pop(context),
            ),
            SizedBox(
              width: SizeConfig.widthMultiplier * 6,
            ),
            baby.picture == ''
                ? Container(
                    padding: EdgeInsets.all(SizeConfig.heightMultiplier * 1.5),
                    height: SizeConfig.heightMultiplier * 6,
                    width: SizeConfig.widthMultiplier * 10,
                    decoration: BoxDecoration(
                      // color: kSecondaryColor.withOpacity(0.1),
                      image: DecorationImage(
                          image: AssetImage('assets/images/user_icon.png')),
                      shape: BoxShape.circle,
                    ),
                  )
                : CircleAvatar(
                    backgroundImage: FileImage(File(baby.picture)),
                    radius: SizeConfig.widthMultiplier * 5,
                    backgroundColor: Colors.white,
                  ),
            SizedBox(
              width: SizeConfig.widthMultiplier * 6,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                baby.name,
                style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold,
                    fontSize: SizeConfig.textMultiplier * 2.8,
                    color: Colors.black38),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

appBarDashboardUD(Baby baby, BuildContext context, GestureTapCallback delete) {
  return Container(
    color: Colors.white,
    child: SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BoxIcon(
              svgSrc: 'assets/icons/back-icon.svg',
              numOfitem: 0,
              press: () => Navigator.pop(context),
            ),
            SizedBox(
              width: SizeConfig.widthMultiplier * 6,
            ),
            baby.picture == ''
                ? Container(
                    padding: EdgeInsets.all(SizeConfig.heightMultiplier * 1.5),
                    height: SizeConfig.heightMultiplier * 4,
                    width: SizeConfig.widthMultiplier * 8,
                    decoration: BoxDecoration(
                      // color: kSecondaryColor.withOpacity(0.1),
                      image: DecorationImage(
                          image: AssetImage('assets/images/user_icon.png')),
                      shape: BoxShape.circle,
                    ),
                  )
                : CircleAvatar(
                    backgroundImage: FileImage(File(baby.picture)),
                    radius: SizeConfig.widthMultiplier * 5,
                    backgroundColor: Colors.white,
                  ),
            SizedBox(
              width: SizeConfig.widthMultiplier * 2,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                baby.name,
                style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold,
                    fontSize: SizeConfig.textMultiplier * 2.8,
                    color: Colors.black38),
              ),
            ),
            Spacer(),
            BoxIcon(
              svgSrc: 'assets/icons/delete-icon.svg',
              numOfitem: 0,
              press: delete,
            ),
          ],
        ),
      ),
    ),
  );
}

class CustomAppBar extends PreferredSize {
  @override
  final Widget child;
  final double height;

  CustomAppBar({
    required this.height,
    required this.child,
  }) : super(child: child, preferredSize: Size.fromHeight(height));

  @override
  Widget build(BuildContext context) => child;
}
