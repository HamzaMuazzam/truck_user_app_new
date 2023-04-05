import 'package:flutter/material.dart';
import 'package:sultan_cab/models/coupon_model.dart';
import 'package:sultan_cab/services/booking_services.dart';
import 'package:sultan_cab/utils/colors.dart';
import 'package:sultan_cab/utils/sizeConfig.dart';
import 'package:sultan_cab/utils/strings.dart';
import 'package:sultan_cab/widgets/app_snackBar.dart';
import 'package:sultan_cab/widgets/app_text_field.dart';

class PaymentMethod extends StatefulWidget {
  const PaymentMethod({Key? key}) : super(key: key);

  @override
  State<PaymentMethod> createState() => _PaymentMethodState();
}

class _PaymentMethodState extends State<PaymentMethod> {
  bool isCash = false;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var b = SizeConfig.screenWidth / 375;
    var h = SizeConfig.screenHeight / 812;

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(PaymentMethodLabel),
      sh(14),
      Row(
        children: [
          InkWell(
            onTap: () {
              isCash = !isCash;
              setState(() {});
            },
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(vertical: h * 10, horizontal: b * 20),
              decoration: BoxDecoration(
                color: isCash ? Colors.white : primaryColor,
                border: Border.all(
                  color: isCash ? borderColor : Colors.transparent,
                ),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                OnlineLabel,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: b * 12,
                  letterSpacing: 0.6,
                ),
              ),
            ),
          ),
          sw(8),
          InkWell(
            onTap: () {
              isCash = !isCash;
              setState(() {});
            },
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(vertical: h * 10, horizontal: b * 20),
              decoration: BoxDecoration(
                color: !isCash ? Colors.white : primaryColor,
                border: Border.all(
                  color: !isCash ? borderColor : Colors.transparent,
                ),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                CashLabel,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: b * 12,
                  letterSpacing: 0.6,
                ),
              ),
            ),
          )
        ],
      ),
    ]);
  }
}

class DiscountSection extends StatefulWidget {
  const DiscountSection({
    Key? key,
    required this.b,
    required this.promoController,
    required this.h,
  }) : super(key: key);

  final double b;
  final TextEditingController promoController;
  final double h;

  @override
  State<DiscountSection> createState() => _DiscountSectionState();
}

class _DiscountSectionState extends State<DiscountSection> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          PromoCodeLabel,
          style: TextStyle(
            color: Color(0xff3c3b3b),
            fontSize: widget.b * 14,
          ),
        ),
        sh(5),
        AppTextField(
          label: null,
          controller: widget.promoController,
          suffix: null,
          hint: PromoCodeHintLabel,
          isVisibilty: true,
        ),
        sh(22),
        Text(
          AvaialbleCouponLabel,
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: primaryColor,
            fontSize: widget.b * 14,
          ),
        ),
        sh(10),
        FutureBuilder(
            future: BookingServices.getCoupons(""),
            builder: (context, AsyncSnapshot<DiscountModel?> snap) {
              if (snap.hasData) {
                DiscountModel? _list = snap.data;
                return _list!.data!.length != 0
                    ? SizedBox(
                        height: widget.h * 120,
                        child: ListView.builder(
                            padding: EdgeInsets.only(left: widget.b * 0),
                            itemCount: _list.data!.length,
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) {
                              Data data1 = _list.data!.elementAt(index);

                              return InkWell(
                                onTap: () async {
                                  FocusScope.of(context).unfocus();
                                  try {
                                    setState(() {
                                      widget.promoController.text = data1.couponCode!;
                                    });

                                    appSnackBar(
                                      context: context,
                                      msg: CouponAppliedMsg,
                                      isError: false,
                                    );
                                  } catch (e) {
                                    appSnackBar(
                                      context: context,
                                      msg: e.toString(),
                                      isError: true,
                                    );
                                  }
                                },
                                child: Container(
                                  margin: EdgeInsets.only(right: widget.b * 20),
                                  width: SizeConfig.screenWidth * 0.75,
                                  padding: EdgeInsets.fromLTRB(
                                    widget.b * 15,
                                    widget.h * 14,
                                    widget.b * 15,
                                    widget.h * 14,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Color(0xfff6f6f6),
                                    borderRadius: BorderRadius.circular(
                                      4,
                                    ),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "$FlatLabel ${data1.discount} ${OFFLabel.toLowerCase()}",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: widget.b * 14,
                                              letterSpacing: 0.6,
                                              color: Color(
                                                0xff3c3b3b,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      sh(10),
                                      Text(
                                        "$GetLabel ${data1.discount} $OffUpto \u20b9${data1.maxValue} $OntheBooking",
                                        style: TextStyle(
                                          fontSize: widget.b * 12,
                                          letterSpacing: 0.6,
                                          color: Color(0xffa7a7a7),
                                        ),
                                      ),
                                      sh(11),
                                      Text(
                                        "$PromoCodeLabel: " + data1.couponCode!,
                                        style: TextStyle(
                                          fontSize: widget.b * 12,
                                          fontWeight: FontWeight.w700,
                                          letterSpacing: 0.6,
                                          color: Color(0xffd40511),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                      )
                    : sh(0);
              } else
                return sh(0);
            }),
      ],
    );
  }
}
