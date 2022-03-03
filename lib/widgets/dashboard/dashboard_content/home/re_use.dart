// // import 'package:flutter/material.dart';
// // import 'package:flutter_svg/flutter_svg.dart';
// // import 'package:intl/intl.dart';
// // import 'package:jiffy/jiffy.dart';
// // import 'package:momnotebook/constants/colors.dart';
// // import 'package:momnotebook/constants/sizeConfig.dart';

// // class HomePage extends StatelessWidget {
// //   HomePage({Key? key}) : super(key: key);
// //   List<Map<String, dynamic>> splashData = [
// //     {
// //       "title": "Sleeping",
// //       "image": "assets/icons/sleeping.svg",
// //       "color": greenGray
// //     },
// //     {"title": "Feeder", "image": "assets/icons/feeder.svg", "color": movGray},
// //     {
// //       "title": "Breast \nPumping",
// //       "image": "assets/icons/breast-pumping.svg",
// //       "color": orGray
// //     },
// //     {
// //       "title": "Breast \nFeed",
// //       "image": "assets/icons/breast-feed.svg",
// //       "color": rsGray
// //     },
// //     {"title": "Food", "image": "assets/icons/food.svg", "color": buttonBGColor},
// //     {
// //       "title": "Diaper",
// //       "image": "assets/icons/diaper.svg",
// //       "color": greenAccGray
// //     },
// //     {
// //       "title": "Walking",
// //       "image": "assets/icons/walking.svg",
// //       "color": jnAccGray
// //     }
// //   ];
// //   DateTime _todayDate = DateTime.now();
// //   List<Map<String, Object>> get mapValues {
// //     return List.generate(23, (index) {
// //       var list = new List<int>.generate(23, (i) => i + 1);

// //       return {'hour': list[index]};
// //     });
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Container(
// //       color: Colors.white,
// //       child: Container(
// //         height: MediaQuery.of(context).size.height,
// //         decoration: BoxDecoration(
// //             color: bluewhite,
// //             borderRadius: new BorderRadius.only(
// //               topLeft: const Radius.circular(30.0),
// //               topRight: const Radius.circular(30.0),
// //             )),
// //         child: SingleChildScrollView(
// //           child: Column(
// //             crossAxisAlignment: CrossAxisAlignment.start,
// //             children: [
// //               Padding(
// //                 padding: const EdgeInsets.only(top: 18, left: 12),
// //                 child: Container(
// //                   height: SizeConfig.heightMultiplier * 18,
// //                   child: ListView.builder(
// //                       scrollDirection: Axis.horizontal,
// //                       itemCount: splashData.length,
// //                       itemBuilder: (context, index) {
// //                         return Column(
// //                           children: [
// //                             Container(
// //                               height: SizeConfig.heightMultiplier * 8,
// //                               width: SizeConfig.widthMultiplier * 18,
// //                               decoration: BoxDecoration(
// //                                   color: splashData[index]['color'],
// //                                   shape: BoxShape.circle),
// //                               child: Center(
// //                                 child: SvgPicture.asset(
// //                                   splashData[index]['image']!,
// //                                   height: SizeConfig.heightMultiplier * 4,
// //                                 ),
// //                               ),
// //                             ),
// //                             SizedBox(
// //                               height: SizeConfig.heightMultiplier * 1.5,
// //                             ),
// //                             Text(
// //                               splashData[index]['title']!,
// //                               style: TextStyle(
// //                                   fontSize: SizeConfig.textMultiplier * 2,
// //                                   color: Colors.black38,
// //                                   fontFamily: 'Montserrat',
// //                                   fontWeight: FontWeight.w500),
// //                             )
// //                           ],
// //                         );
// //                       }),
// //                 ),
// //               ),
// //               SizedBox(
// //                 height: SizeConfig.heightMultiplier * 2,
// //               ),
// //               Padding(
// //                 padding: const EdgeInsets.only(left: 12),
// //                 child: Text(
// //                   'Today ${Jiffy(_todayDate).MMMEd}',
// //                   style: TextStyle(
// //                       fontSize: SizeConfig.textMultiplier * 2,
// //                       color: buttonBGColor,
// //                       fontFamily: 'Montserrat',
// //                       fontWeight: FontWeight.w500),
// //                 ),
// //               ),
// //               SizedBox(
// //                 height: SizeConfig.heightMultiplier * 2,
// //               ),
// //               Container(
// //                 height: SizeConfig.heightMultiplier * 18,
// //                 decoration: BoxDecoration(color: bluewhite),
// //                 child: Padding(
// //                   padding: const EdgeInsets.symmetric(horizontal: 6),
// //                   child: SingleChildScrollView(
// //                     scrollDirection: Axis.horizontal,
// //                     child: Row(
// //                       crossAxisAlignment: CrossAxisAlignment.start,
// //                       children: mapValues.map((data) {
// //                         var hr = int.parse(data['hour'].toString());
// //                         return Column(
// //                           crossAxisAlignment: CrossAxisAlignment.start,
// //                           children: [
// //                             Container(
// //                               color: Colors.black38,
// //                               width: 0.9,
// //                               height: SizeConfig.heightMultiplier * 12,
// //                             ),
// //                             SizedBox(
// //                               height: SizeConfig.heightMultiplier * 1.2,
// //                             ),
// //                             hr % 2 != 0
// //                                 ? Text(
// //                                     '',
// //                                     style: TextStyle(
// //                                         fontSize: SizeConfig.textMultiplier * 2,
// //                                         color: Colors.black38,
// //                                         fontFamily: 'Montserrat',
// //                                         fontWeight: FontWeight.w500),
// //                                   )
// //                                 : Text(
// //                                     hr.toString(),
// //                                     style: TextStyle(
// //                                         fontSize: SizeConfig.textMultiplier * 2,
// //                                         color: Colors.black38,
// //                                         fontFamily: 'Montserrat',
// //                                         fontWeight: FontWeight.w500),
// //                                   )
// //                           ],
// //                         );
// //                       }).toList(),
// //                     ),
// //                   ),
// //                 ),
// //               ),
// //               SizedBox(
// //                 height: SizeConfig.heightMultiplier * 2,
// //               ),
// //               Padding(
// //                 padding: const EdgeInsets.symmetric(horizontal: 12),
// //                 child: Container(
// //                   width: double.infinity,
// //                   decoration: BoxDecoration(
// //                       color: Colors.white,
// //                       borderRadius: BorderRadius.circular(15)),
// //                   child: Column(
// //                     children: [
// //                       Padding(
// //                         padding: const EdgeInsets.symmetric(
// //                             horizontal: 12, vertical: 12),
// //                         child: Row(
// //                           crossAxisAlignment: CrossAxisAlignment.start,
// //                           children: [
// //                             Container(
// //                               height: SizeConfig.heightMultiplier * 8,
// //                               width: SizeConfig.widthMultiplier * 18,
// //                               decoration: BoxDecoration(
// //                                   color: movGray, shape: BoxShape.circle),
// //                               child: Center(
// //                                 child: SvgPicture.asset(
// //                                   "assets/icons/feeder.svg",
// //                                   height: SizeConfig.heightMultiplier * 4,
// //                                 ),
// //                               ),
// //                             ),
// //                             SizedBox(
// //                               width: SizeConfig.widthMultiplier * 3,
// //                             ),
// //                             Column(
// //                               crossAxisAlignment: CrossAxisAlignment.start,
// //                               children: [
// //                                 Row(
// //                                   crossAxisAlignment: CrossAxisAlignment.start,
// //                                   children: [
// //                                     Text(
// //                                       'Feeder',
// //                                       style: TextStyle(
// //                                           fontSize:
// //                                               SizeConfig.textMultiplier * 2,
// //                                           fontFamily: 'Montserrat',
// //                                           fontWeight: FontWeight.w700,
// //                                           color: Colors.black38),
// //                                     ),
// //                                     SizedBox(
// //                                       width: SizeConfig.widthMultiplier * 26,
// //                                     ),
// //                                     Text(
// //                                       DateFormat('hh:mm a').format(_todayDate),
// //                                       style: TextStyle(
// //                                           fontSize:
// //                                               SizeConfig.textMultiplier * 2,
// //                                           fontFamily: 'Montserrat',
// //                                           // fontWeight: FontWeight.w700,
// //                                           color: Colors.black38),
// //                                     ),
// //                                   ],
// //                                 ),
// //                                 SizedBox(
// //                                     height: SizeConfig.heightMultiplier * 1.5),
// //                                 Row(
// //                                   crossAxisAlignment: CrossAxisAlignment.start,
// //                                   children: [
// //                                     SvgPicture.asset(
// //                                       "assets/icons/ml.svg",
// //                                       height: SizeConfig.heightMultiplier * 2,
// //                                     ),
// //                                     SizedBox(
// //                                       width: SizeConfig.widthMultiplier * 3,
// //                                     ),
// //                                     Text(
// //                                       '80 ml',
// //                                       style: TextStyle(
// //                                           fontSize:
// //                                               SizeConfig.textMultiplier * 2,
// //                                           fontFamily: 'Montserrat',
// //                                           // fontWeight: FontWeight.w700,
// //                                           color: Colors.black38),
// //                                     ),
// //                                   ],
// //                                 ),
// //                                 SizedBox(
// //                                   width: SizeConfig.heightMultiplier * 2,
// //                                 ),
// //                                 SizedBox(
// //                                   width: 190,
// //                                   child: Text(
// //                                       "Lorem ipsum dolor sit amet, consectetur adipiscing elit",
// //                                       maxLines: 1,
// //                                       overflow: TextOverflow.ellipsis,
// //                                       softWrap: false,
// //                                       style: TextStyle(
// //                                           fontSize:
// //                                               SizeConfig.textMultiplier * 2,
// //                                           fontFamily: 'Montserrat',
// //                                           // fontWeight: FontWeight.w700,
// //                                           color: Colors.black38)),
// //                                 ),
// //                               ],
// //                             ),
// //                           ],
// //                         ),
// //                       ),
// //                       Padding(
// //                         padding: const EdgeInsets.symmetric(horizontal: 14),
// //                         child: Divider(
// //                           thickness: 0.8,
// //                           color: Colors.black38,
// //                         ),
// //                       ),
// //                     ],
// //                   ),
// //                 ),
// //               ),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }

// // import 'package:flutter/material.dart';
// // import 'package:flutter_speed_dial/flutter_speed_dial.dart';
// // import 'package:flutter_svg/flutter_svg.dart';
// // import 'package:momnotebook/constants/colors.dart';
// // import 'package:momnotebook/constants/customAppBar.dart';
// // import 'package:momnotebook/constants/sizeConfig.dart';
// // import 'package:momnotebook/widgets/dashboard/dashboard_content/growth/growth_page.dart';
// // import 'package:momnotebook/widgets/dashboard/dashboard_content/home/home_page.dart';
// // import 'package:momnotebook/widgets/dashboard/dashboard_content/profile_account/profile_page.dart';
// // import 'package:momnotebook/widgets/dashboard/dashboard_content/statistics/statistics_page.dart';
// // import 'dart:ui' as ui;
// // import 'package:flutter/services.dart';

// // class HomeDashboard extends StatefulWidget {
// //   const HomeDashboard({Key? key}) : super(key: key);

// //   @override
// //   _HomeDashboardState createState() => _HomeDashboardState();
// // }

// // class _HomeDashboardState extends State<HomeDashboard> {
// //   List<Map<String, dynamic>> splashData = [
// //     {
// //       "title": "Sleeping",
// //       "image": "assets/icons/sleeping.svg",
// //       "color": greenGray
// //     },
// //     {"title": "Feeder", "image": "assets/icons/feeder.svg", "color": movGray},
// //     {
// //       "title": "Breast \nPumping",
// //       "image": "assets/icons/breast-pumping.svg",
// //       "color": orGray
// //     },
// //     {
// //       "title": "Breast \nFeed",
// //       "image": "assets/icons/breast-feed.svg",
// //       "color": rsGray
// //     },
// //     {"title": "Food", "image": "assets/icons/food.svg", "color": buttonBGColor},
// //     {
// //       "title": "Diaper",
// //       "image": "assets/icons/diaper.svg",
// //       "color": greenAccGray
// //     },
// //     {
// //       "title": "Walking",
// //       "image": "assets/icons/walking.svg",
// //       "color": jnAccGray
// //     }
// //   ];
// //   PageController _pageController = PageController();
// //   int _selectedIndex = 0;
// //   ui.Image? img;
// //   @override
// //   void initState() {
// //     super.initState();

// //     rootBundle.load("assets/images/food.png").then((bd) {
// //       decodeImageFromList(bd.buffer.asUint8List()).then((img) {
// //         setState(() {
// //           this.img = img;
// //         });
// //       });
// //     });
// //   }

// //   void _onPageChanged(int index) {
// //     setState(() {
// //       _selectedIndex = index;
// //     });
// //   }

// //   void _itemTaped(int selectedIndex) {
// //     _pageController.jumpToPage(selectedIndex);
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     List<Widget> _widgetList = [
// //       HomePage(
// //         splashData: splashData,
// //         // img: img,
// //       ),
// //       StatisticsPage(),
// //       GrowthPage(),
// //       ProfilePage()
// //     ];
// //     return Scaffold(
// //       backgroundColor: bluewhite,
// //       appBar: CustomAppBar(
// //           height: SizeConfig.heightMultiplier * 9,
// //           child: _selectedIndex == 3
// //               ? appBarDashboardAccount(context, 'Account', () {}, () {})
// //               : appBarDashboard(context, 'Sam', () {}, () {})),
// //       body: PageView(
// //         controller: _pageController,
// //         children: _widgetList,
// //         onPageChanged: _onPageChanged,
// //         physics: NeverScrollableScrollPhysics(),
// //       ),
// //       floatingActionButton: _selectedIndex == 0
// //           ? SpeedDial(
// //               animatedIcon: AnimatedIcons.menu_close,
// //               backgroundColor: buttonBGColor,
// //               children: [
// //                 SpeedDialChild(
// //                   child: SvgPicture.asset('assets/icons/sleeping.svg'),
// //                   label: 'Sleeping',
// //                   backgroundColor: greenGray,
// //                   onTap: () => Navigator.of(context).pushNamed('/sleep'),
// //                 ),
// //                 SpeedDialChild(
// //                   child: SvgPicture.asset('assets/icons/feeder.svg'),
// //                   label: 'Feeder',
// //                   backgroundColor: movGray,
// //                   onTap: () => Navigator.of(context).pushNamed('/feeder'),
// //                 ),
// //                 SpeedDialChild(
// //                   child: SvgPicture.asset('assets/icons/breast-pumping.svg'),
// //                   label: 'Breast Pumping',
// //                   backgroundColor: orGray,
// //                   onTap: () =>
// //                       Navigator.of(context).pushNamed('/breast_pumping'),
// //                 ),
// //                 SpeedDialChild(
// //                   child: SvgPicture.asset('assets/icons/breast-feed.svg'),
// //                   label: 'Breast Feed',
// //                   backgroundColor: rsGray,
// //                   onTap: () => Navigator.of(context).pushNamed('/breast_feed'),
// //                 ),
// //                 SpeedDialChild(
// //                   child: SvgPicture.asset('assets/icons/food.svg'),
// //                   label: 'Food',
// //                   backgroundColor: buttonBGColor,
// //                   onTap: () => Navigator.of(context).pushNamed('/food'),
// //                 ),
// //                 SpeedDialChild(
// //                   child: SvgPicture.asset('assets/icons/diaper.svg'),
// //                   label: 'Diaper',
// //                   backgroundColor: greenAccGray,
// //                   onTap: () => Navigator.of(context).pushNamed('/diaper'),
// //                 ),
// //                 SpeedDialChild(
// //                   child: SvgPicture.asset('assets/icons/walking.svg'),
// //                   label: 'Walking',
// //                   backgroundColor: jnAccGray,
// //                   onTap: () => Navigator.of(context).pushNamed('/walk'),
// //                 ),
// //               ],
// //             )
// //           : Container(),
// //       bottomNavigationBar: Container(
// //         decoration: BoxDecoration(
// //           borderRadius: BorderRadius.only(
// //               topRight: Radius.circular(30), topLeft: Radius.circular(30)),
// //         ),
// //         child: ClipRRect(
// //           borderRadius: BorderRadius.only(
// //             topLeft: Radius.circular(30.0),
// //             topRight: Radius.circular(30.0),
// //           ),
// //           child: BottomNavigationBar(
// //             currentIndex: _selectedIndex,
// //             selectedFontSize: 16,
// //             onTap: _itemTaped,
// //             items: [
// //               BottomNavigationBarItem(
// //                   icon: SvgPicture.asset(
// //                     'assets/icons/md-home.svg',
// //                     color: _selectedIndex == 0 ? buttonBGColor : Colors.black38,
// //                   ),
// //                   title: Text(
// //                     "Home",
// //                     style: TextStyle(
// //                         fontSize: SizeConfig.textMultiplier * 2,
// //                         color: _selectedIndex == 0
// //                             ? buttonBGColor
// //                             : Colors.black38,
// //                         fontFamily: 'Montserrat',
// //                         fontWeight: FontWeight.w500),
// //                   )),
// //               BottomNavigationBarItem(
// //                   icon: SvgPicture.asset(
// //                     'assets/icons/chart-pie.svg',
// //                     color: _selectedIndex == 1 ? buttonBGColor : Colors.black38,
// //                   ),
// //                   title: Text(
// //                     "Statistics",
// //                     style: TextStyle(
// //                         fontSize: SizeConfig.textMultiplier * 2,
// //                         color: _selectedIndex == 1
// //                             ? buttonBGColor
// //                             : Colors.black38,
// //                         fontFamily: 'Montserrat',
// //                         fontWeight: FontWeight.w500),
// //                   )),
// //               BottomNavigationBarItem(
// //                   icon: SvgPicture.asset(
// //                     'assets/icons/growth.svg',
// //                     color: _selectedIndex == 2 ? buttonBGColor : Colors.black38,
// //                   ),
// //                   title: Text(
// //                     "Growth",
// //                     style: TextStyle(
// //                         fontSize: SizeConfig.textMultiplier * 2,
// //                         color: _selectedIndex == 2
// //                             ? buttonBGColor
// //                             : Colors.black38,
// //                         fontFamily: 'Montserrat',
// //                         fontWeight: FontWeight.w500),
// //                   )),
// //               BottomNavigationBarItem(
// //                   icon: SvgPicture.asset(
// //                     'assets/icons/user-alt.svg',
// //                     color: _selectedIndex == 3 ? buttonBGColor : Colors.black38,
// //                   ),
// //                   title: Text(
// //                     "Profile",
// //                     style: TextStyle(
// //                         fontSize: SizeConfig.textMultiplier * 2,
// //                         color: _selectedIndex == 3
// //                             ? buttonBGColor
// //                             : Colors.black38,
// //                         fontFamily: 'Montserrat',
// //                         fontWeight: FontWeight.w500),
// //                   )),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }

// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:intl/intl.dart';
// import 'package:jiffy/jiffy.dart';
// import 'package:momnotebook/constants/colors.dart';
// import 'package:momnotebook/constants/sizeConfig.dart';
// import 'chart_painter/chartPainter.dart';

// class HomePage extends StatefulWidget {
//   final List<Map<String, dynamic>> splashData;
//   // final ui.Image? img;
//   HomePage({
//     Key? key,
//     required this.splashData,
//   }) : super(key: key);

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   DateTime _todayDate = DateTime.now();

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Colors.white,
//       child: Container(
//         height: MediaQuery.of(context).size.height,
//         decoration: BoxDecoration(
//             color: bluewhite,
//             borderRadius: new BorderRadius.only(
//               topLeft: const Radius.circular(30.0),
//               topRight: const Radius.circular(30.0),
//             )),
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Padding(
//                 padding: const EdgeInsets.only(top: 18, left: 12),
//                 child: Container(
//                   height: SizeConfig.heightMultiplier * 18,
//                   child: ListView.builder(
//                       scrollDirection: Axis.horizontal,
//                       itemCount: widget.splashData.length,
//                       itemBuilder: (context, index) {
//                         return Column(
//                           children: [
//                             Container(
//                               height: SizeConfig.heightMultiplier * 8,
//                               width: SizeConfig.widthMultiplier * 18,
//                               decoration: BoxDecoration(
//                                   color: widget.splashData[index]['color'],
//                                   shape: BoxShape.circle),
//                               child: Center(
//                                 child: SvgPicture.asset(
//                                   widget.splashData[index]['image']!,
//                                   height: SizeConfig.heightMultiplier * 4,
//                                 ),
//                               ),
//                             ),
//                             SizedBox(
//                               height: SizeConfig.heightMultiplier * 1.5,
//                             ),
//                             Text(
//                               widget.splashData[index]['title']!,
//                               style: TextStyle(
//                                   fontSize: SizeConfig.textMultiplier * 2,
//                                   color: Colors.black38,
//                                   fontFamily: 'Montserrat',
//                                   fontWeight: FontWeight.w500),
//                             )
//                           ],
//                         );
//                       }),
//                 ),
//               ),
//               SizedBox(
//                 height: SizeConfig.heightMultiplier * 2,
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(left: 12),
//                 child: Text(
//                   'Today ${Jiffy(_todayDate).MMMEd}',
//                   style: TextStyle(
//                       fontSize: SizeConfig.textMultiplier * 2,
//                       color: buttonBGColor,
//                       fontFamily: 'Montserrat',
//                       fontWeight: FontWeight.w500),
//                 ),
//               ),
//               SizedBox(
//                 height: SizeConfig.heightMultiplier * 2,
//               ),
//               Container(
//                 height: SizeConfig.heightMultiplier * 18,
//                 decoration: BoxDecoration(color: bluewhite),
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 6),
//                   child: SingleChildScrollView(
//                     scrollDirection: Axis.horizontal,
//                     child: SizedBox(
//                       width: SizeConfig.widthMultiplier * 73,
//                       child: CustomPaint(
//                         child: Container(),
//                         painter: TimelinePainter(),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: SizeConfig.heightMultiplier * 2,
//               ),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 12),
//                 child: Container(
//                   width: double.infinity,
//                   decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(15)),
//                   child: Column(
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 12, vertical: 12),
//                         child: Row(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Container(
//                               height: SizeConfig.heightMultiplier * 8,
//                               width: SizeConfig.widthMultiplier * 18,
//                               decoration: BoxDecoration(
//                                   color: movGray, shape: BoxShape.circle),
//                               child: Center(
//                                 child: SvgPicture.asset(
//                                   "assets/icons/feeder.svg",
//                                   height: SizeConfig.heightMultiplier * 4,
//                                 ),
//                               ),
//                             ),
//                             SizedBox(
//                               width: SizeConfig.widthMultiplier * 3,
//                             ),
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Row(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text(
//                                       'Feeder',
//                                       style: TextStyle(
//                                           fontSize:
//                                               SizeConfig.textMultiplier * 2,
//                                           fontFamily: 'Montserrat',
//                                           fontWeight: FontWeight.w700,
//                                           color: Colors.black38),
//                                     ),
//                                     SizedBox(
//                                       width: SizeConfig.widthMultiplier * 26,
//                                     ),
//                                     Text(
//                                       DateFormat('hh:mm a').format(_todayDate),
//                                       style: TextStyle(
//                                           fontSize:
//                                               SizeConfig.textMultiplier * 2,
//                                           fontFamily: 'Montserrat',
//                                           // fontWeight: FontWeight.w700,
//                                           color: Colors.black38),
//                                     ),
//                                   ],
//                                 ),
//                                 SizedBox(
//                                     height: SizeConfig.heightMultiplier * 1.5),
//                                 Row(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     SvgPicture.asset(
//                                       "assets/icons/ml.svg",
//                                       height: SizeConfig.heightMultiplier * 2,
//                                     ),
//                                     SizedBox(
//                                       width: SizeConfig.widthMultiplier * 3,
//                                     ),
//                                     Text(
//                                       '80 ml',
//                                       style: TextStyle(
//                                           fontSize:
//                                               SizeConfig.textMultiplier * 2,
//                                           fontFamily: 'Montserrat',
//                                           // fontWeight: FontWeight.w700,
//                                           color: Colors.black38),
//                                     ),
//                                   ],
//                                 ),
//                                 SizedBox(
//                                   width: SizeConfig.heightMultiplier * 2,
//                                 ),
//                                 SizedBox(
//                                   width: 190,
//                                   child: Text(
//                                       "Lorem ipsum dolor sit amet, consectetur adipiscing elit",
//                                       maxLines: 1,
//                                       overflow: TextOverflow.ellipsis,
//                                       softWrap: false,
//                                       style: TextStyle(
//                                           fontSize:
//                                               SizeConfig.textMultiplier * 2,
//                                           fontFamily: 'Montserrat',
//                                           // fontWeight: FontWeight.w700,
//                                           color: Colors.black38)),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 14),
//                         child: Divider(
//                           thickness: 0.8,
//                           color: Colors.black38,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
