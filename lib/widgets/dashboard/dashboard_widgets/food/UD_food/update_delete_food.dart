import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:momnotebook/bloc/bloc/form_saving_bloc.dart';
import 'package:momnotebook/constants/colors.dart';
import 'package:momnotebook/constants/customAppBar.dart';
import 'package:momnotebook/constants/defaultButton.dart';
import 'package:momnotebook/constants/sizeConfig.dart';
import 'package:momnotebook/cubit/cubit/home_page_cubit.dart';
import 'package:momnotebook/models/baby.dart';
import 'package:momnotebook/models/babyTask.dart';
import 'package:timeago/timeago.dart' as timeago;

class HomeUpdateFood extends StatefulWidget {
  final Baby baby;
  final BabyTask babyTask;
  HomeUpdateFood({Key? key, required this.baby, required this.babyTask})
      : super(key: key);

  @override
  State<HomeUpdateFood> createState() => _HomeUpdateFoodState();
}

class _HomeUpdateFoodState extends State<HomeUpdateFood> {
  DateTime _nowDate = DateTime.now();
  String _dropDownText = 'vegetables';
  String _dropDownW = 'mg';
  final _amount = TextEditingController();

  final _text = TextEditingController();
  List<String> _foodGroups = [
    'meat',
    'fruit',
    'vegetables',
    'bread',
    'cereals'
  ];
  List<String> _foodScale = ['mg', 'g', 'kg'];
  @override
  void initState() {
    _nowDate = DateTime.parse(widget.babyTask.timeStamp);
    _text.text = widget.babyTask.note;
    _amount.text = widget.babyTask.qtyFood;
    _dropDownText = widget.babyTask.groupFood;
    _dropDownW = widget.babyTask.qtyFeeder;
    super.initState();
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
                            color: buttonBGColor, shape: BoxShape.circle),
                        child: Center(
                          child: SvgPicture.asset('assets/icons/food.svg',
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
                      'Food',
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
                            .where((element) => element.taskName == 'food')
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
                            SizedBox(
                              height: SizeConfig.heightMultiplier * 2,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 14),
                                  child: SvgPicture.asset(
                                    'assets/icons/group.svg',
                                    height: SizeConfig.heightMultiplier * 3,
                                  ),
                                ),
                                SizedBox(
                                  width: SizeConfig.widthMultiplier * 2,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 14),
                                  child: Text(
                                    'Group',
                                    style: TextStyle(
                                        fontSize: SizeConfig.textMultiplier * 2,
                                        fontFamily: 'Montserrat',
                                        fontWeight: FontWeight.w700,
                                        color: Colors.black38),
                                  ),
                                ),
                                Spacer(),
                                Expanded(
                                  child: DropdownButtonFormField<String>(
                                    onChanged: (value) {
                                      setState(() {
                                        _dropDownText = value!;
                                      });
                                    },
                                    hint: Text(
                                      '$_dropDownText',
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize:
                                              SizeConfig.textMultiplier * 2,
                                          fontFamily: 'Montserrat',
                                          color: Colors.black38,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    items: _foodGroups.map(
                                      (val) {
                                        return DropdownMenuItem<String>(
                                          child: Text(val),
                                          value: val.toString(),
                                        );
                                      },
                                    ).toList(),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: SizeConfig.heightMultiplier * 2,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 14),
                                  child: SvgPicture.asset(
                                    'assets/icons/amount.svg',
                                    height: SizeConfig.heightMultiplier * 3,
                                  ),
                                ),
                                SizedBox(
                                  width: SizeConfig.widthMultiplier * 2,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 14),
                                  child: Text(
                                    'Amount',
                                    style: TextStyle(
                                        fontSize: SizeConfig.textMultiplier * 2,
                                        fontFamily: 'Montserrat',
                                        fontWeight: FontWeight.w700,
                                        color: Colors.black38),
                                  ),
                                ),
                                Spacer(),
                                Expanded(
                                  child: TextFormField(
                                      textInputAction: TextInputAction.done,
                                      controller: _amount,
                                      keyboardType:
                                          TextInputType.numberWithOptions(
                                              signed: true),
                                      decoration: InputDecoration(
                                        hintText: 'input',
                                        enabledBorder: new UnderlineInputBorder(
                                            borderSide: new BorderSide(
                                                color: almostGrey, width: 0.8)),
                                      )),
                                ),
                                SizedBox(
                                  width: SizeConfig.widthMultiplier * 1.5,
                                ),
                                Expanded(
                                  child: DropdownButtonFormField<String>(
                                    onChanged: (value) {
                                      setState(() {
                                        _dropDownW = value!;
                                      });
                                    },
                                    hint: Text(
                                      '$_dropDownW',
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize:
                                              SizeConfig.textMultiplier * 2,
                                          fontFamily: 'Montserrat',
                                          color: Colors.black38,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    items: _foodScale.map(
                                      (val) {
                                        return DropdownMenuItem<String>(
                                          child: Text(val),
                                          value: val.toString(),
                                        );
                                      },
                                    ).toList(),
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
                    height: SizeConfig.heightMultiplier * 6,
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
                                qtyFood: _amount.text,
                                qtyLeft: '',
                                qtyRight: '',
                                qtyFeeder: _dropDownW,
                                leftBreast: 1,
                                rightBreast: 1,
                                groupFood: _dropDownText,
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
                  SizedBox(
                    height: SizeConfig.heightMultiplier * 2,
                  ),
                ],
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
