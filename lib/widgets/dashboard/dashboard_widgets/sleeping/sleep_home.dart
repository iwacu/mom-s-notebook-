import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:momnotebook/bloc/bloc/form_saving_bloc.dart';
import 'package:momnotebook/bloc/form_submission/form_sub.dart';
import 'package:momnotebook/constants/colors.dart';
import 'package:momnotebook/constants/customAppBar.dart';
import 'package:momnotebook/constants/defaultButton.dart';
import 'package:momnotebook/constants/show_snackBar.dart';
import 'package:momnotebook/constants/sizeConfig.dart';
import 'package:momnotebook/cubit/cubit/home_page_cubit.dart';
import 'package:momnotebook/models/baby.dart';
import 'package:momnotebook/models/timer.dart';
import 'package:momnotebook/services/database/database_helper.dart';
import 'package:timeago/timeago.dart' as timeago;

class HomeSleep extends StatefulWidget {
  final Baby baby;
  HomeSleep({Key? key, required this.baby}) : super(key: key);

  @override
  State<HomeSleep> createState() => _HomeSleepState();
}

class _HomeSleepState extends State<HomeSleep> {
  DateTime _nowDate = DateTime.now();
  Timer? timer;
  Duration duration = Duration();
  Duration _dtion = Duration();
  bool _stopTimer = false;
  String _startTime = '';
  String _endTime = '';
  final _text = TextEditingController();
  @override
  void initState() {
    super.initState();
    checkDuration();
  }

  void checkDuration() async {
    var tm = await DatabaseHelper.instance.getTimerr(1);
    if (tm.object != null) {
      duration = Duration(
          days: (_nowDate.day) - (DateTime.parse(tm.object!.startTime).day),
          hours: (_nowDate.hour) - (tm.object!.hour),
          minutes: (_nowDate.minute) - tm.object!.minutes,
          seconds: (_nowDate.second) - tm.object!.seconds);
      _text.text = tm.object!.notes;
      startTime();
      _stopTimer = true;
    }
  }

  void reset() async {
    var tm = await DatabaseHelper.instance.getTimerr(1);
    _startTime = tm.object!.startTime;
    _endTime = DateTime.now().toString();
    _dtion = duration;
    setState(() {
      duration = Duration();
      timer!.cancel();
    });
    _stopTimer = false;
    await DatabaseHelper.instance.deleteRecord(1);
    if (_stopTimer) {
      showSnackBar(context, 'Please stop The timer');
    } else {
      var di = greenGray.toString();
      print(di);
      const start = "Color(";
      const end = ")";

      final startIndex = di.indexOf(start);
      final endIndex = di.indexOf(end, startIndex + start.length);
      var fnl = di.substring(startIndex + start.length, endIndex);
      BlocProvider.of<HomePageCubit>(context).saveTasksWalkingSleeping(
          baby: widget.baby,
          taskName: 'sleeping',
          note: _text.text,
          startTime: _startTime,
          dateTime: _nowDate,
          endTime: _endTime,
          color: fnl,
          duration: _dtion,
          taskCompleted: 0);
      Navigator.pop(context);
    }
  }

  void saveTimer() async {
    var io = await DatabaseHelper.instance.addTimer(Timerr(
        startTime: _nowDate.toString(),
        hour: _nowDate.hour,
        minutes: _nowDate.minute,
        seconds: _nowDate.second,
        notes: '',
        taskId: 1));
    print('time saved $io');
  }

  void addTime() {
    final addSeCONDS = 1;
    if (mounted) {
      setState(() {
        final seconds = duration.inSeconds + addSeCONDS;
        duration = Duration(seconds: seconds);
      });
    }
  }

  void startTime() {
    timer = Timer.periodic(Duration(seconds: 1), (_) => addTime());
  }

  @override
  Widget build(BuildContext context) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    final hours = twoDigits(duration.inHours.remainder(60));
    final days = twoDigits(duration.inDays.remainder(60));
    final _isRunning = timer == null ? false : timer!.isActive;

    return BlocProvider(
      create: (context) => FormSavingBloc(),
      child: Scaffold(
        backgroundColor: bluewhite,
        appBar: CustomAppBar(
            height: SizeConfig.heightMultiplier * 9,
            child: appBarDashboardW(widget.baby, context, () {}, () {})),
        body: BlocListener<FormSavingBloc, FormSavingState>(
          listener: (context, state) {
            final formStatus = state.formSubmissionStatus;
            if (formStatus is SubmissionSuccess) {
              showSnackBar(context, formStatus.message);
              Navigator.pop(context);
            }
          },
          child: Container(
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
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Container(
                          height: SizeConfig.heightMultiplier * 12,
                          width: SizeConfig.widthMultiplier * 22,
                          decoration: BoxDecoration(
                              color: greenGray, shape: BoxShape.circle),
                          child: Center(
                            child: SvgPicture.asset('assets/icons/sleeping.svg',
                                height: SizeConfig.heightMultiplier * 6),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.heightMultiplier * 2,
                    ),
                    Center(
                      child: Text(
                        'Sleeping',
                        style: TextStyle(
                            fontSize: SizeConfig.textMultiplier * 2.5,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w700,
                            color: Colors.black38),
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.heightMultiplier * 2,
                    ),
                    BlocBuilder<HomePageCubit, HomePageState>(
                      builder: (context, state) {
                        if (state is HomePageInitial) {
                          return Center(
                            child: Text('loading'),
                          );
                        } else if (state is HomePageCompleted) {
                          var lastWalk = state.babyTasks
                              .where(
                                  (element) => element.taskName == 'sleeping')
                              .toList();
                          var lastwlk = lastWalk.isEmpty
                              ? 'Start'
                              : 'Last: ${timeago.format(DateTime.parse(lastWalk[0].timeStamp))}';

                          return Center(
                            child: Text(
                              lastwlk,
                              style: TextStyle(
                                  fontSize: SizeConfig.textMultiplier * 2,
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.w200,
                                  color: Colors.black38),
                            ),
                          );
                        }
                        return Container();
                      },
                    ),
                    SizedBox(
                      height: SizeConfig.heightMultiplier * 3.5,
                    ),
                    _isRunning
                        ? Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 24),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.grey[50],
                                  borderRadius: BorderRadius.circular(15)),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 12),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          '$days',
                                          style: TextStyle(
                                              fontSize: 32,
                                              fontFamily: 'Montserrat',
                                              fontWeight: FontWeight.w700,
                                              color: Colors.black38),
                                        ),
                                        Text(
                                          'Dys',
                                          style: TextStyle(
                                              fontSize:
                                                  SizeConfig.textMultiplier *
                                                      1.4,
                                              fontFamily: 'Montserrat',
                                              fontWeight: FontWeight.w300,
                                              color: greenGray),
                                        )
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Center(
                                          child: Text(
                                            ':',
                                            style: TextStyle(
                                                fontSize: 32,
                                                fontFamily: 'Montserrat',
                                                fontWeight: FontWeight.w700,
                                                color: Colors.black38),
                                          ),
                                        ),
                                        Container(
                                          color: Colors.black38,
                                          width: 0.2,
                                          height:
                                              SizeConfig.heightMultiplier * 2,
                                        )
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          '$hours',
                                          style: TextStyle(
                                              fontSize: 32,
                                              fontFamily: 'Montserrat',
                                              fontWeight: FontWeight.w700,
                                              color: Colors.black38),
                                        ),
                                        Text(
                                          'Hr',
                                          style: TextStyle(
                                              fontSize:
                                                  SizeConfig.textMultiplier *
                                                      1.4,
                                              fontFamily: 'Montserrat',
                                              fontWeight: FontWeight.w300,
                                              color: greenGray),
                                        )
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Center(
                                          child: Text(
                                            ':',
                                            style: TextStyle(
                                                fontSize: 32,
                                                fontFamily: 'Montserrat',
                                                fontWeight: FontWeight.w700,
                                                color: Colors.black38),
                                          ),
                                        ),
                                        Container(
                                          color: Colors.black38,
                                          width: 0.2,
                                          height:
                                              SizeConfig.heightMultiplier * 2,
                                        )
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          '$minutes',
                                          style: TextStyle(
                                              fontSize: 32,
                                              fontFamily: 'Montserrat',
                                              fontWeight: FontWeight.w700,
                                              color: Colors.black38),
                                        ),
                                        Text(
                                          'Min',
                                          style: TextStyle(
                                              fontSize:
                                                  SizeConfig.textMultiplier *
                                                      1.4,
                                              fontFamily: 'Montserrat',
                                              fontWeight: FontWeight.w300,
                                              color: greenGray),
                                        )
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Center(
                                          child: Text(
                                            ':',
                                            style: TextStyle(
                                                fontSize: 32,
                                                fontFamily: 'Montserrat',
                                                fontWeight: FontWeight.w700,
                                                color: Colors.black38),
                                          ),
                                        ),
                                        Container(
                                          color: Colors.black38,
                                          width: 0.2,
                                          height:
                                              SizeConfig.heightMultiplier * 2,
                                        )
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          '$seconds',
                                          style: TextStyle(
                                              fontSize: 32,
                                              fontFamily: 'Montserrat',
                                              fontWeight: FontWeight.w700,
                                              color: Colors.black38),
                                        ),
                                        Text(
                                          'Sec',
                                          style: TextStyle(
                                              fontSize:
                                                  SizeConfig.textMultiplier *
                                                      1.4,
                                              fontFamily: 'Montserrat',
                                              fontWeight: FontWeight.w300,
                                              color: greenGray),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        : Container(),
                    SizedBox(
                      height: SizeConfig.heightMultiplier * 2,
                    ),
                    Center(
                        child: _isRunning
                            ? GestureDetector(
                                onTap: () => reset(),
                                child: Container(
                                  height: SizeConfig.heightMultiplier * 8,
                                  width: SizeConfig.widthMultiplier * 36,
                                  decoration: BoxDecoration(
                                      color: greenGray,
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.stop_sharp,
                                        color: primaryColor,
                                      ),
                                      SizedBox(
                                        width: SizeConfig.widthMultiplier * 1.5,
                                      ),
                                      Text(
                                        'End Timer',
                                        style: TextStyle(
                                            fontSize:
                                                SizeConfig.textMultiplier * 2.5,
                                            fontFamily: 'Montserrat',
                                            fontWeight: FontWeight.w300,
                                            color: primaryColor),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : Container()),
                    SizedBox(
                      height: SizeConfig.heightMultiplier * 0.5,
                    ),
                    _dtion.inSeconds == 0
                        ? Container()
                        : Center(
                            child: Text(
                              'Duration ${_dtion.inHours}h ${_dtion.inMinutes}min ${_dtion.inSeconds}sec',
                              style: TextStyle(
                                  fontSize: SizeConfig.textMultiplier * 2,
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.w200,
                                  color: Colors.black38),
                            ),
                          ),
                    SizedBox(
                      height: SizeConfig.heightMultiplier * 2,
                    ),
                    _isRunning
                        ? Container()
                        : Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.grey[50],
                                  borderRadius: BorderRadius.circular(15)),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 12),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SvgPicture.asset(
                                      'assets/icons/time.svg',
                                      height: SizeConfig.heightMultiplier * 3,
                                    ),
                                    SizedBox(
                                      width: SizeConfig.widthMultiplier * 2,
                                    ),
                                    Text(
                                      'Time',
                                      style: TextStyle(
                                          fontSize:
                                              SizeConfig.textMultiplier * 2,
                                          fontFamily: 'Montserrat',
                                          fontWeight: FontWeight.w700,
                                          color: Colors.black38),
                                    ),
                                    Spacer(),
                                    GestureDetector(
                                      onTap: () => _showDatePicker(context),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            border:
                                                Border.all(color: greyColor)),
                                        child: Text(
                                          Jiffy(_nowDate).yMMMMd,
                                          style: TextStyle(
                                              fontSize:
                                                  SizeConfig.textMultiplier * 2,
                                              fontFamily: 'Montserrat',
                                              color: Colors.black38,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: SizeConfig.widthMultiplier * 2,
                                    ),
                                    GestureDetector(
                                      onTap: () => _showTimePicker(context),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            border:
                                                Border.all(color: greyColor)),
                                        child: Text(
                                          DateFormat('hh:mm a')
                                              .format(_nowDate),
                                          style: TextStyle(
                                              fontSize:
                                                  SizeConfig.textMultiplier * 2,
                                              fontFamily: 'Montserrat',
                                              color: Colors.black38,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                    SizedBox(
                      height: SizeConfig.heightMultiplier * 2,
                    ),
                    Padding(
                        padding: const EdgeInsets.only(left: 12, right: 12),
                        child: TextFormField(
                            controller: _text,
                            maxLength: 1000,
                            decoration: InputDecoration(
                              labelText: 'Notes',
                              labelStyle: TextStyle(
                                  fontSize: SizeConfig.textMultiplier * 2,
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black38),
                              enabledBorder: new UnderlineInputBorder(
                                  borderSide: new BorderSide(
                                      color: almostGrey, width: 0.8)),
                            ))),
                    SizedBox(
                      height: SizeConfig.heightMultiplier * 4,
                    ),
                    _isRunning
                        ? Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: SizeConfig.widthMultiplier * 8),
                            child: DefaultButtonBsz(
                              text: 'Continue',
                              press: () {
                                Navigator.pop(context);
                              },
                            ))
                        : Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: SizeConfig.widthMultiplier * 8),
                            child: DefaultButtonBsz(
                              text: 'Start Sleeping',
                              press: () {
                                startTime();
                                saveTimer();
                                var di = greenGray.toString();
                                print(di);
                                const start = "Color(";
                                const end = ")";

                                final startIndex = di.indexOf(start);
                                final endIndex =
                                    di.indexOf(end, startIndex + start.length);
                                var fnl = di.substring(
                                    startIndex + start.length, endIndex);
                                BlocProvider.of<HomePageCubit>(context)
                                    .saveTasksWalkingSleeping(
                                        baby: widget.baby,
                                        taskName: 'sleeping',
                                        note: _text.text,
                                        startTime: _nowDate.toString(),
                                        dateTime: _nowDate,
                                        endTime: '',
                                        color: fnl,
                                        duration: _dtion,
                                        taskCompleted: 1);
                                Navigator.pop(context);
                                setState(() {
                                  _stopTimer = true;
                                });
                              },
                            )),
                    SizedBox(
                      height: SizeConfig.heightMultiplier * 2,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showDatePicker(ctx) {
    // showCupertinoModalPopup is a built-in function of the cupertino library
    showCupertinoModalPopup(
        context: ctx,
        builder: (_) => Container(
              height: 500,
              color: Color.fromARGB(255, 255, 255, 255),
              child: Column(
                children: [
                  Container(
                    height: 400,
                    child: CupertinoDatePicker(
                        mode: CupertinoDatePickerMode.date,
                        initialDateTime: _nowDate,
                        onDateTimeChanged: (val) {
                          setState(() {
                            _nowDate = DateTime(
                                val.year,
                                val.month,
                                val.day,
                                _nowDate.hour,
                                _nowDate.minute,
                                _nowDate.second);
                          });
                        }),
                  ),

                  // Close the modal
                  CupertinoButton(
                    child: Text('OK'),
                    onPressed: () => Navigator.of(ctx).pop(),
                  )
                ],
              ),
            ));
  }

  void _showTimePicker(ctx) {
    // showCupertinoModalPopup is a built-in function of the cupertino library
    showCupertinoModalPopup(
        context: ctx,
        builder: (_) => Container(
              height: 500,
              color: Color.fromARGB(255, 255, 255, 255),
              child: Column(
                children: [
                  Container(
                    height: 400,
                    child: CupertinoDatePicker(
                        mode: CupertinoDatePickerMode.time,
                        initialDateTime: _nowDate,
                        onDateTimeChanged: (val) {
                          setState(() {
                            _nowDate = val;
                          });
                        }),
                  ),

                  // Close the modal
                  CupertinoButton(
                    child: Text('OK'),
                    onPressed: () => Navigator.of(ctx).pop(),
                  )
                ],
              ),
            ));
  }
}
