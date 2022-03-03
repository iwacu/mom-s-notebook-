import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:holding_gesture/holding_gesture.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:momnotebook/constants/colors.dart';
import 'package:momnotebook/constants/customAppBar.dart';
import 'package:momnotebook/constants/defaultButton.dart';
import 'package:momnotebook/constants/sizeConfig.dart';
import 'package:momnotebook/cubit/cubit/counter_cubit.dart';
import 'package:momnotebook/cubit/cubit/home_page_cubit.dart';
import 'package:momnotebook/models/baby.dart';
import 'package:momnotebook/models/babyTask.dart';
import 'package:timeago/timeago.dart' as timeago;

class HomeUpdateFeeder extends StatefulWidget {
  final Baby baby;
  final BabyTask babyTask;
  HomeUpdateFeeder({Key? key, required this.baby, required this.babyTask})
      : super(key: key);

  @override
  State<HomeUpdateFeeder> createState() => _HomeUpdateFeederState();
}

class _HomeUpdateFeederState extends State<HomeUpdateFeeder> {
  DateTime _nowDate = DateTime.now();
  final _text = TextEditingController();
  @override
  void initState() {
    _nowDate = DateTime.parse(widget.babyTask.timeStamp);
    _text.text = widget.babyTask.note;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CounterCubit(int.parse(widget.babyTask.qtyFood)),
      child: Scaffold(
        backgroundColor: bluewhite,
        appBar: CustomAppBar(
            height: SizeConfig.heightMultiplier * 9,
            child: appBarDashboardUD(widget.baby, context, () {
              BlocProvider.of<HomePageCubit>(context)
                  .removeBabyTask(widget.babyTask.id!);
              Navigator.pop(context);
            })),
        body: BlocBuilder<CounterCubit, CounterState>(
          builder: (context, state) {
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
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Container(
                            height: SizeConfig.heightMultiplier * 18,
                            width: SizeConfig.widthMultiplier * 28,
                            decoration: BoxDecoration(
                                color: movGray, shape: BoxShape.circle),
                            child: Center(
                              child: SvgPicture.asset('assets/icons/feeder.svg',
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
                          'Feeder',
                          style: TextStyle(
                              fontSize: SizeConfig.textMultiplier * 3,
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
                                    (element) => element.taskName == 'feeder')
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
                                        border: Border.all(color: greyColor)),
                                    child: Text(
                                      DateFormat('hh:mm a').format(_nowDate),
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
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.grey[50],
                              borderRadius: BorderRadius.circular(15)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 44, vertical: 12),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                HoldDetector(
                                  onHold: () =>
                                      context.read<CounterCubit>().decrement(),
                                  child: SvgPicture.asset(
                                      'assets/icons/minus-circle.svg',
                                      height: SizeConfig.heightMultiplier * 6),
                                ),
                                Text(
                                  '${state.countValue.toString()} ml',
                                  style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      fontSize: SizeConfig.textMultiplier * 2,
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black38),
                                ),
                                HoldDetector(
                                  onHold: () =>
                                      context.read<CounterCubit>().increment(),
                                  child: SvgPicture.asset(
                                      'assets/icons/icon-add.svg',
                                      height: SizeConfig.heightMultiplier * 6),
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
                        height: SizeConfig.heightMultiplier * 10,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: SizeConfig.widthMultiplier * 8),
                        child: DefaultButtonBsz(
                          text: 'Update',
                          press: () {
                            BlocProvider.of<HomePageCubit>(context)
                                .updateBabyTask(BabyTask(
                                    id: widget.babyTask.id,
                                    babyId: widget.babyTask.babyId,
                                    taskName: widget.babyTask.taskName,
                                    timeStamp: _nowDate.toString(),
                                    note: _text.text,
                                    startTime: '',
                                    endTime: '',
                                    resumeTime: '',
                                    qtyFood: state.countValue.toString(),
                                    qtyLeft: '',
                                    qtyRight: '',
                                    qtyFeeder: '',
                                    leftBreast: 1,
                                    rightBreast: 1,
                                    groupFood: widget.babyTask.groupFood,
                                    pee: 1,
                                    poo: 1,
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
                    ],
                  ),
                ),
              ),
            );
          },
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
