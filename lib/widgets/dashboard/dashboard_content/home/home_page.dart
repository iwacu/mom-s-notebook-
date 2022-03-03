import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:momnotebook/constants/colors.dart';
import 'package:momnotebook/constants/sizeConfig.dart';
import 'package:momnotebook/cubit/cubit/home_page_cubit.dart';
import 'package:momnotebook/models/babyTask.dart';
import 'chart_painter/chartPainter.dart';

class HomePage extends StatefulWidget {
  final List<Map<String, dynamic>> splashData;
  // final ui.Image? img;
  HomePage({
    Key? key,
    required this.splashData,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime _todayDate = DateTime.now();

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
              Padding(
                padding: const EdgeInsets.only(top: 18, left: 2),
                child: Container(
                  height: SizeConfig.heightMultiplier * 16,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: widget.splashData.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 4),
                          child: Column(
                            children: [
                              Container(
                                height: SizeConfig.heightMultiplier * 8,
                                width: SizeConfig.widthMultiplier * 18,
                                decoration: BoxDecoration(
                                    color: widget.splashData[index]['color'],
                                    shape: BoxShape.circle),
                                child: index == 5
                                    ? Center(
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(top: 8),
                                          child: SvgPicture.asset(
                                            widget.splashData[index]['image']!,
                                            alignment: Alignment.center,
                                          ),
                                        ),
                                      )
                                    : Center(
                                        child: SvgPicture.asset(
                                          widget.splashData[index]['image']!,
                                          alignment: Alignment.center,
                                        ),
                                      ),
                              ),
                              SizedBox(
                                height: SizeConfig.heightMultiplier * 1.5,
                              ),
                              Text(
                                widget.splashData[index]['title']!,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: SizeConfig.textMultiplier * 1.8,
                                    color: Colors.black38,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w500),
                              )
                            ],
                          ),
                        );
                      }),
                ),
              ),
              SizedBox(
                height: SizeConfig.heightMultiplier * 2,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 12),
                child: Text(
                  'Today ${Jiffy(_todayDate).MMMEd}',
                  style: TextStyle(
                      fontSize: SizeConfig.textMultiplier * 2,
                      color: buttonBGColor,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w500),
                ),
              ),
              SizedBox(
                height: SizeConfig.heightMultiplier * 2,
              ),
              BlocBuilder<HomePageCubit, HomePageState>(
                builder: (context, state) {
                  if (state is HomePageInitial) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is HomePageCompleted) {
                    return Container(
                      height: SizeConfig.heightMultiplier * 18,
                      decoration: BoxDecoration(color: bluewhite),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Container(
                            child: SizedBox(
                              width: SizeConfig.widthMultiplier * 73,
                              child: CustomPaint(
                                child: Container(),
                                painter: TimelinePainter(state.babyTasks
                                    .where((element) =>
                                        DateTime.parse(element.timeStamp).day ==
                                            _todayDate.day &&
                                        DateTime.parse(element.timeStamp)
                                                .month ==
                                            _todayDate.month &&
                                        DateTime.parse(element.timeStamp)
                                                .year ==
                                            _todayDate.year &&
                                        element.onTaskCompleted == 0)
                                    .toList()),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }
                  return Container();
                },
              ),
              SizedBox(
                height: SizeConfig.heightMultiplier * 2,
              ),
              _babyTasks(),
            ],
          ),
        ),
      ),
    );
  }

  _babyTasks() {
    return BlocBuilder<HomePageCubit, HomePageState>(
      builder: (context, state) {
        if (state is HomePageInitial) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is HomePageCompleted) {
          var babyTasks = state.babyTasks
              .where((element) =>
                  DateTime.parse(element.timeStamp).day == _todayDate.day &&
                  DateTime.parse(element.timeStamp).month == _todayDate.month &&
                  DateTime.parse(element.timeStamp).year == _todayDate.year)
              .toList();
          return babyTasks.isEmpty
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 32),
                    child: SvgPicture.asset(
                      "assets/icons/carrirage.svg",
                      height: SizeConfig.imageSizeMultiplier * 20,
                    ),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15)),
                    child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: babyTasks.length,
                        itemBuilder: (_, index) {
                          if (babyTasks[index].taskName == 'sleeping') {
                            return babyTasks[index].onTaskCompleted == 0
                                ? GestureDetector(
                                    onTap: () => Navigator.of(context)
                                            .pushNamed('/sleep_update',
                                                arguments: {
                                              'baby': state.baby,
                                              'baby_task': babyTasks[index]
                                            }),
                                    child: _sleeping(babyTasks[index], index,
                                        babyTasks.length))
                                : _sleeping(
                                    babyTasks[index], index, babyTasks.length);
                          } else if (babyTasks[index].taskName == 'food') {
                            return GestureDetector(
                                onTap: () => Navigator.of(context)
                                        .pushNamed('/food_update', arguments: {
                                      'baby': state.baby,
                                      'baby_task': babyTasks[index]
                                    }),
                                child: _food(
                                    babyTasks[index], index, babyTasks.length));
                          } else if (babyTasks[index].taskName == 'feeder') {
                            return GestureDetector(
                                onTap: () => Navigator.of(context).pushNamed(
                                        '/feeder_update',
                                        arguments: {
                                          'baby': state.baby,
                                          'baby_task': babyTasks[index]
                                        }),
                                child: _feeder(
                                    babyTasks[index], index, babyTasks.length));
                          } else if (babyTasks[index].taskName == 'diaper') {
                            return GestureDetector(
                                onTap: () => Navigator.of(context).pushNamed(
                                        '/diaper_update',
                                        arguments: {
                                          'baby': state.baby,
                                          'baby_task': babyTasks[index]
                                        }),
                                child: _diaper(
                                    babyTasks[index], index, babyTasks.length));
                          } else if (babyTasks[index].taskName == 'walking') {
                            return babyTasks[index].onTaskCompleted == 0
                                ? GestureDetector(
                                    onTap: () => Navigator.of(context)
                                            .pushNamed('/walk_update',
                                                arguments: {
                                              'baby': state.baby,
                                              'baby_task': babyTasks[index]
                                            }),
                                    child: _walking(babyTasks[index], index,
                                        babyTasks.length))
                                : _walking(
                                    babyTasks[index], index, babyTasks.length);
                          } else if (babyTasks[index].taskName ==
                              'breast-pumping') {
                            return GestureDetector(
                                onTap: () => Navigator.of(context).pushNamed(
                                        '/breast_pump_update',
                                        arguments: {
                                          'baby': state.baby,
                                          'baby_task': babyTasks[index]
                                        }),
                                child: _breastPumping(
                                    babyTasks[index], index, babyTasks.length));
                          } else if (babyTasks[index].taskName ==
                              'breast-feed') {
                            return GestureDetector(
                                onTap: () => Navigator.of(context).pushNamed(
                                        '/breast_feed_update',
                                        arguments: {
                                          'baby': state.baby,
                                          'baby_task': babyTasks[index]
                                        }),
                                child: _breastFeeding(
                                    babyTasks[index], index, babyTasks.length));
                          }
                          return Container();
                        }),
                  ),
                );
        }
        return Container();
      },
    );
  }

  _sleeping(BabyTask baby, int index, int length) {
    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 12, top: 8),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // icon_container

              Container(
                height: SizeConfig.heightMultiplier * 8,
                width: SizeConfig.widthMultiplier * 18,
                decoration: BoxDecoration(
                    color: Color(int.parse(baby.color)),
                    shape: BoxShape.circle),
                child: Center(
                  child: SvgPicture.asset(
                    "assets/icons/${baby.taskName}.svg",
                    height: SizeConfig.heightMultiplier * 4,
                  ),
                ),
              ),
              SizedBox(
                width: SizeConfig.widthMultiplier * 3,
              ),
              // task_details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // first_row
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${baby.taskName[0].toUpperCase()}${baby.taskName.substring(1)}",
                          style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w700,
                              color: Colors.black38),
                        ),
                        Text(
                          DateFormat('hh:mm a')
                              .format(DateTime.parse(baby.timeStamp)),
                          style: TextStyle(
                              fontFamily: 'Montserrat',
                              // fontWeight: FontWeight.w700,
                              color: Colors.black38),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: SizeConfig.heightMultiplier * 2,
                    ),
                    // second_row
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Start',
                              style: TextStyle(
                                  fontSize: SizeConfig.textMultiplier * 1.3,
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black38),
                            ),
                            SizedBox(
                              width: SizeConfig.widthMultiplier * 1.2,
                            ),
                            Text(
                              DateFormat('hh:mm a')
                                  .format(DateTime.parse(baby.startTime)),
                              style: TextStyle(
                                  fontSize: SizeConfig.textMultiplier * 1.3,
                                  fontFamily: 'Montserrat',
                                  // fontWeight: FontWeight.w700,
                                  color: Colors.black38),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: SizeConfig.widthMultiplier * 2,
                        ),
                        baby.endTime.isEmpty
                            ? Container()
                            : Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'End',
                                    style: TextStyle(
                                        fontSize:
                                            SizeConfig.textMultiplier * 1.3,
                                        fontFamily: 'Montserrat',
                                        fontWeight: FontWeight.w700,
                                        color: Colors.black38),
                                  ),
                                  SizedBox(
                                    width: SizeConfig.widthMultiplier * 3,
                                  ),
                                  Text(
                                    DateFormat('hh:mm a')
                                        .format(DateTime.parse(baby.endTime)),
                                    style: TextStyle(
                                        fontSize:
                                            SizeConfig.textMultiplier * 1.3,
                                        fontFamily: 'Montserrat',
                                        // fontWeight: FontWeight.w700,
                                        color: Colors.black38),
                                  ),
                                ],
                              ),
                        SizedBox(
                          width: SizeConfig.widthMultiplier * 1.4,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: SizeConfig.heightMultiplier * 1.3,
                    ),
                    baby.endTime.isEmpty
                        ? Container()
                        : Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Duration',
                                style: TextStyle(
                                    fontSize: SizeConfig.textMultiplier * 1.3,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black38),
                              ),
                              SizedBox(
                                width: SizeConfig.widthMultiplier * 3,
                              ),
                              Text(
                                calculateTimeDifferenceBetween(
                                    startDate: DateTime.parse(baby.startTime),
                                    endDate: DateTime.parse(baby.endTime)),
                                style: TextStyle(
                                    fontSize: SizeConfig.textMultiplier * 1.3,
                                    fontFamily: 'Montserrat',
                                    // fontWeight: FontWeight.w700,
                                    color: Colors.black38),
                              ),
                            ],
                          ),
                    SizedBox(height: SizeConfig.heightMultiplier * 2),
                    SizedBox(
                      width: 190,
                      child: Text("${baby.note}",
                          maxLines: 5,
                          overflow: TextOverflow.ellipsis,
                          softWrap: false,
                          style: TextStyle(
                              fontSize: SizeConfig.textMultiplier * 1.8,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w300,
                              color: Colors.black38)),
                    ),
                  ],
                ),
              ),
            ],
          ),
          index + 1 == length
              ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  child: Divider(
                    thickness: 0.4,
                    color: primaryColor,
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  child: Divider(
                    thickness: 0.2,
                    color: Colors.black38,
                  ),
                ),
        ],
      ),
    );
  }

  _food(BabyTask baby, int index, int length) {
    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 12, top: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // icon_container

              Container(
                height: SizeConfig.heightMultiplier * 8,
                width: SizeConfig.widthMultiplier * 18,
                decoration: BoxDecoration(
                    color: Color(int.parse(baby.color)),
                    shape: BoxShape.circle),
                child: Center(
                  child: SvgPicture.asset(
                    "assets/icons/${baby.taskName}.svg",
                    height: SizeConfig.heightMultiplier * 4,
                  ),
                ),
              ),
              SizedBox(
                width: SizeConfig.widthMultiplier * 3,
              ),
              // task_details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // first_row
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${baby.taskName[0].toUpperCase()}${baby.taskName.substring(1)}",
                          style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w700,
                              color: Colors.black38),
                        ),
                        Text(
                          DateFormat('hh:mm a')
                              .format(DateTime.parse(baby.timeStamp)),
                          style: TextStyle(
                              fontFamily: 'Montserrat',
                              // fontWeight: FontWeight.w700,
                              color: Colors.black38),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: SizeConfig.heightMultiplier * 2,
                    ),
                    // second_row
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SvgPicture.asset(
                          "assets/icons/group.svg",
                          height: SizeConfig.heightMultiplier * 2,
                        ),
                        SizedBox(
                          width: SizeConfig.widthMultiplier * 1.2,
                        ),
                        Text(
                          'Food Group',
                          style: TextStyle(
                              fontSize: SizeConfig.textMultiplier * 1.3,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w700,
                              color: Colors.black38),
                        ),
                        SizedBox(
                          width: SizeConfig.widthMultiplier * 1.2,
                        ),
                        Text(
                          '${baby.groupFood}',
                          style: TextStyle(
                              fontSize: SizeConfig.textMultiplier * 1.3,
                              fontFamily: 'Montserrat',
                              // fontWeight: FontWeight.w700,
                              color: Colors.black38),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: SizeConfig.widthMultiplier * 2,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SvgPicture.asset(
                          "assets/icons/amount.svg",
                          height: SizeConfig.heightMultiplier * 2,
                        ),
                        SizedBox(
                          width: SizeConfig.widthMultiplier * 1.2,
                        ),
                        Text(
                          'Amount',
                          style: TextStyle(
                              fontSize: SizeConfig.textMultiplier * 1.3,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w700,
                              color: Colors.black38),
                        ),
                        SizedBox(
                          width: SizeConfig.widthMultiplier * 1.2,
                        ),
                        Text(
                          '${baby.qtyFood} ${baby.qtyFeeder}',
                          style: TextStyle(
                              fontSize: SizeConfig.textMultiplier * 1.3,
                              fontFamily: 'Montserrat',
                              // fontWeight: FontWeight.w700,
                              color: Colors.black38),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: SizeConfig.widthMultiplier * 1.4,
                    ),
                    SizedBox(height: SizeConfig.heightMultiplier * 2),
                    SizedBox(
                      width: 190,
                      child: Text("${baby.note}",
                          maxLines: 5,
                          overflow: TextOverflow.ellipsis,
                          softWrap: false,
                          style: TextStyle(
                              fontSize: SizeConfig.textMultiplier * 1.8,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w300,
                              color: Colors.black38)),
                    ),
                  ],
                ),
              ),
            ],
          ),
          index + 1 == length
              ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  child: Divider(
                    thickness: 0.2,
                    color: primaryColor,
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  child: Divider(
                    thickness: 0.2,
                    color: Colors.black38,
                  ),
                ),
        ],
      ),
    );
  }

  _feeder(BabyTask baby, int index, int length) {
    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 12, top: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // icon_container
              Container(
                height: SizeConfig.heightMultiplier * 8,
                width: SizeConfig.widthMultiplier * 18,
                decoration: BoxDecoration(
                    color: Color(int.parse(baby.color)),
                    shape: BoxShape.circle),
                child: Center(
                  child: SvgPicture.asset(
                    "assets/icons/${baby.taskName}.svg",
                    height: SizeConfig.heightMultiplier * 4,
                  ),
                ),
              ),
              SizedBox(
                width: SizeConfig.widthMultiplier * 3,
              ),
              // task_details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // first_row
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${baby.taskName[0].toUpperCase()}${baby.taskName.substring(1)}",
                          style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w700,
                              color: Colors.black38),
                        ),
                        Text(
                          DateFormat('hh:mm a')
                              .format(DateTime.parse(baby.timeStamp)),
                          style: TextStyle(
                              fontFamily: 'Montserrat',
                              // fontWeight: FontWeight.w700,
                              color: Colors.black38),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: SizeConfig.heightMultiplier * 2,
                    ),
                    // second_row
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SvgPicture.asset(
                          "assets/icons/ml.svg",
                          height: SizeConfig.heightMultiplier * 2,
                        ),
                        SizedBox(
                          width: SizeConfig.widthMultiplier * 1.2,
                        ),
                        Text(
                          '${baby.qtyFood} ${baby.qtyFeeder}',
                          style: TextStyle(
                              fontSize: SizeConfig.textMultiplier * 1.3,
                              fontFamily: 'Montserrat',
                              // fontWeight: FontWeight.w700,
                              color: Colors.black38),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: SizeConfig.widthMultiplier * 1.4,
                    ),
                    SizedBox(height: SizeConfig.heightMultiplier * 2),
                    SizedBox(
                      width: 190,
                      child: Text("${baby.note}",
                          maxLines: 5,
                          overflow: TextOverflow.ellipsis,
                          softWrap: false,
                          style: TextStyle(
                              fontSize: SizeConfig.textMultiplier * 1.8,
                              fontFamily: 'Montserrat',
                              // fontWeight: FontWeight.w300,
                              color: Colors.black38)),
                    ),
                  ],
                ),
              ),
            ],
          ),
          index + 1 == length
              ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  child: Divider(
                    thickness: 0.2,
                    color: primaryColor,
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  child: Divider(
                    thickness: 0.2,
                    color: Colors.black38,
                  ),
                ),
        ],
      ),
    );
  }

  _diaper(BabyTask baby, int index, int length) {
    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 12, top: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // icon_container
              Container(
                height: SizeConfig.heightMultiplier * 8,
                width: SizeConfig.widthMultiplier * 18,
                decoration: BoxDecoration(
                    color: Color(int.parse(baby.color)),
                    shape: BoxShape.circle),
                child: Center(
                  child: SvgPicture.asset(
                    "assets/icons/diaperr.svg",
                    height: SizeConfig.heightMultiplier * 3,
                  ),
                ),
              ),
              SizedBox(
                width: SizeConfig.widthMultiplier * 3,
              ),
              // task_details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // first_row
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${baby.taskName[0].toUpperCase()}${baby.taskName.substring(1)}",
                          style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w700,
                              color: Colors.black38),
                        ),
                        Text(
                          DateFormat('hh:mm a')
                              .format(DateTime.parse(baby.timeStamp)),
                          style: TextStyle(
                              fontFamily: 'Montserrat',
                              // fontWeight: FontWeight.w700,
                              color: Colors.black38),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: SizeConfig.heightMultiplier * 2,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        baby.pee == 1
                            ? Container()
                            : SvgPicture.asset(
                                "assets/icons/pee.svg",
                                height: SizeConfig.heightMultiplier * 2,
                              ),
                        baby.pee == 1
                            ? Container()
                            : SizedBox(
                                width: SizeConfig.widthMultiplier * 1.2,
                              ),
                        baby.pee == 1
                            ? Container()
                            : Padding(
                                padding: const EdgeInsets.only(top: 3.0),
                                child: Text(
                                  'Pee',
                                  style: TextStyle(
                                      fontSize: SizeConfig.textMultiplier * 1.3,
                                      fontFamily: 'Montserrat',
                                      // fontWeight: FontWeight.w700,
                                      color: Colors.black38),
                                ),
                              ),
                        baby.pee == 1
                            ? Container()
                            : SizedBox(
                                width: SizeConfig.widthMultiplier * 8,
                              ),
                        baby.poo == 1
                            ? Container()
                            : SvgPicture.asset(
                                "assets/icons/poop.svg",
                                height: SizeConfig.heightMultiplier * 2,
                              ),
                        baby.poo == 1
                            ? Container()
                            : SizedBox(
                                width: SizeConfig.widthMultiplier * 1.2,
                              ),
                        baby.poo == 1
                            ? Container()
                            : Padding(
                                padding: const EdgeInsets.only(top: 3.0),
                                child: Text(
                                  'Poop',
                                  style: TextStyle(
                                      fontSize: SizeConfig.textMultiplier * 1.3,
                                      fontFamily: 'Montserrat',
                                      // fontWeight: FontWeight.w700,
                                      color: Colors.black38),
                                ),
                              ),
                      ],
                    ),
                    SizedBox(height: SizeConfig.heightMultiplier * 2),
                    SizedBox(
                      width: 190,
                      child: Text("${baby.note}",
                          maxLines: 5,
                          overflow: TextOverflow.ellipsis,
                          softWrap: false,
                          style: TextStyle(
                              fontSize: SizeConfig.textMultiplier * 1.8,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w300,
                              color: Colors.black38)),
                    ),
                  ],
                ),
              ),
            ],
          ),
          index + 1 == length
              ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  child: Divider(
                    thickness: 0.2,
                    color: primaryColor,
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  child: Divider(
                    thickness: 0.2,
                    color: Colors.black38,
                  ),
                ),
        ],
      ),
    );
  }

  _walking(BabyTask baby, int index, int length) {
    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 12, top: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // icon_container
              Container(
                height: SizeConfig.heightMultiplier * 8,
                width: SizeConfig.widthMultiplier * 18,
                decoration: BoxDecoration(
                    color: Color(int.parse(baby.color)),
                    shape: BoxShape.circle),
                child: Center(
                  child: SvgPicture.asset(
                    "assets/icons/${baby.taskName}.svg",
                    height: SizeConfig.heightMultiplier * 4,
                  ),
                ),
              ),
              SizedBox(
                width: SizeConfig.widthMultiplier * 3,
              ),
              // task_details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // first_row
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${baby.taskName[0].toUpperCase()}${baby.taskName.substring(1)}",
                          style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w700,
                              color: Colors.black38),
                        ),
                        Text(
                          DateFormat('hh:mm a')
                              .format(DateTime.parse(baby.timeStamp)),
                          style: TextStyle(
                              fontFamily: 'Montserrat',
                              // fontWeight: FontWeight.w700,
                              color: Colors.black38),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: SizeConfig.heightMultiplier * 2,
                    ),
                    // second_row
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Start',
                              style: TextStyle(
                                  fontSize: SizeConfig.textMultiplier * 1.3,
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black38),
                            ),
                            SizedBox(
                              width: SizeConfig.widthMultiplier * 1.2,
                            ),
                            Text(
                              DateFormat('hh:mm a')
                                  .format(DateTime.parse(baby.startTime)),
                              style: TextStyle(
                                  fontSize: SizeConfig.textMultiplier * 1.3,
                                  fontFamily: 'Montserrat',
                                  // fontWeight: FontWeight.w700,
                                  color: Colors.black38),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: SizeConfig.widthMultiplier * 2,
                        ),
                        baby.endTime.isEmpty
                            ? Container()
                            : Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'End',
                                    style: TextStyle(
                                        fontSize:
                                            SizeConfig.textMultiplier * 1.3,
                                        fontFamily: 'Montserrat',
                                        fontWeight: FontWeight.w700,
                                        color: Colors.black38),
                                  ),
                                  SizedBox(
                                    width: SizeConfig.widthMultiplier * 3,
                                  ),
                                  Text(
                                    DateFormat('hh:mm a')
                                        .format(DateTime.parse(baby.endTime)),
                                    style: TextStyle(
                                        fontSize:
                                            SizeConfig.textMultiplier * 1.3,
                                        fontFamily: 'Montserrat',
                                        // fontWeight: FontWeight.w700,
                                        color: Colors.black38),
                                  ),
                                ],
                              ),
                        SizedBox(
                          width: SizeConfig.widthMultiplier * 1.4,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: SizeConfig.heightMultiplier * 1.3,
                    ),
                    baby.endTime.isEmpty
                        ? Container()
                        : Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Duration',
                                style: TextStyle(
                                    fontSize: SizeConfig.textMultiplier * 1.3,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black38),
                              ),
                              SizedBox(
                                width: SizeConfig.widthMultiplier * 3,
                              ),
                              Text(
                                calculateTimeDifferenceBetween(
                                    startDate: DateTime.parse(baby.startTime),
                                    endDate: DateTime.parse(baby.endTime)),
                                style: TextStyle(
                                    fontSize: SizeConfig.textMultiplier * 1.3,
                                    fontFamily: 'Montserrat',
                                    // fontWeight: FontWeight.w700,
                                    color: Colors.black38),
                              ),
                            ],
                          ),
                    SizedBox(height: SizeConfig.heightMultiplier * 2),
                    SizedBox(
                      width: 190,
                      child: Text("${baby.note}",
                          maxLines: 5,
                          overflow: TextOverflow.ellipsis,
                          softWrap: false,
                          style: TextStyle(
                              fontSize: SizeConfig.textMultiplier * 1.8,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w300,
                              color: Colors.black38)),
                    ),
                  ],
                ),
              ),
            ],
          ),
          // divider
          index + 1 == length
              ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  child: Divider(
                    thickness: 0.2,
                    color: primaryColor,
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  child: Divider(
                    thickness: 0.2,
                    color: Colors.black38,
                  ),
                ),
        ],
      ),
    );
  }

  _breastPumping(BabyTask baby, int index, int length) {
    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 12, top: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // icon_container
              Container(
                height: SizeConfig.heightMultiplier * 8,
                width: SizeConfig.widthMultiplier * 18,
                decoration: BoxDecoration(
                    color: Color(int.parse(baby.color)),
                    shape: BoxShape.circle),
                child: Center(
                  child: SvgPicture.asset(
                    "assets/icons/${baby.taskName}.svg",
                    height: SizeConfig.heightMultiplier * 3,
                  ),
                ),
              ),
              SizedBox(
                width: SizeConfig.widthMultiplier * 3,
              ),
              // task_details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //  first_row
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Breast Pumping",
                          style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w700,
                              color: Colors.black38),
                        ),
                        Text(
                          DateFormat('hh:mm a')
                              .format(DateTime.parse(baby.timeStamp)),
                          style: TextStyle(
                              fontFamily: 'Montserrat',
                              // fontWeight: FontWeight.w700,
                              color: Colors.black38),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: SizeConfig.heightMultiplier * 2,
                    ),
                    // second_row
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SvgPicture.asset(
                          "assets/icons/ml.svg",
                          height: SizeConfig.heightMultiplier * 2,
                        ),
                        SizedBox(
                          width: SizeConfig.widthMultiplier * 1.2,
                        ),
                        Text(
                          '${baby.qtyFood} ${baby.groupFood}',
                          style: TextStyle(
                              fontSize: SizeConfig.textMultiplier * 1.3,
                              fontFamily: 'Montserrat',
                              // fontWeight: FontWeight.w700,
                              color: Colors.black38),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: SizeConfig.heightMultiplier * 1.4,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Last Breast To pump on : ',
                          style: TextStyle(
                              fontSize: SizeConfig.textMultiplier * 1.3,
                              fontFamily: 'Montserrat',
                              // fontWeight: FontWeight.w700,
                              color: Colors.black38),
                        ),
                        SizedBox(
                          width: SizeConfig.widthMultiplier * 1.2,
                        ),
                        baby.leftBreast == 0
                            ? Text(
                                'Left',
                                style: TextStyle(
                                    fontSize: SizeConfig.textMultiplier * 1.3,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black38),
                              )
                            : Container(),
                        SizedBox(
                          width: SizeConfig.widthMultiplier * 1.2,
                        ),
                        baby.rightBreast == 0
                            ? Text(
                                'Right',
                                style: TextStyle(
                                    fontSize: SizeConfig.textMultiplier * 1.3,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black38),
                              )
                            : Container(),
                      ],
                    ),
                    SizedBox(height: SizeConfig.heightMultiplier * 2),
                    SizedBox(
                      width: 190,
                      child: Text("${baby.note}",
                          maxLines: 5,
                          overflow: TextOverflow.ellipsis,
                          softWrap: false,
                          style: TextStyle(
                              fontSize: SizeConfig.textMultiplier * 1.8,
                              fontFamily: 'Montserrat',
                              // fontWeight: FontWeight.w300,
                              color: Colors.black38)),
                    ),
                  ],
                ),
              ),
            ],
          ),
          index + 1 == length
              ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  child: Divider(
                    thickness: 0.2,
                    color: primaryColor,
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  child: Divider(
                    thickness: 0.2,
                    color: Colors.black38,
                  ),
                ),
        ],
      ),
    );
  }

  _breastFeeding(BabyTask baby, int index, int length) {
    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 12, top: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // icon_container
              Container(
                height: SizeConfig.heightMultiplier * 8,
                width: SizeConfig.widthMultiplier * 18,
                decoration: BoxDecoration(
                    color: Color(int.parse(baby.color)),
                    shape: BoxShape.circle),
                child: Center(
                  child: SvgPicture.asset(
                    "assets/icons/${baby.taskName}.svg",
                    height: SizeConfig.heightMultiplier * 4,
                  ),
                ),
              ),
              SizedBox(
                width: SizeConfig.widthMultiplier * 3,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //  first_row
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Breast Feeding",
                          style: TextStyle(
                              fontSize: SizeConfig.textMultiplier * 2,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w700,
                              color: Colors.black38),
                        ),
                        Text(
                          DateFormat('hh:mm a')
                              .format(DateTime.parse(baby.timeStamp)),
                          style: TextStyle(
                              fontFamily: 'Montserrat',
                              // fontWeight: FontWeight.w700,
                              color: Colors.black38),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: SizeConfig.heightMultiplier * 2,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Last Breast To feed on : ',
                          style: TextStyle(
                              fontSize: SizeConfig.textMultiplier * 1.3,
                              fontFamily: 'Montserrat',
                              // fontWeight: FontWeight.w700,
                              color: Colors.black38),
                        ),
                        SizedBox(
                          width: SizeConfig.widthMultiplier * 1.2,
                        ),
                        baby.leftBreast == 0
                            ? Text(
                                'Left',
                                style: TextStyle(
                                    fontSize: SizeConfig.textMultiplier * 1.3,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black38),
                              )
                            : Container(),
                        SizedBox(
                          width: SizeConfig.widthMultiplier * 1.2,
                        ),
                        baby.rightBreast == 0
                            ? Text(
                                'Right',
                                style: TextStyle(
                                    fontSize: SizeConfig.textMultiplier * 1.3,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black38),
                              )
                            : Container(),
                      ],
                    ),

                    SizedBox(
                      width: 190,
                      child: Text("${baby.note}",
                          maxLines: 5,
                          overflow: TextOverflow.ellipsis,
                          softWrap: false,
                          style: TextStyle(
                              fontSize: SizeConfig.textMultiplier * 1.8,
                              fontFamily: 'Montserrat',
                              // fontWeight: FontWeight.w300,
                              color: Colors.black38)),
                    ),
                  ],
                ),
              ),
            ],
          ),
          index + 1 == length
              ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  child: Divider(
                    thickness: 0.2,
                    color: primaryColor,
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  child: Divider(
                    thickness: 0.2,
                    color: Colors.black38,
                  ),
                ),
        ],
      ),
    );
  }
}

String calculateTimeDifferenceBetween(
    {required DateTime startDate, required DateTime endDate}) {
  var days = endDate.difference(startDate).inDays;
  var hours = endDate.difference(startDate).inHours - (24 * days);
  var minutes = endDate.difference(startDate).inMinutes -
      (60 * endDate.difference(startDate).inHours);

  if (days == 0) {
    return '$hours hr $minutes min';
  } else if (days == 0 && hours == 0) {
    return '$minutes min';
  } else {
    return '$days day $hours hr $minutes min';
  }
}
