import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:momnotebook/constants/sizeConfig.dart';

class BoxIcon extends StatelessWidget {
  final String svgSrc;
  final String? text;
  final int numOfitem;
  final GestureTapCallback press;
  const BoxIcon({
    Key? key,
    required this.svgSrc,
    required this.numOfitem,
    required this.press,
    this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
      child: Stack(
        clipBehavior: Clip.antiAlias,
        children: [
          Container(
            padding: EdgeInsets.all(SizeConfig.heightMultiplier * 1.5),
            height: SizeConfig.heightMultiplier * 6,
            width: SizeConfig.widthMultiplier * 10,
            decoration: BoxDecoration(
              // color: kSecondaryColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: SvgPicture.asset(
              svgSrc,
            ),
          ),
          numOfitem == 0
              ? Container()
              : Positioned(
                  top: -1,
                  right: 0,
                  child: Container(
                    height: SizeConfig.heightMultiplier * 3,
                    width: SizeConfig.widthMultiplier * 5,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFF4848),
                      shape: BoxShape.circle,
                      border: Border.all(width: 1.5, color: Colors.white),
                    ),
                    child: Center(
                      child: Text(numOfitem.toString(),
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontFamily: 'Montserrat',
                              color: Colors.white,
                              fontSize: SizeConfig.textMultiplier * 1.2)),
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
