import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:sultan_cab/providers/TaxiBookingProvider/truck_booking_provider.dart';
import 'package:sultan_cab/utils/sizeConfig.dart';
import 'package:sultan_cab/widgets/app_button.dart';

class DialogBoxRating extends StatefulWidget {
  final VoidCallback? submitRating;

  const DialogBoxRating({this.submitRating, Key? key}) : super(key: key);

  @override
  State<DialogBoxRating> createState() => _DialogBoxRatingState();
}

class _DialogBoxRatingState extends State<DialogBoxRating> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var b = SizeConfig.screenWidth / 375;
    var h = SizeConfig.screenHeight / 812;
    return Consumer(builder: (builder, data, child) {
      return Dialog(
        insetPadding: EdgeInsets.symmetric(horizontal: b * 15),
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(b * 4),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(b * 30, h * 30, b * 30, h * 30),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(
                  "Rate Rider",
                  style: TextStyle(
                    fontSize: b * 24,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.5,
                  ),
                ),
                sh(15),
                RatingBar.builder(
                  initialRating: 3,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    taxiBookingProvider.setRating(rating);
                  },
                ),
                sh(34),
                AppButton(
                  label: "Add Rating",
                  onPressed: widget.submitRating,
                )
              ]),
            ),
          ],
        ),
      );
    });
  }
}
