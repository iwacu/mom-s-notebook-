import 'package:flutter/material.dart';
import 'package:momnotebook/constants/colors.dart';
import 'package:momnotebook/models/babyTask.dart';

class TimeLineChart extends CustomPainter {
  final DateTime startTime, endTime, selectedTime;
  final List<BabyTask> babyTask;

  TimeLineChart(this.startTime, this.endTime, this.babyTask, this.selectedTime);

  @override
  void paint(Canvas canvas, Size size) {
    drawRectangle(size, canvas);
  }

  void drawRectangle(Size size, Canvas canvas) {
    final paint = Paint()
      ..color = primaryColor
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 1;
    final a = Offset(size.width * 0.0, 0.0);
    final b = Offset(size.width * 1, size.height);
    final rect = Rect.fromPoints(a, b);
    canvas.drawRect(rect, paint);

    drawShadowRectangle(canvas, size);
    drwaFixedShadowRectangle(canvas, size);
    drawHorizontalLines(canvas, size);
  }

  void drawShadowRectangle(Canvas canvas, Size size) {
    var mondaP = 7.9;
    var tueP = 3.5;
    var wend = 2.5;
    var thuP = 1.85;
    var fridP = 1.48;
    var satP = 1.24;
    var suP = 1.06;
    final paint = Paint()
      ..color = buttonBGColor.withOpacity(0.25)
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 1;

    switch (selectedTime.weekday) {
      case 1:
        {
          final a = Offset(size.width * 1 / 24, size.height * 0.0);
          final b = Offset(size.width * 1 / 6, size.height);
          final rect = Rect.fromPoints(a, b);
          canvas.drawRect(rect, paint);
        }

        break;
      case 2:
        {
          final a = Offset(size.width * 1 / 6, size.height * 0.0);
          final b = Offset(size.width * 7 / 22, size.height);
          final rect = Rect.fromPoints(a, b);
          canvas.drawRect(rect, paint);
        }
        break;
      case 3:
        {
          final a = Offset(size.width * 7 / 22.4, size.height * 0.0);
          final b = Offset(size.width * 31 / 68, size.height);
          final rect = Rect.fromPoints(a, b);
          canvas.drawRect(rect, paint);
        }
        break;
      case 4:
        {
          final a = Offset(size.width * 31 / 68, size.height * 0.0);
          final b = Offset(size.width * 1 / 1.7, size.height);
          final rect = Rect.fromPoints(a, b);
          canvas.drawRect(rect, paint);
        }
        break;
      case 5:
        {
          final a = Offset(size.width * 1 / 1.7, size.height * 0.0);
          final b = Offset(size.width * 1 / 1.38, size.height);
          final rect = Rect.fromPoints(a, b);
          canvas.drawRect(rect, paint);
        }
        break;
      case 6:
        {
          final a = Offset(size.width * 1 / 1.38, size.height * 0.0);
          final b = Offset(size.width * 1 / 1.14, size.height);
          final rect = Rect.fromPoints(a, b);
          canvas.drawRect(rect, paint);
        }
        break;
      case 7:
        {
          final a = Offset(size.width * 1 / 1.16, size.height * 0.0);
          final b = Offset(size.width * 1, size.height);
          final rect = Rect.fromPoints(a, b);
          canvas.drawRect(rect, paint);
        }
        break;
      default:
    }
  }

  void drawHorizontalLines(Canvas canvas, Size size) {
    var i = 1;

    var c = 0.02;
    final paint = Paint()
      ..color = Colors.black12
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 0.9;

    while (i <= 24) {
      var getValues = babyTask
          .where((element) => DateTime.parse(element.timeStamp).hour == i)
          .toList();

      getValues.sort((a, b) => a.timeStamp.compareTo(b.timeStamp));
      var getTimeValues = getValues
          .where((element) =>
              DateTime.parse(element.timeStamp).isBefore(endTime) &&
              DateTime.parse(element.timeStamp).isAfter(startTime))
          .toList();

      canvas.drawLine(
        Offset((size.width * 1 / 29), (size.height * c)),
        Offset(size.width, (size.height * c)),
        paint,
      );
      drawText(canvas, size, i, c);
      getByDates(canvas, size, i, c, getTimeValues);
      c = c + 0.04;

      i++;
    }
  }

  void drwaFixedShadowRectangle(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = greyColor.withOpacity(0.45)
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 1;
    //  hhhhhhhhhhhhh
    // final a1 = Offset(size.width * 1 / 24, size.height * 0.0);
    // final b1 = Offset(size.width * 1 / 6, size.height);
    // final rect1 = Rect.fromPoints(a1, b1);
    // canvas.drawRect(rect1, paint);

    final a2 = Offset(size.width * 1 / 6, size.height * 0.0);
    final b2 = Offset(size.width * 7 / 22, size.height);
    final rect2 = Rect.fromPoints(a2, b2);
    canvas.drawRect(rect2, paint);

    // final a3 = Offset(size.width * 7 / 22.4, size.height * 0.0);
    // final b3 = Offset(size.width * 31 / 68, size.height);
    // final rect3 = Rect.fromPoints(a3, b3);
    // canvas.drawRect(rect3, paint);

    final a4 = Offset(size.width * 31 / 68, size.height * 0.0);
    final b4 = Offset(size.width * 1 / 1.7, size.height);
    final rect4 = Rect.fromPoints(a4, b4);
    canvas.drawRect(rect4, paint);

    // final a5 = Offset(size.width * 1 / 1.7, size.height * 0.0);
    // final b5 = Offset(size.width * 1 / 1.38, size.height);
    // final rect5 = Rect.fromPoints(a5, b5);
    // canvas.drawRect(rect5, paint);

    final a6 = Offset(size.width * 1 / 1.38, size.height * 0.0);
    final b6 = Offset(size.width * 1 / 1.14, size.height);
    final rect6 = Rect.fromPoints(a6, b6);
    canvas.drawRect(rect6, paint);

    // final a7 = Offset(size.width * 1 / 1.16, size.height * 0.0);
    // final b7 = Offset(size.width * 1, size.height);
    // final rect7 = Rect.fromPoints(a7, b7);
    // canvas.drawRect(rect7, paint);
  }

  void getByDates(
      Canvas canvas, Size size, int i, double c, List<BabyTask> tasks) {
    var mondaP = 16.0;
    var tueP = 3.5;
    var wend = 2.5;
    var thuP = 1.85;
    var fridP = 1.48;
    var satP = 1.24;
    var suP = 1.08;
    var co = 0.1;
    tasks.asMap().forEach((index, value) {
      final paint = Paint()
        ..color = Color(int.parse(value.color))
        ..strokeWidth = 4.0
        ..style = PaintingStyle.fill;
      final paintLine = Paint()
        ..color = Color(int.parse(value.color))
        ..strokeWidth = 10.0
        ..style = PaintingStyle.fill;
      switch (DateTime.parse(value.timeStamp).weekday) {
        case 1:
          {
            drawCirleAndLine1(canvas, size, i, c, value, paint, paintLine,
                index, mondaP, tasks.length, co);
          }
          break;
        case 2:
          {
            drawCirleAndLine2(canvas, size, i, c, value, paint, paintLine,
                index, tueP, tasks.length, co);
          }
          break;
        case 3:
          {
            drawCirleAndLine3(canvas, size, i, c, value, paint, paintLine,
                index, wend, tasks.length, co);
            co = co + 0.1;
          }
          break;
        case 4:
          {
            drawCirleAndLine4(canvas, size, i, c, value, paint, paintLine,
                index, thuP, tasks.length, co);
          }
          break;
        case 5:
          {
            drawCirleAndLine5(canvas, size, i, c, value, paint, paintLine,
                index, fridP, tasks.length, co);
          }
          break;
        case 6:
          {
            drawCirleAndLine6(canvas, size, i, c, value, paint, paintLine,
                index, satP, tasks.length, co);
          }
          break;
        case 7:
          {
            drawCirleAndLine7(canvas, size, i, c, value, paint, paintLine,
                index, suP, tasks.length, co);
          }
          break;
        default:
          break;
      }
    });
  }

  void drawText(Canvas canvas, Size size, int i, double c) {
    TextSpan span = new TextSpan(
        style: new TextStyle(color: Colors.blue[800]),
        text: i % 2 != 0 ? '' : i.toString());
    TextPainter tp = new TextPainter(
        text: span,
        textAlign: TextAlign.left,
        textDirection: TextDirection.ltr);
    tp.layout();
    tp.paint(canvas, new Offset((size.width * 1 / 54), size.height * c));
  }

  void drawCirleAndLine1(
      Canvas canvas,
      Size size,
      int i,
      double c,
      BabyTask value,
      Paint paint,
      Paint paintLine,
      int index,
      double datePosition,
      int taskLength,
      double co) {
    if (value.taskName == 'sleeping' || value.taskName == 'walking') {
      // var startTime = DateTime.parse(value.startTime);
      // var endTime = DateTime.parse(value.endTime);
      // var finalStartTime = (0.02 * (startTime.hour + (startTime.minute / 10))) +
      //     (0.02 * ((startTime.hour + (startTime.minute / 10)) - 1));
      // var finalEndTime = (0.02 * (endTime.hour + (endTime.minute / 10))) +
      //     (0.02 * ((endTime.hour + (endTime.minute / 10)) - 1));
      // drawLineTimeLine(canvas, size, paintLine, index, c, finalStartTime,
      //     finalEndTime, datePosition);
      drawLineTime(canvas, size, paintLine, datePosition, c, i, value, co);
    } else {
      switch (taskLength) {
        case 1:
          {
            canvas.drawCircle(
                new Offset(size.width * 1 / datePosition, size.height * c),
                size.width * 1 / 50,
                paint);
          }
          break;
        case 2:
          {
            canvas.drawCircle(
                new Offset(size.width * 1 / (datePosition - (index * 8)),
                    size.height * c),
                size.width * 1 / 50,
                paint);
          }
          break;
        case 3:
          {
            canvas.drawCircle(
                new Offset(size.width * 1 / (datePosition - (index / 30)),
                    size.height * c),
                size.width * 1 / 50,
                paint);
          }
          break;
        case 4:
          {
            canvas.drawCircle(
                new Offset(size.width * 1 / (datePosition - (index * 3)),
                    size.height * c),
                size.width * 1 / 50,
                paint);
          }
          break;

        default:
      }
    }
  }

  void drawCirleAndLine2(
      Canvas canvas,
      Size size,
      int i,
      double c,
      BabyTask value,
      Paint paint,
      Paint paintLine,
      int index,
      double datePosition,
      int taskLength,
      double co) {
    if (value.taskName == 'sleeping' || value.taskName == 'walking') {
      // var startTime = DateTime.parse(value.startTime);
      // var endTime = DateTime.parse(value.endTime);
      // var finalStartTime = (0.02 * (startTime.hour + (startTime.minute / 10))) +
      //     (0.02 * ((startTime.hour + (startTime.minute / 10)) - 1));
      // var finalEndTime = (0.02 * (endTime.hour + (endTime.minute / 10))) +
      //     (0.02 * ((endTime.hour + (endTime.minute / 10)) - 1));
      // drawLineTimeLine(canvas, size, paintLine, index, c, finalStartTime,
      //     finalEndTime, datePosition);
      drawLineTime(canvas, size, paintLine, datePosition, c, i, value, co);
    } else {
      switch (taskLength) {
        case 1:
          {
            canvas.drawCircle(
                new Offset(
                    size.width * 1 / (datePosition + 1.4), size.height * c),
                size.width * 1 / 50,
                paint);
          }
          break;
        case 2:
          {
            canvas.drawCircle(
                new Offset(size.width * 1 / ((datePosition + 1.4) - index),
                    size.height * c),
                size.width * 1 / 50,
                paint);
          }
          break;
        case 3:
          {
            canvas.drawCircle(
                new Offset(
                    size.width * 1 / ((datePosition + 1.4) - (index / 2)),
                    size.height * c),
                size.width * 1 / 50,
                paint);
          }
          break;
        case 4:
          {
            canvas.drawCircle(
                new Offset(
                    size.width * 1 / ((datePosition + 1.4) - (index / 3)),
                    size.height * c),
                size.width * 1 / 50,
                paint);
          }
          break;

        default:
          {
            canvas.drawCircle(
                new Offset(
                    size.width * 1 / ((datePosition + 1.4) - (index / 3)),
                    size.height * c),
                size.width * 1 / 50,
                paint);
          }
          break;
      }
    }
  }

  void drawCirleAndLine3(
      Canvas canvas,
      Size size,
      int ij,
      double c,
      BabyTask value,
      Paint paint,
      Paint paintLine,
      int index,
      double datePosition,
      int taskLength,
      double co) {
    if (value.taskName == 'sleeping' || value.taskName == 'walking') {
      // var startTime = DateTime.parse(value.startTime);
      // var endTime = DateTime.parse(value.endTime);
      // var finalStartTime = (0.02 * (startTime.hour + (startTime.minute / 10))) +
      //     (0.02 * ((startTime.hour + (startTime.minute / 10)) - 1));
      // var finalEndTime = (0.02 * (endTime.hour + (endTime.minute / 10))) +
      //     (0.02 * ((endTime.hour + (endTime.minute / 10)) - 1));
      drawLineTime(canvas, size, paintLine, datePosition, c, ij, value, co);
      // drawLineTimeLine(canvas, size, paintLine, index, c, finalStartTime,
      //     finalEndTime, datePosition);
    } else {
      switch (taskLength) {
        case 1:
          {
            canvas.drawCircle(
                new Offset(
                    size.width * 1 / (datePosition + 0.4), size.height * c),
                size.width * 1 / 50,
                paint);
          }
          break;
        case 2:
          {
            canvas.drawCircle(
                new Offset(
                    size.width * 1 / ((datePosition + 0.4) - (index / 3)),
                    size.height * c),
                size.width * 1 / 50,
                paint);
          }
          break;
        case 3:
          {
            canvas.drawCircle(
                new Offset(
                    size.width * 1 / ((datePosition + 0.4) - (index / 4)),
                    size.height * c),
                size.width * 1 / 50,
                paint);
          }
          break;
        case 4:
          {
            canvas.drawCircle(
                new Offset(
                    size.width * 1 / ((datePosition + 0.4) - (index / 8)),
                    size.height * c),
                size.width * 1 / 50,
                paint);
          }
          break;

        default:
          {
            canvas.drawCircle(
                new Offset(
                    size.width * 1 / ((datePosition + 0.4) - (index / 8)),
                    size.height * c),
                size.width * 1 / 50,
                paint);
          }
          break;
      }
    }
  }

  void drawCirleAndLine4(
      Canvas canvas,
      Size size,
      int i,
      double c,
      BabyTask value,
      Paint paint,
      Paint paintLine,
      int index,
      double datePosition,
      int taskLength,
      double co) {
    if (value.taskName == 'sleeping' || value.taskName == 'walking') {
      // var startTime = DateTime.parse(value.startTime);
      // var endTime = DateTime.parse(value.endTime);
      // var finalStartTime = (0.02 * (startTime.hour + (startTime.minute / 10))) +
      //     (0.02 * ((startTime.hour + (startTime.minute / 10)) - 1));
      // var finalEndTime = (0.02 * (endTime.hour + (endTime.minute / 10))) +
      //     (0.02 * ((endTime.hour + (endTime.minute / 10)) - 1));
      // drawLineTimeLine(canvas, size, paintLine, index, c, finalStartTime,
      //     finalEndTime, datePosition);
      drawLineTime(canvas, size, paintLine, datePosition, c, i, value, co);
    } else {
      switch (taskLength) {
        case 1:
          {
            canvas.drawCircle(
                new Offset(
                    size.width * 1 / (datePosition + 0.2), size.height * c),
                size.width * 1 / 50,
                paint);
          }
          break;
        case 2:
          {
            canvas.drawCircle(
                new Offset(
                    size.width * 1 / ((datePosition + 0.2) - (index / 4)),
                    size.height * c),
                size.width * 1 / 50,
                paint);
          }
          break;
        case 3:
          {
            canvas.drawCircle(
                new Offset(
                    size.width * 1 / ((datePosition + 0.2) - (index / 6)),
                    size.height * c),
                size.width * 1 / 50,
                paint);
          }
          break;
        case 4:
          {
            canvas.drawCircle(
                new Offset(
                    size.width * 1 / ((datePosition + 0.2) - (index / 12)),
                    size.height * c),
                size.width * 1 / 50,
                paint);
          }
          break;

        default:
          {
            canvas.drawCircle(
                new Offset(
                    size.width * 1 / ((datePosition + 0.2) - (index / 12)),
                    size.height * c),
                size.width * 1 / 50,
                paint);
          }
          break;
      }
    }
  }

  void drawCirleAndLine5(
      Canvas canvas,
      Size size,
      int i,
      double c,
      BabyTask value,
      Paint paint,
      Paint paintLine,
      int index,
      double datePosition,
      int taskLength,
      double co) {
    if (value.taskName == 'sleeping' || value.taskName == 'walking') {
      // var startTime = DateTime.parse(value.startTime);
      // var endTime = DateTime.parse(value.endTime);
      // var finalStartTime = (0.02 * (startTime.hour + (startTime.minute / 10))) +
      //     (0.02 * ((startTime.hour + (startTime.minute / 10)) - 1));
      // var finalEndTime = (0.02 * (endTime.hour + (endTime.minute / 10))) +
      //     (0.02 * ((endTime.hour + (endTime.minute / 10)) - 1));
      // drawLineTimeLine(canvas, size, paintLine, index, c, finalStartTime,
      //     finalEndTime, datePosition);
      drawLineTime(canvas, size, paintLine, datePosition, c, i, value, co);
    } else {
      switch (taskLength) {
        case 1:
          {
            canvas.drawCircle(
                new Offset(
                    size.width * 1 / (datePosition + 0.16), size.height * c),
                size.width * 1 / 50,
                paint);
          }
          break;
        case 2:
          {
            canvas.drawCircle(
                new Offset(
                    size.width * 1 / ((datePosition + 0.16) - (index / 6)),
                    size.height * c),
                size.width * 1 / 50,
                paint);
          }
          break;
        case 3:
          {
            canvas.drawCircle(
                new Offset(
                    size.width * 1 / ((datePosition + 0.16) - (index / 8)),
                    size.height * c),
                size.width * 1 / 50,
                paint);
          }
          break;
        case 4:
          {
            canvas.drawCircle(
                new Offset(
                    size.width * 1 / ((datePosition + 0.16) - (index / 16)),
                    size.height * c),
                size.width * 1 / 50,
                paint);
          }
          break;

        default:
          {
            canvas.drawCircle(
                new Offset(
                    size.width * 1 / ((datePosition + 0.16) - (index / 16)),
                    size.height * c),
                size.width * 1 / 50,
                paint);
          }
          break;
      }
    }
  }

  void drawCirleAndLine6(
      Canvas canvas,
      Size size,
      int i,
      double c,
      BabyTask value,
      Paint paint,
      Paint paintLine,
      int index,
      double datePosition,
      int taskLength,
      double co) {
    if (value.taskName == 'sleeping' || value.taskName == 'walking') {
      // var startTime = DateTime.parse(value.startTime);
      // var endTime = DateTime.parse(value.endTime);
      // var finalStartTime = (0.02 * (startTime.hour + (startTime.minute / 10))) +
      //     (0.02 * ((startTime.hour + (startTime.minute / 10)) - 1));
      // var finalEndTime = (0.02 * (endTime.hour + (endTime.minute / 10))) +
      //     (0.02 * ((endTime.hour + (endTime.minute / 10)) - 1));
      // drawLineTimeLine(canvas, size, paintLine, index, c, finalStartTime,
      //     finalEndTime, datePosition);
      drawLineTime(canvas, size, paintLine, datePosition, c, i, value, co);
    } else {
      switch (taskLength) {
        case 1:
          {
            canvas.drawCircle(
                new Offset(
                    size.width * 1 / (datePosition + 0.10), size.height * c),
                size.width * 1 / 50,
                paint);
          }
          break;
        case 2:
          {
            canvas.drawCircle(
                new Offset(
                    size.width * 1 / ((datePosition + 0.10) - (index / 8)),
                    size.height * c),
                size.width * 1 / 50,
                paint);
          }
          break;
        case 3:
          {
            canvas.drawCircle(
                new Offset(
                    size.width * 1 / ((datePosition + 0.10) - (index / 10)),
                    size.height * c),
                size.width * 1 / 50,
                paint);
          }
          break;
        case 4:
          {
            canvas.drawCircle(
                new Offset(
                    size.width * 1 / ((datePosition + 0.10) - (index / 20)),
                    size.height * c),
                size.width * 1 / 50,
                paint);
          }
          break;

        default:
          {
            canvas.drawCircle(
                new Offset(
                    size.width * 1 / ((datePosition + 0.10) - (index / 20)),
                    size.height * c),
                size.width * 1 / 50,
                paint);
          }
          break;
      }
    }
  }

  void drawCirleAndLine7(
      Canvas canvas,
      Size size,
      int i,
      double c,
      BabyTask value,
      Paint paint,
      Paint paintLine,
      int index,
      double datePosition,
      int taskLength,
      double co) {
    if (value.taskName == 'sleeping' || value.taskName == 'walking') {
      // var startTime = DateTime.parse(value.startTime);
      // var endTime = DateTime.parse(value.endTime);
      // var finalStartTime =
      //     (0.02 * startTime.hour) + (0.02 * (startTime.hour - 1));
      // var finalEndTime = (0.02 * endTime.hour) + (0.02 * (endTime.hour - 1));
      // drawLineTimeLine(canvas, size, paintLine, index, c, finalStartTime,
      //     finalEndTime, datePosition);
      drawLineTime(canvas, size, paintLine, datePosition, c, i, value, co);
    } else {
      switch (taskLength) {
        case 1:
          {
            canvas.drawCircle(
                new Offset(
                    size.width * 1 / (datePosition + 0.047), size.height * c),
                size.width * 1 / 50,
                paint);
          }
          break;
        case 2:
          {
            canvas.drawCircle(
                new Offset(
                    size.width * 1 / ((datePosition + 0.047) - (index / 10)),
                    size.height * c),
                size.width * 1 / 50,
                paint);
          }
          break;
        case 3:
          {
            canvas.drawCircle(
                new Offset(
                    size.width * 1 / ((datePosition + 0.047) - (index / 13)),
                    size.height * c),
                size.width * 1 / 50,
                paint);
          }
          break;
        case 4:
          {
            canvas.drawCircle(
                new Offset(
                    size.width * 1 / ((datePosition + 0.047) - (index / 26)),
                    size.height * c),
                size.width * 1 / 50,
                paint);
          }
          break;

        default:
          {
            canvas.drawCircle(
                new Offset(
                    size.width * 1 / ((datePosition + 0.047) - (index / 26)),
                    size.height * c),
                size.width * 1 / 50,
                paint);
          }
          break;
      }
    }
  }

  // void drawLineTimeLine(Canvas canvas, Size size, Paint paintLine, int index,
  //     double c, double start, double end, double datePosition) {
  //   var p1 = Offset(size.width * 1 / ((datePosition + 0.047) - (index / 100)),
  //       start * size.height);
  //   var p2 = Offset(size.width * 1 / ((datePosition + 0.047) - (index / 100)),
  //       end * size.height);
  //   canvas.drawLine(p1, p2, paintLine);
  // }

  void drawLineTime(Canvas canvas, Size size, Paint paintLine, double index,
      double c, int i, BabyTask babyTask, double co) {
    var startTimeTask = DateTime.parse(babyTask.startTime);
    var endTimeTask = DateTime.parse(babyTask.endTime);
    canvas.drawLine(
        Offset(
            size.width * 1 / (index + 0.5 - co),
            size.height *
                (((startTimeTask.hour * c) / i) +
                    ((startTimeTask.minute * 0.04) / 60))),
        Offset(
            size.width * 1 / (index + 0.5 - co),
            size.height *
                (((endTimeTask.hour * c) / i) +
                    ((endTimeTask.minute * 0.04) / 60))),
        paintLine);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
