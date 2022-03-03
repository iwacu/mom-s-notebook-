import 'package:flutter/material.dart';
import 'package:momnotebook/constants/colors.dart';
import 'package:momnotebook/constants/sizeConfig.dart';

class SignUpContent extends StatelessWidget {
  const SignUpContent({
    Key? key,
    this.text,
    this.title,
    this.image,
    this.arr,
  }) : super(key: key);
  final String? text, title, image;
  final List? arr;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Image.asset(
          image!,
          height: SizeConfig.imageSizeMultiplier * 34,
          width: SizeConfig.imageSizeMultiplier * 34,
        ),
        // Spacer(flex: 2),
        Text(
          title!,
          textAlign: TextAlign.center,
          style:
              TextStyle(fontFamily: 'Montserrat', fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: SizeConfig.heightMultiplier * 2.5,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 94),
          child: TextFormField(
              decoration:
                  InputDecoration(border: InputBorder.none, labelText: text)),
        ),
        Padding(
          padding: EdgeInsets.only(left: SizeConfig.widthMultiplier * 26),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              arr!.length,
              (index) => buildList(arra: arr![index]),
            ),
          ),
        ),
      ],
    );
  }

  buildList({String? arra}) {
    return Row(
      children: [
        Container(
          height: SizeConfig.heightMultiplier * 2,
          width: SizeConfig.widthMultiplier * 2,
          decoration:
              BoxDecoration(color: buttonBGColor, shape: BoxShape.circle),
        ),
        SizedBox(
          width: SizeConfig.widthMultiplier * 2,
        ),
        Text(
          arra!,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Montserrat',
            color: Colors.black38,
          ),
        )
      ],
    );
  }
}
