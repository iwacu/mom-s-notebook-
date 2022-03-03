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
import 'package:momnotebook/models/babyTask.dart';
import 'package:timeago/timeago.dart' as timeago;

class HomeUpdateSleep extends StatefulWidget {
  final Baby baby;
  final BabyTask babyTask;
  HomeUpdateSleep({Key? key, required this.baby, required this.babyTask})
      : super(key: key);

  @override
  State<HomeUpdateSleep> createState() => _HomeUpdateSleepState();
}

class _HomeUpdateSleepState extends State<HomeUpdateSleep> {
  DateTime? _startDate;
  DateTime? _endDate;
  Duration? duration;
  List<String>? times;

  final _text = TextEditingController();

  @override
  void initState() {
    super.initState();
    _startDate = DateTime.parse(widget.babyTask.startTime);
    _endDate = DateTime.parse(widget.babyTask.endTime);
    _text.text = widget.babyTask.note;
    times = calculateTimeDifferenceBet(
        endDate: DateTime.parse(widget.babyTask.endTime),
        startDate: DateTime.parse(widget.babyTask.startTime));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FormSavingBloc(),
      child: Scaffold(
        backgroundColor: bluewhite,
        appBar: CustomAppBar(
            height: SizeConfig.heightMultiplier * 9,
            child: appBarDashboardUD(widget.baby, context, () {
              BlocProvider.of<HomePageCubit>(context)
                  .removeBabyTask(widget.babyTask.id!);
              Navigator.pop(context);
            })),
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
                    Padding(
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
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    times![0],
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
                                            SizeConfig.textMultiplier * 1.4,
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
                                    height: SizeConfig.heightMultiplier * 2,
                                  )
                                ],
                              ),
                              Column(
                                children: [
                                  Center(
                                    child: Text(
                                      times![1],
                                      style: TextStyle(
                                          fontSize: 32,
                                          fontFamily: 'Montserrat',
                                          fontWeight: FontWeight.w700,
                                          color: Colors.black38),
                                    ),
                                  ),
                                  Center(
                                    child: Text(
                                      'Hr',
                                      style: TextStyle(
                                          fontSize:
                                              SizeConfig.textMultiplier * 1.7,
                                          fontFamily: 'Montserrat',
                                          fontWeight: FontWeight.w300,
                                          color: greenGray),
                                    ),
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
                                    height: SizeConfig.heightMultiplier * 2,
                                  )
                                ],
                              ),
                              Column(
                                children: [
                                  Center(
                                    child: Text(
                                      times![2],
                                      style: TextStyle(
                                          fontSize: 32,
                                          fontFamily: 'Montserrat',
                                          fontWeight: FontWeight.w700,
                                          color: Colors.black38),
                                    ),
                                  ),
                                  Center(
                                    child: Text(
                                      'Min',
                                      style: TextStyle(
                                          fontSize:
                                              SizeConfig.textMultiplier * 1.7,
                                          fontFamily: 'Montserrat',
                                          fontWeight: FontWeight.w300,
                                          color: greenGray),
                                    ),
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
                                    height: SizeConfig.heightMultiplier * 2,
                                  )
                                ],
                              ),
                              Column(
                                children: [
                                  Center(
                                    child: Text(
                                      times![3],
                                      style: TextStyle(
                                          fontSize: 32,
                                          fontFamily: 'Montserrat',
                                          fontWeight: FontWeight.w700,
                                          color: Colors.black38),
                                    ),
                                  ),
                                  Center(
                                    child: Text(
                                      'Sec',
                                      style: TextStyle(
                                          fontSize:
                                              SizeConfig.textMultiplier * 1.7,
                                          fontFamily: 'Montserrat',
                                          fontWeight: FontWeight.w300,
                                          color: greenGray),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.heightMultiplier * 2,
                    ),
                    Padding(
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
                                'Start',
                                style: TextStyle(
                                    fontSize: SizeConfig.textMultiplier * 2,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black38),
                              ),
                              Spacer(),
                              GestureDetector(
                                onTap: () => _showDatePickerStart(context),
                                child: Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(color: greyColor)),
                                  child: Text(
                                    Jiffy(_startDate).yMMMMd,
                                    style: TextStyle(
                                        fontSize: SizeConfig.textMultiplier * 2,
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
                                onTap: () => _showTimePickerStart(context),
                                child: Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(color: greyColor)),
                                  child: Text(
                                    DateFormat('hh:mm a').format(_startDate!),
                                    style: TextStyle(
                                        fontSize: SizeConfig.textMultiplier * 2,
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
                      height: SizeConfig.heightMultiplier * 1.5,
                    ),
                    Padding(
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
                                'End',
                                style: TextStyle(
                                    fontSize: SizeConfig.textMultiplier * 2,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black38),
                              ),
                              Spacer(),
                              GestureDetector(
                                onTap: () => _showDatePickerEnd(context),
                                child: Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(color: greyColor)),
                                  child: Text(
                                    Jiffy(_endDate).yMMMMd,
                                    style: TextStyle(
                                        fontSize: SizeConfig.textMultiplier * 2,
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
                                onTap: () => _showTimePickerEnd(context),
                                child: Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(color: greyColor)),
                                  child: Text(
                                    DateFormat('hh:mm a').format(_endDate!),
                                    style: TextStyle(
                                        fontSize: SizeConfig.textMultiplier * 2,
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
                    Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: SizeConfig.widthMultiplier * 8),
                        child: DefaultButtonBsz(
                          text: 'Update',
                          press: () {
                            if (_startDate!.isAfter(_endDate!)) {
                              showSnackBar(context,
                                  'Starting Date and Time must be inferior to End Date and Time');
                            } else {
                              BlocProvider.of<HomePageCubit>(context)
                                  .updateBabyTask(BabyTask(
                                      id: widget.babyTask.id,
                                      babyId: widget.babyTask.babyId,
                                      taskName: widget.babyTask.taskName,
                                      timeStamp: _endDate.toString(),
                                      note: _text.text,
                                      startTime: _startDate.toString(),
                                      endTime: _endDate.toString(),
                                      resumeTime: '',
                                      qtyFood: '',
                                      qtyLeft: '',
                                      qtyRight: '',
                                      qtyFeeder: '',
                                      leftBreast: 1,
                                      rightBreast: 1,
                                      groupFood: '',
                                      pee: 1,
                                      poo: 1,
                                      durationH: '0',
                                      durationM: '0',
                                      durationS: '0',
                                      color: widget.babyTask.color,
                                      onTaskCompleted:
                                          widget.babyTask.onTaskCompleted));
                              Navigator.pop(context);
                            }
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

  void _showDatePickerStart(ctx) {
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
                        initialDateTime: _startDate,
                        onDateTimeChanged: (val) {
                          setState(() {
                            _startDate = DateTime(
                                val.year,
                                val.month,
                                val.day,
                                _startDate!.hour,
                                _startDate!.minute,
                                _startDate!.second);
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

  void _showTimePickerStart(ctx) {
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
                        initialDateTime: _startDate,
                        onDateTimeChanged: (val) {
                          setState(() {
                            _startDate = DateTime(
                                _startDate!.year,
                                _startDate!.month,
                                _startDate!.day,
                                val.hour,
                                val.minute,
                                val.second);
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

  void _showDatePickerEnd(ctx) {
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
                        initialDateTime: _endDate,
                        onDateTimeChanged: (val) {
                          setState(() {
                            _endDate = DateTime(
                                val.year,
                                val.month,
                                val.day,
                                _endDate!.hour,
                                _endDate!.minute,
                                _endDate!.second);
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

  void _showTimePickerEnd(ctx) {
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
                        initialDateTime: _endDate,
                        onDateTimeChanged: (val) {
                          setState(() {
                            _endDate = DateTime(
                                _endDate!.year,
                                _endDate!.month,
                                _endDate!.day,
                                val.hour,
                                val.minute,
                                val.second);
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

List<String> calculateTimeDifferenceBet(
    {required DateTime startDate, required DateTime endDate}) {
  String twoDigits(int n) => n.toString().padLeft(2, '0');
  var days = endDate.difference(startDate).inDays;
  var hours = endDate.difference(startDate).inHours - (24 * days);
  var minutes = endDate.difference(startDate).inMinutes -
      (60 * endDate.difference(startDate).inHours);
  var seconds = endDate.difference(startDate).inSeconds ~/ 86400;
  List<String> time = [
    twoDigits(days),
    twoDigits(hours),
    twoDigits(minutes),
    twoDigits(seconds)
  ];
  return time;
}
