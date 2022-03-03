import 'package:flutter/material.dart';
import 'package:momnotebook/models/babyTask.dart';

class TimelinePainter extends CustomPainter {
  final List<BabyTask> babyTask;

  TimelinePainter(this.babyTask);
  @override
  void paint(Canvas canvas, Size size) {
    drwaLines(canvas, size / 3);
    // drwaTasks(canvas, size / 3, getValues);
  }

  void drwaLines(Canvas canvas, Size size) {
    var i = 1;
    var c = 1.8;
    final paint = Paint()
      ..color = Colors.black26
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 0.9;

    while (i <= 23) {
      var getValues = babyTask
          .where((element) => DateTime.parse(element.timeStamp).hour == i)
          .toList();
      canvas.drawLine(
        Offset(i * (size.width * 1 / 6), size.height * 1 / 2),
        Offset(i * (size.width * 1 / 6), size.height * 5 / 2),
        paint,
      );
      drawText(canvas, size, i);
      getValues.asMap().forEach((index, element) {
        final paint = Paint()
          ..color = Color(int.parse(element.color))
          ..strokeWidth = 4.0
          ..style = PaintingStyle.fill;
        final paintLine = Paint()
          ..color = Color(int.parse(element.color))
          ..strokeWidth = 10.0
          ..style = PaintingStyle.fill;
        final paintLineDottedLine = Paint()
          ..color = Color(int.parse(element.color)).withOpacity(0.45)
          ..strokeWidth = 10.0
          ..style = PaintingStyle.fill;
        final paintLineDottedLine1 = Paint()
          ..color = Color(int.parse(element.color)).withOpacity(0.25)
          ..strokeWidth = 10.0
          ..style = PaintingStyle.fill;
        if (element.taskName == 'sleeping' || element.taskName == 'walking') {
          var startTime = DateTime.parse(element.startTime);
          var endTime = DateTime.parse(element.endTime);
          if (startTime.day != DateTime.now().day ||
              startTime.month != DateTime.now().month ||
              startTime.year != DateTime.now().year) {
            canvas.drawLine(
                Offset(0, size.height * c / 2),
                Offset(
                    (endTime.hour + (endTime.minute / 60)) *
                        (size.width * 1 / 6),
                    size.height * c / 2),
                paintLineDottedLine);

            canvas.drawCircle(
                new Offset(
                    (endTime.hour + (endTime.minute / 60)) *
                        (size.width * 1 / 6),
                    size.height * c / 2),
                size.width * 1 / 18,
                paintLineDottedLine1);
          } else {
            canvas.drawLine(
                Offset(
                    (startTime.hour + (startTime.minute / 60)) *
                        (size.width * 1 / 6),
                    size.height * c / 2),
                Offset(
                    (endTime.hour + (endTime.minute / 60)) *
                        (size.width * 1 / 6),
                    size.height * c / 2),
                paintLine);
            canvas.drawCircle(
                new Offset(
                    (endTime.hour + (endTime.minute / 60)) *
                        (size.width * 1 / 6),
                    size.height * c / 2),
                size.width * 1 / 18,
                paintLine);
          }
          // if (startTime.hour == endTime.hour) {
          //   canvas.drawLine(
          //       Offset(
          //           (startTime.hour + (startTime.minute / 60)) *
          //               (size.width * 1 / 6),
          //           size.height * c / 2),
          //       Offset(
          //           (endTime.hour + (endTime.minute / 60)) *
          //               (size.width * 1 / 6),
          //           size.height * c / 2),
          //       paintLine);
          // } else {
          //   canvas.drawLine(
          //       Offset(
          //           (startTime.hour + (startTime.minute / 60)) *
          //               (size.width * 1 / 6),
          //           size.height * c / 2),
          //       Offset(
          //           (endTime.hour + (endTime.minute / 60)) *
          //               (size.width * 1 / 6),
          //           size.height * c / 2),
          //       paintLine);
          // }
          c = c + 0.6;
        } else {
          var circleElement = DateTime.parse(element.timeStamp);
          // canvas.drawCircle(
          //     new Offset(i * (size.width * 1 / 6),
          //         size.height * (2.4 + (index - 0.3)) / 3),
          //     size.width * 1 / 10,
          //     paint);
          canvas.drawCircle(
              new Offset(
                  (circleElement.hour + (circleElement.minute / 60)) *
                      (size.width * 1 / 6),
                  size.height * (2.4 + (index - 0.3)) / 3),
              size.width * 1 / 15,
              paint);
        }
      });

      i++;
    }
  }

  void drawText(Canvas canvas, Size size, int i) {
    TextSpan span = new TextSpan(
        style: new TextStyle(color: Colors.blue[800]),
        text: i % 2 != 0 ? '' : i.toString());
    TextPainter tp = new TextPainter(
        text: span,
        textAlign: TextAlign.left,
        textDirection: TextDirection.ltr);
    tp.layout();
    tp.paint(
        canvas, new Offset(i * (size.width * 1 / 6), size.height * 5.2 / 2));
  }

  void drwaTasks(Canvas canvas, Size size, List<BabyTask> babyTasks) {
    // for (var i = 0; i < babyTask.length; i++) {

    // }
    final paint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.fill;
    canvas.drawCircle(
        new Offset(1 * (size.width * 1 / 6), size.height * 2.1 / 2),
        size.width * 1 / 10,
        paint);
    canvas.drawCircle(
        new Offset(2 * (size.width * 1 / 6), size.height * 2.1 / 2),
        size.width * 1 / 10,
        paint);
    canvas.drawCircle(
        new Offset(20 * (size.width * 1 / 6), size.height * 2.1 / 2),
        size.width * 1 / 10,
        paint);
    // for (int i = 0; i > babyTasks.length; i++) {
    //   final paint = Paint()
    //     ..color = Colors.red
    //     ..style = PaintingStyle.fill;
    //   canvas.drawCircle(
    //       new Offset(1 * (size.width * 1 / 6), size.height * 5 / 2),
    //       size.width * 1 / 3,
    //       paint);
    // }
  }

  // void drawImage(Canvas canvas, Size size, int i) {
  //   if (i % 5 == 0) {
  //     // paintImage(img, rect, canvas, Paint(), BoxFit.cover);
  //     canvas.drawImage(
  //         img,
  //         new Offset(i * (size.width * 1.05 / 6), size.height * 1 / 2),
  //         Paint());
  //   }
  // }

  // void paintImage(
  //     ui.Image image, Rect outputRect, Canvas canvas, Paint paint, BoxFit fit) {
  //   final Size imageSize =
  //       Size(image.width.toDouble(), image.height.toDouble());
  //   final FittedSizes sizes = applyBoxFit(fit, imageSize, outputRect.size);
  //   final Rect inputSubrect =
  //       Alignment.center.inscribe(sizes.source, Offset.zero & imageSize);
  //   final Rect outputSubrect =
  //       Alignment.center.inscribe(sizes.destination, outputRect);
  //   // canvas.drawImage(image, i * (size.width * 1 / 6), outputSubrect, paint);
  // }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
