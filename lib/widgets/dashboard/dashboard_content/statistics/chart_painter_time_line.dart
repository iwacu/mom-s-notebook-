import 'package:flutter/material.dart';
import 'package:momnotebook/constants/colors.dart';
import 'package:momnotebook/models/babyTask.dart';

class ChartPainterTimeLine extends CustomPainter {
  final DateTime startTime, endTime, selectedTime;
  final List<BabyTask> babyTask;

  ChartPainterTimeLine(
      this.startTime, this.endTime, this.babyTask, this.selectedTime);
  @override
  void paint(Canvas canvas, Size size) {
    drawWhiteRectangular(size, canvas);
  }

  // draw white rectangular
  void drawWhiteRectangular(Size size, Canvas canvas) {
    // paint_for_rectangular
    final paint = Paint()
      ..color = primaryColor
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 1;
    // rectangular point_corrdinates
    final a = Offset(size.width * 0.0, 0.0);
    final b = Offset(size.width * 1, size.height);
    final rect = Rect.fromPoints(a, b);
    // draw rectangle
    canvas.drawRect(rect, paint);

    // grey fixed rectanlges
    drwaFixedShadowRectangle(canvas, size);
    // shadow blue rectangle
    drawShadowRectangle(canvas, size);

    // draw horizontal lines
    drawHorizontalLines(canvas, size);
  }

  // draw blue rectangle
  void drawShadowRectangle(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = buttonBGColor.withOpacity(0.25)
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 1;

    switch (selectedTime.weekday) {
      case 1:
        {
          final a = Offset(size.width * 1 / 16, size.height * 0.0);
          final b = Offset(size.width * 1 / 5, size.height);
          final rect = Rect.fromPoints(a, b);
          canvas.drawRect(rect, paint);
        }

        break;
      case 2:
        {
          final a = Offset(size.width * 1 / 5, size.height * 0.0);
          final b = Offset(size.width * 7 / 20.7, size.height);
          final rect = Rect.fromPoints(a, b);
          canvas.drawRect(rect, paint);
        }
        break;
      case 3:
        {
          final a = Offset(size.width * 7 / 20.7, size.height * 0.0);
          final b = Offset(size.width * 31 / 65, size.height);
          final rect = Rect.fromPoints(a, b);
          canvas.drawRect(rect, paint);
        }
        break;
      case 4:
        {
          final a = Offset(size.width * 31 / 65, size.height * 0.0);
          final b = Offset(size.width * 1 / 1.63, size.height);
          final rect = Rect.fromPoints(a, b);
          canvas.drawRect(rect, paint);
        }
        break;
      case 5:
        {
          final a = Offset(size.width * 1 / 1.63, size.height * 0.0);
          final b = Offset(size.width * 1 / 1.34, size.height);
          final rect = Rect.fromPoints(a, b);
          canvas.drawRect(rect, paint);
        }
        break;
      case 6:
        {
          final a = Offset(size.width * 1 / 1.34, size.height * 0.0);
          final b = Offset(size.width * 1 / 1.136, size.height);
          final rect = Rect.fromPoints(a, b);
          canvas.drawRect(rect, paint);
        }
        break;
      case 7:
        {
          final a = Offset(size.width * 1 / 1.136, size.height * 0.0);
          final b = Offset(size.width * 1, size.height);
          final rect = Rect.fromPoints(a, b);
          canvas.drawRect(rect, paint);
        }
        break;
      default:
    }
  }

  // draw grey fixed rectangles
  void drwaFixedShadowRectangle(Canvas canvas, Size size) {
    var i = 1;
    var xStart = 1 / 16;
    var xxStart = 1 / 5;
    // line paint for odd numbers
    final paint = Paint()
      ..color = greyColor.withOpacity(0.45)
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 1;
    // line paint for even numbers
    final paintEven = Paint()
      ..color = primaryColor
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 1;
    while (i <= 7) {
      final a = Offset(size.width * xStart, size.height * 0.0);
      final b = Offset(size.width * xxStart, size.height);
      final rect = Rect.fromPoints(a, b);
      canvas.drawRect(rect, i % 2 == 0 ? paintEven : paint);
      xStart = xxStart;
      xxStart = xStart + (15 / 110);
      i++;
    }
  }

  // draw vertical numbers
  void drawHorizontalLines(Canvas canvas, Size size) {
    var i = 1;
    var c = 0.02;

    // paint line
    final paintLine = Paint()
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
        paintLine,
      );
      // draw tasks
      drawTasks(canvas, size, i, c, getTimeValues);
      // draw vertical numbers
      drawText(canvas, size, i, c);
      c = c + 0.04;
      i++;
    }
  }

  // draw vertical numbers
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

  // draw tasks
  void drawTasks(
      Canvas canvas, Size size, int i, double c, List<BabyTask> tasks) {
    // corrdinates
    var mondaP = 16.0;
    var tueP = 3.5;
    var wend = 2.5;
    var thuP = 1.85;
    var fridP = 1.48;
    var satP = 1.24;
    var suP = 1.08;
    var co = 0.1;
    // loop in tasks
    tasks.asMap().forEach((index, value) {
      final paint = Paint()
        ..color = Color(int.parse(value.color))
        ..strokeWidth = 4.0
        ..style = PaintingStyle.fill;
      final paintLine = Paint()
        ..color = Color(int.parse(value.color))
        ..strokeWidth = 10.0
        ..strokeCap = StrokeCap.round
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

  void drawLineTimeN(
      {Canvas? canvas,
      Size? size,
      Paint? paintLine,
      double? c,
      int? i,
      BabyTask? babyTask,
      double? co,
      double? upI,
      double? downI}) {
    var startTimeTask = DateTime.parse(babyTask!.startTime);
    var endTimeTask = DateTime.parse(babyTask.endTime);
    canvas!.drawLine(
        Offset(
            size!.width * upI! / (downI! + 0.5 - co!),
            size.height *
                (((startTimeTask.hour * c!) / i!) +
                    ((startTimeTask.minute * 0.04) / 60))),
        Offset(
            size.width * upI / (downI + 0.5 - co),
            size.height *
                (((endTimeTask.hour * c) / i) +
                    ((endTimeTask.minute * 0.04) / 60))),
        paintLine!);
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
    var startTimeTask = DateTime.parse(value.timeStamp);

    final paintLineDottedLine = Paint()
      ..color = Color(int.parse(value.color)).withOpacity(0.45)
      ..strokeWidth = 10.0
      ..style = PaintingStyle.fill;
    if (value.taskName == 'sleeping' || value.taskName == 'walking') {
      if (DateTime.parse(value.startTime).weekday !=
          DateTime.parse(value.endTime).weekday) {
        canvas.drawLine(
            Offset(size.width * 1 / (7 + 0.5 - co), size.height * 0),
            Offset(
                size.width * 1 / (7 + 0.5 - co),
                size.height *
                    (((DateTime.parse(value.endTime).hour * c) / i) +
                        ((DateTime.parse(value.endTime).minute * 0.04) / 60))),
            paintLineDottedLine);
      } else {
        drawLineTimeN(
            canvas: canvas,
            size: size,
            paintLine: paintLine,
            c: c,
            i: i,
            babyTask: value,
            co: co,
            upI: 1,
            downI: 7);
      }
    } else {
      canvas.drawCircle(
          new Offset(
              size.width * 1 / 9,
              size.height *
                  (((startTimeTask.hour * c) / i) +
                      ((startTimeTask.minute * 0.04) / 60))),
          size.width * 1 / 65,
          paint);
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
    var startTimeTask = DateTime.parse(value.timeStamp);
    final paintLineDottedLine = Paint()
      ..color = Color(int.parse(value.color)).withOpacity(0.45)
      ..strokeWidth = 10.0
      ..style = PaintingStyle.fill;
    if (value.taskName == 'sleeping' || value.taskName == 'walking') {
      if (DateTime.parse(value.startTime).weekday !=
          DateTime.parse(value.endTime).weekday) {
        canvas.drawLine(
            Offset(size.width * 1 / (3 + 0.5 - co), size.height * 0),
            Offset(
                size.width * 1 / (3 + 0.5 - co),
                size.height *
                    (((DateTime.parse(value.endTime).hour * c) / i) +
                        ((DateTime.parse(value.endTime).minute * 0.04) / 60))),
            paintLineDottedLine);
      } else {
        drawLineTimeN(
            canvas: canvas,
            size: size,
            paintLine: paintLine,
            c: c,
            i: i,
            babyTask: value,
            co: co,
            upI: 1,
            downI: 3);
      }
    } else {
      canvas.drawCircle(
          new Offset(
              size.width * 1 / 4,
              size.height *
                  (((startTimeTask.hour * c) / i) +
                      ((startTimeTask.minute * 0.04) / 60))),
          size.width * 1 / 65,
          paint);
    }
  }

  void drawCirleAndLine3(
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
    var startTimeTask = DateTime.parse(value.timeStamp);
    if (value.taskName == 'sleeping' || value.taskName == 'walking') {
      final paintLineDottedLine = Paint()
        ..color = Color(int.parse(value.color)).withOpacity(0.45)
        ..strokeWidth = 10.0
        ..style = PaintingStyle.fill;
      if (DateTime.parse(value.startTime).weekday !=
          DateTime.parse(value.endTime).weekday) {
        canvas.drawLine(
            Offset(size.width * 7 / (16 + 0.5 - co), size.height * 0),
            Offset(
                size.width * 7 / (16 + 0.5 - co),
                size.height *
                    (((DateTime.parse(value.endTime).hour * c) / i) +
                        ((DateTime.parse(value.endTime).minute * 0.04) / 60))),
            paintLineDottedLine);
      } else {
        drawLineTimeN(
            canvas: canvas,
            size: size,
            paintLine: paintLine,
            c: c,
            i: i,
            babyTask: value,
            co: co,
            upI: 7,
            downI: 16);
      }
    } else {
      canvas.drawCircle(
          new Offset(
              size.width * 7 / 18,
              size.height *
                  (((startTimeTask.hour * c) / i) +
                      ((startTimeTask.minute * 0.04) / 60))),
          size.width * 1 / 65,
          paint);
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
    var startTimeTask = DateTime.parse(value.timeStamp);
    if (value.taskName == 'sleeping' || value.taskName == 'walking') {
      final paintLineDottedLine = Paint()
        ..color = Color(int.parse(value.color)).withOpacity(0.45)
        ..strokeWidth = 10.0
        ..style = PaintingStyle.fill;
      if (DateTime.parse(value.startTime).weekday !=
          DateTime.parse(value.endTime).weekday) {
        canvas.drawLine(
            Offset(size.width * 31 / (55 + 0.5 - co), size.height * 0),
            Offset(
                size.width * 31 / (55 + 0.5 - co),
                size.height *
                    (((DateTime.parse(value.endTime).hour * c) / i) +
                        ((DateTime.parse(value.endTime).minute * 0.04) / 60))),
            paintLineDottedLine);
      } else {
        drawLineTimeN(
            canvas: canvas,
            size: size,
            paintLine: paintLine,
            c: c,
            i: i,
            babyTask: value,
            co: co,
            upI: 31,
            downI: 55);
      }
    } else {
      canvas.drawCircle(
          new Offset(
              size.width * 31 / 60,
              size.height *
                  (((startTimeTask.hour * c) / i) +
                      ((startTimeTask.minute * 0.04) / 60))),
          size.width * 1 / 65,
          paint);
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
    var startTimeTask = DateTime.parse(value.timeStamp);
    if (value.taskName == 'sleeping' || value.taskName == 'walking') {
      final paintLineDottedLine = Paint()
        ..color = Color(int.parse(value.color)).withOpacity(0.45)
        ..strokeWidth = 10.0
        ..style = PaintingStyle.fill;
      if (DateTime.parse(value.startTime).weekday !=
          DateTime.parse(value.endTime).weekday) {
        canvas.drawLine(
            Offset(size.width * 31 / (45 + 0.5 - co), size.height * 0),
            Offset(
                size.width * 31 / (45 + 0.5 - co),
                size.height *
                    (((DateTime.parse(value.endTime).hour * c) / i) +
                        ((DateTime.parse(value.endTime).minute * 0.04) / 60))),
            paintLineDottedLine);
      } else {
        drawLineTimeN(
            canvas: canvas,
            size: size,
            paintLine: paintLine,
            c: c,
            i: i,
            babyTask: value,
            co: co,
            upI: 31,
            downI: 45);
      }
    } else {
      canvas.drawCircle(
          new Offset(
              size.width * 1 / (1.5),
              size.height *
                  (((startTimeTask.hour * c) / i) +
                      ((startTimeTask.minute * 0.04) / 60))),
          size.width * 1 / 65,
          paint);
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
    var startTimeTask = DateTime.parse(value.timeStamp);
    if (value.taskName == 'sleeping' || value.taskName == 'walking') {
      final paintLineDottedLine = Paint()
        ..color = Color(int.parse(value.color)).withOpacity(0.45)
        ..strokeWidth = 10.0
        ..style = PaintingStyle.fill;
      if (DateTime.parse(value.startTime).weekday !=
          DateTime.parse(value.endTime).weekday) {
        canvas.drawLine(
            Offset(size.width * 31 / (37 + 0.5 - co), size.height * 0),
            Offset(
                size.width * 31 / (37 + 0.5 - co),
                size.height *
                    (((DateTime.parse(value.endTime).hour * c) / i) +
                        ((DateTime.parse(value.endTime).minute * 0.04) / 60))),
            paintLineDottedLine);
      } else {
        drawLineTimeN(
            canvas: canvas,
            size: size,
            paintLine: paintLine,
            c: c,
            i: i,
            babyTask: value,
            co: co,
            upI: 31,
            downI: 37);
      }
    } else {
      canvas.drawCircle(
          new Offset(
              size.width * 1 / (1.26),
              size.height *
                  (((startTimeTask.hour * c) / i) +
                      ((startTimeTask.minute * 0.04) / 60))),
          size.width * 1 / 65,
          paint);
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
    var startTimeTask = DateTime.parse(value.timeStamp);
    if (value.taskName == 'sleeping' || value.taskName == 'walking') {
      final paintLineDottedLine = Paint()
        ..color = Color(int.parse(value.color)).withOpacity(0.45)
        ..strokeWidth = 10.0
        ..style = PaintingStyle.fill;
      if (DateTime.parse(value.startTime).weekday !=
          DateTime.parse(value.endTime).weekday) {
        canvas.drawLine(
            Offset(size.width * 31 / (33 + 0.5 - co), size.height * 0),
            Offset(
                size.width * 31 / (33 + 0.5 - co),
                size.height *
                    (((DateTime.parse(value.endTime).hour * c) / i) +
                        ((DateTime.parse(value.endTime).minute * 0.04) / 60))),
            paintLineDottedLine);
      } else {
        drawLineTimeN(
            canvas: canvas,
            size: size,
            paintLine: paintLine,
            c: c,
            i: i,
            babyTask: value,
            co: co,
            upI: 31,
            downI: 33);
      }
    } else {
      canvas.drawCircle(
          new Offset(
              size.width * 1 / (1.08),
              size.height *
                  (((startTimeTask.hour * c) / i) +
                      ((startTimeTask.minute * 0.04) / 60))),
          size.width * 1 / 65,
          paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
