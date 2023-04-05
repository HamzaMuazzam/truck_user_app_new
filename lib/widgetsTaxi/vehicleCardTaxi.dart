import 'package:flutter/material.dart';
import 'package:sultan_cab/models/taxi/allTaxi.dart';
import 'package:sultan_cab/utils/colors.dart';
import 'package:sultan_cab/utils/sizeConfig.dart';
import 'package:sultan_cab/utils/strings.dart';
import 'package:sultan_cab/widgets/vehicle_tags.dart';

class VehicleCard extends StatelessWidget {
  VehicleCard({Key? key, required this.selected, this.data, this.price}) : super(key: key);
  final bool selected;
  final Body? data;
  final String? price;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var h = SizeConfig.screenHeight / 812;
    var b = SizeConfig.screenWidth / 375;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: b * 16, vertical: h * 16),
      decoration: BoxDecoration(
          border: Border.all(
            color: selected ? primaryColor : Colors.transparent,
          ),
          color: Colors.white,
          borderRadius: BorderRadius.circular(4),
          boxShadow: [
            BoxShadow(
              color: Color(0xff000000).withOpacity(0.1),
              blurRadius: 4,
              spreadRadius: 1,
              offset: Offset(1, 4),
            )
          ]),
      margin: EdgeInsets.only(bottom: h * 13),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          data!.vehiclePhotos!.first.imageUrl != null
              ? Image.network(
                  data!.vehiclePhotos!.first.imageUrl!,
                  height: h * 40,
                  width: b * 59,
                )
              : Image.asset(
                  'assets/images/car_placeholder.png',
                  height: h * 40,
                  width: b * 59,
                ),
          sw(13),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data!.modelName ?? 'Sedan',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: b * 14,
                  ),
                ),
                sh(4),
                Wrap(
                  runSpacing: h * 5,
                  children: [
                    VehicleTags(
                      txt: (data!.seatingCapacity ?? 4).toString() + " ${SeaterLabel}",
                      size: b * 8,
                    ),
                    sw(6),
                    VehicleTags(
                      txt: data!.fuelType ?? 'Petrol',
                      size: b * 8,
                    ),
                    sw(6),
                    VehicleTags(
                      txt: data!.transmissionType ?? ManualLabel,
                      size: b * 8,
                    ),
                    sw(6),
                    VehicleTags(
                      txt: "Air Bags",
                      size: b * 8,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Text(
            '\u20b9 ' + (price ?? '356'),
            style: TextStyle(
              fontSize: b * 18,
              color: secondaryColor,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
