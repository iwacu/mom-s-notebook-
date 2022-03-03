import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:momnotebook/constants/colors.dart';
import 'package:momnotebook/constants/sizeConfig.dart';
import 'package:momnotebook/cubit/cubit/auth_cubit_cubit.dart';
import 'package:momnotebook/cubit/cubit/home_page_cubit.dart';
import 'package:momnotebook/models/baby.dart';
import 'package:momnotebook/services/notification_services/notification_services.dart';

class ProfilePage extends StatelessWidget {
  calculateAge(DateTime birthDate) {
    DateTime currentDate = DateTime.now();
    int age = currentDate.year - birthDate.year;
    int month1 = currentDate.month;
    int month2 = birthDate.month;
    if (month2 > month1) {
      age--;
    } else if (month1 == month2) {
      int day1 = currentDate.day;
      int day2 = birthDate.day;
      if (day2 > day1) {
        age--;
      }
    }
    return age;
  }

  List<String> _languages = ['English'];
  List<String> _notification = ['Daily', 'Weekly', 'Monthly', 'Off'];
  String? _value;
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: BlocBuilder<AuthCubitCubit, AuthCubitState>(
          builder: (context, state) {
            if (state is AuthCubitInitial) {
              return Center(
                child: Text('Loading'),
              );
            } else if (state is AuthCubitUser) {
              return Container(
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
                        height: SizeConfig.heightMultiplier * 4,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 12),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Baby',
                              style: TextStyle(
                                  fontSize: SizeConfig.textMultiplier * 2.5,
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black38),
                            ),
                            Spacer(),
                            GestureDetector(
                              onTap: () => Navigator.of(context)
                                  .pushNamed('/add_new_baby'),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.add,
                                    color: buttonBGColor,
                                  ),
                                  SizedBox(
                                    width: SizeConfig.widthMultiplier * 1.2,
                                  ),
                                  Text(
                                    'Add baby',
                                    style: TextStyle(
                                        fontSize: SizeConfig.textMultiplier * 2,
                                        fontFamily: 'Montserrat',
                                        fontWeight: FontWeight.w300,
                                        color: buttonBGColor),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: GestureDetector(
                          onTap: () => Navigator.of(context).pushNamed(
                              '/baby_update',
                              arguments: {'baby': state.baby}),
                          child: Container(
                            decoration: BoxDecoration(
                                color: primaryColor,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: buttonBGColor)),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 12),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  state.baby.picture == ''
                                      ? Container(
                                          padding: EdgeInsets.all(
                                              SizeConfig.heightMultiplier *
                                                  1.5),
                                          height:
                                              SizeConfig.heightMultiplier * 6,
                                          width:
                                              SizeConfig.widthMultiplier * 10,
                                          decoration: BoxDecoration(
                                            // color: kSecondaryColor.withOpacity(0.1),
                                            image: DecorationImage(
                                                image: AssetImage(
                                                    'assets/images/user_icon.png')),
                                            shape: BoxShape.circle,
                                          ),
                                        )
                                      : CircleAvatar(
                                          backgroundImage: FileImage(
                                              File(state.baby.picture)),
                                          radius:
                                              SizeConfig.widthMultiplier * 7,
                                          backgroundColor: Colors.white,
                                        ),
                                  SizedBox(
                                    width: SizeConfig.widthMultiplier * 6,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 8),
                                        child: Text(
                                          '${state.baby.name}',
                                          style: TextStyle(
                                              fontSize:
                                                  SizeConfig.textMultiplier *
                                                      2.5,
                                              fontFamily: 'Montserrat',
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black38),
                                        ),
                                      ),
                                      Text(
                                        '${getTheKidsAge(state.baby.birthDay).years}y ${getTheKidsAge(state.baby.birthDay).months}month ${getTheKidsAge(state.baby.birthDay).days}dys',
                                        style: TextStyle(
                                            fontSize:
                                                SizeConfig.textMultiplier * 2,
                                            fontFamily: 'Montserrat',
                                            fontWeight: FontWeight.w300,
                                            color: Colors.black38),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: SizeConfig.heightMultiplier * 3,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 12),
                        child: Text(
                          'Preferences',
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
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 12),
                        child: Container(
                          decoration: BoxDecoration(
                            color: ggrey,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 12),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      'Pick Baby',
                                      style: TextStyle(
                                          fontSize:
                                              SizeConfig.textMultiplier * 1.8,
                                          fontFamily: 'Montserrat',
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black38),
                                    ),
                                    Spacer(),
                                    SizedBox(
                                      width: SizeConfig.widthMultiplier * 30,
                                      child: DropdownButtonFormField<Baby>(
                                          value: state.babies
                                              .where((element) =>
                                                  element.id ==
                                                  state.user.babyId)
                                              .single,
                                          onChanged: (value) {
                                            BlocProvider.of<AuthCubitCubit>(
                                                    context)
                                                .updateUser(
                                                    state.user, value!.id!);
                                            BlocProvider.of<HomePageCubit>(
                                                    context)
                                                .getBabyTasks();
                                          },
                                          decoration: InputDecoration(
                                            enabledBorder: InputBorder.none,
                                          ),
                                          items: state.babies.map(
                                            (val) {
                                              return DropdownMenuItem<Baby>(
                                                child: Text(
                                                  val.name,
                                                  style: TextStyle(
                                                      fontSize: SizeConfig
                                                              .textMultiplier *
                                                          1.8,
                                                      fontFamily: 'Montserrat',
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Colors.black),
                                                ),
                                                value: val,
                                              );
                                            },
                                          ).toList()),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child: Divider(
                                  thickness: 0.3,
                                  color: Colors.black38,
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 12),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      'Language',
                                      style: TextStyle(
                                          fontSize:
                                              SizeConfig.textMultiplier * 1.8,
                                          fontFamily: 'Montserrat',
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black38),
                                    ),
                                    Spacer(),
                                    SizedBox(
                                      width: SizeConfig.widthMultiplier * 30,
                                      child: DropdownButtonFormField(
                                          value: _languages[0],
                                          onChanged: (val) {
                                            print(val);
                                          },
                                          decoration: InputDecoration(
                                            enabledBorder: InputBorder.none,
                                          ),
                                          hint: Text(
                                            'English',
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontSize:
                                                    SizeConfig.textMultiplier *
                                                        1.8,
                                                fontFamily: 'Montserrat',
                                                fontWeight: FontWeight.w600,
                                                color: Colors.black),
                                          ),
                                          items: _languages.map(
                                            (val) {
                                              return DropdownMenuItem<String>(
                                                child: Text(
                                                  val,
                                                  style: TextStyle(
                                                      fontSize: SizeConfig
                                                              .textMultiplier *
                                                          1.8,
                                                      fontFamily: 'Montserrat',
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Colors.black),
                                                ),
                                                value: val,
                                              );
                                            },
                                          ).toList()),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child: Divider(
                                  thickness: 0.3,
                                  color: Colors.black38,
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 12),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      'Show Notifications',
                                      style: TextStyle(
                                          fontSize:
                                              SizeConfig.textMultiplier * 1.8,
                                          fontFamily: 'Montserrat',
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black38),
                                    ),
                                    Spacer(),
                                    SizedBox(
                                      width: SizeConfig.widthMultiplier * 30,
                                      child: DropdownButtonFormField<String>(
                                          value: _notification[0],
                                          onChanged: (val) {
                                            NotifyHelper()
                                                .requestIOSPermissions();
                                          },
                                          decoration: InputDecoration(
                                            enabledBorder: InputBorder.none,
                                          ),
                                          hint: Text(
                                            'Daily',
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontSize:
                                                    SizeConfig.textMultiplier *
                                                        1.8,
                                                fontFamily: 'Montserrat',
                                                fontWeight: FontWeight.w600,
                                                color: Colors.black),
                                          ),
                                          items: _notification.map(
                                            (val) {
                                              return DropdownMenuItem<String>(
                                                child: Text(
                                                  val,
                                                  style: TextStyle(
                                                      fontSize: SizeConfig
                                                              .textMultiplier *
                                                          1.8,
                                                      fontFamily: 'Montserrat',
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Colors.black),
                                                ),
                                                value: val,
                                              );
                                            },
                                          ).toList()),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: SizeConfig.heightMultiplier * 2,
                              ),
                            ],
                          ),
                        ),
                      ),
                      // SizedBox(
                      //   height: SizeConfig.heightMultiplier * 3,
                      // ),
                      // Padding(
                      //   padding: const EdgeInsets.symmetric(
                      //       horizontal: 12, vertical: 12),
                      //   child: Text(
                      //     'Growth Units',
                      //     style: TextStyle(
                      //         fontSize: SizeConfig.textMultiplier * 2.5,
                      //         fontFamily: 'Montserrat',
                      //         fontWeight: FontWeight.w600,
                      //         color: Colors.black38),
                      //   ),
                      // ),
                      // SizedBox(
                      //   height: SizeConfig.heightMultiplier * 2,
                      // ),
                      // Padding(
                      //   padding: const EdgeInsets.symmetric(
                      //       horizontal: 12, vertical: 12),
                      //   child: Container(
                      //     decoration: BoxDecoration(
                      //       color: ggrey,
                      //       borderRadius: BorderRadius.circular(12),
                      //     ),
                      //     child: Column(
                      //       crossAxisAlignment: CrossAxisAlignment.start,
                      //       children: [
                      //         Padding(
                      //           padding:
                      //               const EdgeInsets.symmetric(horizontal: 12),
                      //           child: Row(
                      //             mainAxisAlignment:
                      //                 MainAxisAlignment.spaceEvenly,
                      //             children: [
                      //               Text(
                      //                 'Weight',
                      //                 style: TextStyle(
                      //                     fontSize:
                      //                         SizeConfig.textMultiplier * 1.8,
                      //                     fontFamily: 'Montserrat',
                      //                     fontWeight: FontWeight.w600,
                      //                     color: Colors.black38),
                      //               ),
                      //               Spacer(),
                      //               SizedBox(
                      //                 width: SizeConfig.widthMultiplier * 30,
                      //                 child: DropdownButtonFormField(
                      //                     decoration: InputDecoration(
                      //                       enabledBorder: InputBorder.none,
                      //                     ),
                      //                     hint: Text(
                      //                       'Kilogram(kg)',
                      //                       overflow: TextOverflow.ellipsis,
                      //                       style: TextStyle(
                      //                           fontSize:
                      //                               SizeConfig.textMultiplier *
                      //                                   1.8,
                      //                           fontFamily: 'Montserrat',
                      //                           fontWeight: FontWeight.w600,
                      //                           color: Colors.black),
                      //                     ),
                      //                     items: []),
                      //               )
                      //             ],
                      //           ),
                      //         ),
                      //         Padding(
                      //           padding:
                      //               const EdgeInsets.symmetric(horizontal: 8),
                      //           child: Divider(
                      //             thickness: 0.3,
                      //             color: Colors.black38,
                      //           ),
                      //         ),
                      //         Padding(
                      //           padding:
                      //               const EdgeInsets.symmetric(horizontal: 12),
                      //           child: Row(
                      //             mainAxisAlignment:
                      //                 MainAxisAlignment.spaceEvenly,
                      //             children: [
                      //               Text(
                      //                 'Height',
                      //                 style: TextStyle(
                      //                     fontSize:
                      //                         SizeConfig.textMultiplier * 1.8,
                      //                     fontFamily: 'Montserrat',
                      //                     fontWeight: FontWeight.w600,
                      //                     color: Colors.black38),
                      //               ),
                      //               Spacer(),
                      //               SizedBox(
                      //                 width: SizeConfig.widthMultiplier * 30,
                      //                 child: DropdownButtonFormField(
                      //                     decoration: InputDecoration(
                      //                       enabledBorder: InputBorder.none,
                      //                     ),
                      //                     hint: Text(
                      //                       'Centimeter (cm)',
                      //                       overflow: TextOverflow.ellipsis,
                      //                       style: TextStyle(
                      //                           fontSize:
                      //                               SizeConfig.textMultiplier *
                      //                                   1.4,
                      //                           fontFamily: 'Montserrat',
                      //                           color: Colors.black38,
                      //                           fontWeight: FontWeight.w500),
                      //                     ),
                      //                     items: []),
                      //               )
                      //             ],
                      //           ),
                      //         ),
                      //         SizedBox(
                      //           height: SizeConfig.heightMultiplier * 2,
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
              );
            }
            return Container();
          },
        ));
  }
}

KidsAge getTheKidsAge(String birthday) {
  if (birthday != '') {
    var birthDate = DateTime.tryParse(birthday);
    if (birthDate != null) {
      final now = new DateTime.now();

      int years = now.year - birthDate.year;
      int months = now.month - birthDate.month;
      int days = now.day - birthDate.day;

      if (months < 0 || (months == 0 && days < 0)) {
        years--;
        months += (days < 0 ? 11 : 12);
      }

      if (days < 0) {
        final monthAgo = new DateTime(now.year, now.month - 1, birthDate.day);
        days = now.difference(monthAgo).inDays + 1;
      }

      return KidsAge(years: years, months: months, days: days);
    } else {
      print('getTheKidsAge: not a valid date');
    }
  } else {
    print('getTheKidsAge: date is empty');
  }
  return KidsAge();
}

class KidsAge {
  int years;
  int months;
  int days;
  KidsAge({this.years = 0, this.months = 0, this.days = 0});
}
