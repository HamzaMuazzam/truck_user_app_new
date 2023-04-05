import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sultan_cab/utils/colors.dart';
import 'package:sultan_cab/utils/sizeConfig.dart';

class AddressCard extends StatelessWidget {
  const AddressCard({
    Key? key,
    required this.b,
    required this.h,
    required this.pickUp,
    required this.destination,
  }) : super(key: key);

  final double b;
  final double h;
  final String pickUp;
  final String destination;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.screenWidth,
      padding: EdgeInsets.fromLTRB(b * 17, h * 20, b * 17, h * 20),
      decoration: allBoxDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SvgPicture.asset(
                'assets/icons/blue_cirle.svg',
                width: b * 17,
              ),
              sw(19),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      pickUp,
                      style: TextStyle(
                        fontSize: b * 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Transform.translate(
            offset: Offset(-b * 3, 0),
            child: Icon(
              Icons.more_vert,
              color: Color(0xff999999),
            ),
          ),
          sh(5),
          Row(
            children: [
              SvgPicture.asset(
                'assets/icons/choose_city.svg',
                color: Color(0xffD40511),
                height: h * 20,
              ),
              sw(19),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      destination,
                      style: TextStyle(
                        fontSize: b * 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
