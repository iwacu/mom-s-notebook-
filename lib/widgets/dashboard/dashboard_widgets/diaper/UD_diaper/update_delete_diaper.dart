import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:momnotebook/constants/colors.dart';
import 'package:momnotebook/constants/customAppBar.dart';
import 'package:momnotebook/constants/defaultButton.dart';
import 'package:momnotebook/constants/sizeConfig.dart';
import 'package:momnotebook/cubit/cubit/home_page_cubit.dart';
import 'package:momnotebook/models/baby.dart';
import 'package:momnotebook/models/babyTask.dart';
import 'package:timeago/timeago.dart' as timeago;

class HomeUpdateDeleteDiaper extends StatefulWidget {
  final Baby baby;
  final BabyTask babyTask;
  const HomeUpdateDeleteDiaper(
      {Key? key, required this.baby, required this.babyTask})
      : super(key: key);

  @override
  _HomeUpdateDeleteDiaperState createState() => _HomeUpdateDeleteDiaperState();
}

class _HomeUpdateDeleteDiaperState extends State<HomeUpdateDeleteDiaper> {
  DateTime _nowDate = DateTime.now();
  bool _pee = false;
  bool _poop = false;
  final _text = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nowDate = DateTime.parse(widget.babyTask.timeStamp);
    _text.text = widget.babyTask.note;
    _pee = widget.babyTask.pee == 0 ? true : false;
    _poop = widget.babyTask.poo == 0 ? true : false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bluewhite,
      appBar: CustomAppBar(
          height: SizeConfig.heightMultiplier * 9,
          child: appBarDashboardUD(widget.baby, context, () {
            BlocProvider.of<HomePageCubit>(context)
                .removeBabyTask(widget.babyTask.id!);
            Navigator.pop(context);
          })),
      body: Container(
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
                          color: greenAccGray, shape: BoxShape.circle),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 12),
                          child: SvgPicture.asset('assets/icons/diaper.svg',
                              height: SizeConfig.heightMultiplier * 6),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: SizeConfig.heightMultiplier * 4,
                ),
                Center(
                  child: Text(
                    'Diaper',
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
                      var lastdps = state.babyTasks
                          .where((element) => element.taskName == 'diaper')
                          .toList();
                      var lastdp = lastdps.isEmpty
                          ? 'Start'
                          : 'Last: ${timeago.format(DateTime.parse(lastdps[0].timeStamp))}';
                      return Center(
                        child: Text(
                          lastdp,
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
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(15)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
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
                                    fontSize: SizeConfig.textMultiplier * 2,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black38),
                              ),
                              Spacer(),
                              GestureDetector(
                                onTap: () => _showDatePicker(context),
                                child: Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(color: greyColor)),
                                  child: Text(
                                    Jiffy(_nowDate).MMMEd,
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
                                onTap: () => _showTimePicker(context),
                                child: Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(color: greyColor)),
                                  child: Text(
                                    DateFormat('hh:mm a').format(_nowDate),
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
                          SizedBox(
                            height: SizeConfig.heightMultiplier * 2,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () => setState(() => _pee = !_pee),
                                child: Container(
                                  height: SizeConfig.heightMultiplier * 8,
                                  width: SizeConfig.widthMultiplier * 36,
                                  decoration: BoxDecoration(
                                      color: _pee ? greenAccGray : bluewhite,
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(
                                        'assets/icons/pee.svg',
                                        height: SizeConfig.heightMultiplier * 3,
                                        color: _pee
                                            ? primaryColor
                                            : Colors.black38,
                                      ),
                                      SizedBox(
                                        width: SizeConfig.widthMultiplier * 1.5,
                                      ),
                                      Text(
                                        'Pee',
                                        style: TextStyle(
                                            fontSize:
                                                SizeConfig.textMultiplier * 2,
                                            fontFamily: 'Montserrat',
                                            fontWeight: FontWeight.w700,
                                            color: _pee
                                                ? primaryColor
                                                : Colors.black38),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () => setState(() => _poop = !_poop),
                                child: Container(
                                  height: SizeConfig.heightMultiplier * 8,
                                  width: SizeConfig.widthMultiplier * 36,
                                  decoration: BoxDecoration(
                                      color: _poop ? greenAccGray : bluewhite,
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(
                                        'assets/icons/poop.svg',
                                        height: SizeConfig.heightMultiplier * 3,
                                        color: _poop
                                            ? primaryColor
                                            : Colors.black38,
                                      ),
                                      SizedBox(
                                        width: SizeConfig.widthMultiplier * 1.5,
                                      ),
                                      Text(
                                        'Poop',
                                        style: TextStyle(
                                            fontSize:
                                                SizeConfig.textMultiplier * 2,
                                            fontFamily: 'Montserrat',
                                            fontWeight: FontWeight.w700,
                                            color: _poop
                                                ? primaryColor
                                                : Colors.black38),
                                      )
                                    ],
                                  ),
                                ),
                              ),
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
                  height: SizeConfig.heightMultiplier * 12,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.widthMultiplier * 8),
                  child: DefaultButtonBsz(
                    text: 'Update',
                    press: () {
                      BlocProvider.of<HomePageCubit>(context).updateBabyTask(
                          BabyTask(
                              id: widget.babyTask.id,
                              babyId: widget.babyTask.babyId,
                              taskName: widget.babyTask.taskName,
                              timeStamp: _nowDate.toString(),
                              note: _text.text,
                              startTime: '',
                              endTime: '',
                              resumeTime: '',
                              qtyFood: '',
                              qtyLeft: '',
                              qtyRight: '',
                              qtyFeeder: '',
                              leftBreast: 1,
                              rightBreast: 1,
                              groupFood: '',
                              pee: _pee ? 0 : 1,
                              poo: _poop ? 0 : 1,
                              durationH: '',
                              durationM: '',
                              durationS: '',
                              color: widget.babyTask.color,
                              onTaskCompleted:
                                  widget.babyTask.onTaskCompleted));
                      Navigator.pop(context);
                    },
                  ),
                ),
                SizedBox(
                  height: SizeConfig.heightMultiplier * 2,
                ),
              ],
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
                          print(_nowDate);
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
                          print(_nowDate);
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
