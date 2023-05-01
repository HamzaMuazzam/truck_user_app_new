import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sultan_cab/providers/Reoccurring/reoccurring.dart';
import 'package:sultan_cab/utils/const.dart';
import 'package:sultan_cab/widgets/app_button.dart';
import 'package:sultan_cab/widgets/app_text_field.dart';
import 'package:sultan_cab/widgets/multi_selection_chip.dart';

import '../../../utils/commons.dart';
import '../start_booking.dart';

class ReoccurringRide extends StatefulWidget {
  const ReoccurringRide({Key? key}) : super(key: key);

  @override
  State<ReoccurringRide> createState() => _ReoccurringRideState();
}

class _ReoccurringRideState extends State<ReoccurringRide> {
  final TextEditingController timeCtrl = TextEditingController();
  final TextEditingController fairCtrl = TextEditingController();
  List<dynamic>? days;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Reoccurring Ride",
          style: TextStyle(fontSize: 18),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 5,
                      spreadRadius: 1,
                      color: Colors.grey.withOpacity(.3),
                    )
                  ],
                  borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Please Choose Schedule.",
                      style:
                          TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    SizedBox(height: 10),
                    MultiSelectChip(
                      initChoices: [],
                      onSelectionChanged: (List<dynamic> value) {
                        days = value;
                        logger.i(days);
                        // setState(() {});
                      },
                      chipsDataList: daysList,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 5,
                      spreadRadius: 1,
                      color: Colors.grey.withOpacity(.3),
                    )
                  ],
                  borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Please Choose Pickup Time.",
                      style:
                          TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.top),
                      child: AppTextField(
                        controller: timeCtrl,
                        label: 'Time',
                        suffix: Icon(Icons.calendar_month_rounded),
                        isVisibilty: true,
                        readOnly: true,
                        onTap: () async {
                          TimeOfDay? time = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                            initialEntryMode: TimePickerEntryMode.input,
                            builder: (context, child) {
                              return Theme(
                                data: ThemeData.light().copyWith(
                                  colorScheme: ColorScheme.light(
                                    primary: Colors.green,
                                    onSurface: Colors.green,
                                  ),
                                  buttonTheme: ButtonThemeData(
                                    colorScheme: ColorScheme.light(
                                      primary: Colors.green,
                                    ),
                                  ),
                                ),
                                child: child ?? SizedBox(),
                              );
                            },
                          );
                          if (time != null) timeCtrl.text = "${time.hour}:${time.minute}:00";
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(child: SizedBox()),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: AppButton(
                label: "Next",
                onPressed: () {
                  if (days == null) {
                    AppConst.infoSnackBar("choose Days");

                    return;
                  }
                  if (timeCtrl.text.isEmpty) {
                    AppConst.infoSnackBar("choose Time");

                    return;
                  }

                  Provider.of<ReoccurringProvider>(context, listen: false).setReoccurringValue(
                    days: days!,
                    time: timeCtrl.text,
                  );
                  logger.i(ReoccurringSchedule);
                  Get.to(() => StartBooking());
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<String> daysList = <String>[
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
    "Sunday",
  ];
}
