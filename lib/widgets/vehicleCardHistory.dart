// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:intl/intl.dart';
// import 'package:thrifty_cab/models/booking_history_model.dart';
// import 'package:thrifty_cab/screens/staticPages/ratingsReview.dart';
// import 'package:thrifty_cab/screens/staticPages/report.dart';
// import 'package:thrifty_cab/utils/colors.dart';
// import 'package:thrifty_cab/utils/sizeConfig.dart';
// import 'package:thrifty_cab/utils/strings.dart';
// import 'package:thrifty_cab/widgets/app_snackBar.dart';
// import 'package:thrifty_cab/widgets/cachedImage.dart';
// // import 'package:easy_localization/easy_localization.dart';
//
// class VehicleCardHistory extends StatelessWidget {
//   VehicleCardHistory(this.booking, {Key? key}) : super(key: key);
//
//   final BookingHistoryModel booking;
//
//   final List<String> menuLabel = [
//     CancelLabel,
//     UpdateLabel,
//     RatingLabel,
//     ReportLabel,
//     ReportHisLabel,
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     SizeConfig().init(context);
//     var h = SizeConfig.screenHeight / 812;
//     var b = SizeConfig.screenWidth / 375;
//
//     final String startDate =
//         DateFormat('EEE, d MMM, yy').format(DateTime.parse(booking.pickupDate!));
//     final String endDate = DateFormat('EEE, d MMM, yy').format(DateTime.parse(booking.returnDate!));
//
//     final startTime = TimeOfDay.fromDateTime(DateTime.parse(booking.pickupDate!));
//     final endTime = TimeOfDay.fromDateTime(DateTime.parse(booking.returnDate!));
//     if (booking.rideStatus! == CompletedLabel || booking.rideStatus! == OnGoingLabel) {
//       menuLabel.remove(UpdateLabel);
//       menuLabel.remove(CancelLabel);
//     }
//     if (booking.rideStatus! == CancelledLabel) {
//       menuLabel.remove(CancelLabel);
//       menuLabel.remove(UpdateLabel);
//     }
//
//     return Container(
//       margin: EdgeInsets.only(right: b * 15, bottom: h * 10, left: b * 15),
//       padding: EdgeInsets.fromLTRB(b * 5, h * 0, b * 15, h * 13),
//       decoration: BoxDecoration(
//         boxShadow: boxShadow2,
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(4),
//       ),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               Container(
//                 margin: EdgeInsets.only(left: b * 11),
//                 padding: EdgeInsets.symmetric(horizontal: b * 30, vertical: h * 7),
//                 decoration: BoxDecoration(
//                   // color: tagColor(booking.rideStatus!),
//                   borderRadius: BorderRadius.only(
//                     bottomLeft: Radius.circular(5),
//                     bottomRight: Radius.circular(5),
//                   ),
//                 ),
//                 child: Text(
//                   booking.rideStatus!,
//                   style: TextStyle(
//                     color: booking.rideStatus! == PendingLabel ? Colors.black : Colors.white,
//                     fontSize: b * 14,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//               ),
//               Spacer(),
//               Padding(
//                 padding: EdgeInsets.only(top: h * 10),
//                 child: PopupMenuButton<String>(
//                   padding: EdgeInsets.only(left: b * 14, right: b * 4),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(b * 4),
//                   ),
//                   onSelected: (value) {
//                     if (value == RatingLabel) {
//                       Navigator.of(context).push(
//                         MaterialPageRoute(
//                           builder: (context) => RatingsReview(
//                             bookingId: booking.bookingId.toString(),
//                           ),
//                         ),
//                       );
//                     } else if (value == ReportLabel) {
//                       Navigator.of(context).push(
//                         MaterialPageRoute(
//                           builder: (context) => ReportScreen(
//                             bookingId: booking.bookingId!,
//                           ),
//                         ),
//                       );
//                     } else if (value == UpdateLabel) {
//                       /* Navigator.of(context).push(
//                         MaterialPageRoute(
//                           builder: (context) => BookCar(
//                             vehicle: booking.vehicleDetails,
//                             isUpdate: true,
//                             booking: booking,
//                             limited: booking.billingType == 'Limited' ? true : false,
//                           ),
//                         ),
//                       );*/
//                     } else if (value == CancelLabel) {
//                       // dialogBoxCancel(context, booking, false);
//                     } else if (value == ReportHisLabel) {
//                       // Navigator.of(context).push(MaterialPageRoute(
//                       //   builder: (context) => ReportDetail(
//                       //     bookingID: booking.bookingId!,
//                       //   ),
//                       // )
//                       // );
//                     }
//                   },
//                   itemBuilder: (BuildContext context) {
//                     return menuLabel.map((String choice) {
//                       return PopupMenuItem<String>(
//                         height: h * 30,
//                         value: choice,
//                         child: Row(
//                           children: [
//                             SvgPicture.asset(
//                               label(choice),
//                               width: b * 17,
//                               color: Colors.black,
//                             ),
//                             sw(15),
//                             Text(
//                               choice,
//                               style: TextStyle(
//                                 fontSize: b * 14,
//                                 color: Colors.black.withOpacity(0.75),
//                               ),
//                             ),
//                           ],
//                         ),
//                       );
//                     }).toList();
//                   },
//                   child: Icon(
//                     Icons.more_vert,
//                     size: b * 20,
//                     color: Color(0xff999999),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           sh(17),
//           Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Padding(
//                 padding: EdgeInsets.only(top: h * 5, left: b * 10),
//                 child: CachedImage(
//                   isGallery: false,
//                   imgUrl: booking.vehicleDetails!.photo!,
//                   height: h * 95,
//                   width: b * 148,
//                   vehicleId: booking.vehicleDetails!.vehicleId.toString(),
//                 ),
//               ),
//               sw(10),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Row(
//                       children: [
//                         Expanded(
//                           child: Text(
//                             booking.vehicleDetails!.vehicleName ?? " ",
//                             overflow: TextOverflow.ellipsis,
//                             maxLines: 1,
//                             style: TextStyle(
//                               fontWeight: FontWeight.w500,
//                               fontSize: b * 14,
//                             ),
//                           ),
//                         ),
//                         InkWell(
//                           onTap: () {
//                             // dialogBoxDetail(context, booking.vehicleDetails!);
//                           },
//                           child: Icon(
//                             Icons.info_outline,
//                             color: secondaryColor,
//                             size: b * 16,
//                           ),
//                         ),
//                       ],
//                     ),
//                     sh(10),
//                     InkWell(
//                       onTap: () {
//                         Clipboard.setData(ClipboardData(
//                           text: booking.orderId.toString(),
//                         )).then((_) {
//                           appSnackBar(
//                             context: context,
//                             msg: ClipboardLabel,
//                             isError: false,
//                           );
//                         });
//                       },
//                       child: Row(
//                         children: [
//                           Text(
//                             OrderIdLabel + ":",
//                             style: TextStyle(
//                               fontSize: b * 11.5,
//                               color: Color(0xff3f3d56),
//                             ),
//                           ),
//                           Text(
//                             "  ${booking.orderId.toString()}".substring(0, 14),
//                             style: TextStyle(
//                               fontWeight: FontWeight.w500,
//                               fontSize: b * 10,
//                               color: Color(0xffa7a7a7),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     sh(10),
//                     Text(
//                       TotalAmountLabel,
//                       style: TextStyle(
//                         fontSize: b * 10,
//                         letterSpacing: 0.6,
//                         color: Colors.black.withOpacity(0.7),
//                         fontWeight: FontWeight.w700,
//                       ),
//                     ),
//                     sh(5),
//                     Text(
//                       booking.totalAmount!,
//                       style: TextStyle(
//                         fontSize: b * 18,
//                         letterSpacing: 0.6,
//                         color: secondaryColor,
//                         fontWeight: FontWeight.w700,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//           sh(19),
//           Container(
//             margin: EdgeInsets.only(left: b * 10),
//             padding: EdgeInsets.symmetric(horizontal: b * 22, vertical: h * 10),
//             decoration: BoxDecoration(
//               border: Border.all(
//                 color: Color(0xfff2f2f2),
//               ),
//               borderRadius: BorderRadius.circular(b * 4),
//             ),
//             child: Column(
//               children: [
//                 Row(
//                   children: [
//                     SvgPicture.asset(
//                       "assets/icons/calendar.svg",
//                       width: b * 10,
//                       color: Colors.black,
//                     ),
//                     sw(8),
//                     Text(
//                       startDate,
//                       style: TextStyle(fontSize: b * 12, letterSpacing: 0.6),
//                     ),
//                     Spacer(),
//                     Text(
//                       ToLabel,
//                       style: TextStyle(
//                         fontSize: b * 12,
//                         letterSpacing: 0.6,
//                         color: Colors.black.withOpacity(0.5),
//                       ),
//                     ),
//                     Spacer(),
//                     SvgPicture.asset(
//                       "assets/icons/calendar.svg",
//                       width: b * 10,
//                       color: Colors.black,
//                     ),
//                     sw(8),
//                     Text(
//                       endDate,
//                       style: TextStyle(fontSize: b * 12, letterSpacing: 0.6),
//                     ),
//                   ],
//                 ),
//                 sh(10),
//                 Row(
//                   children: [
//                     SvgPicture.asset(
//                       "assets/icons/clock.svg",
//                       width: b * 14,
//                       color: Colors.black,
//                     ),
//                     sw(8),
//                     Text(
//                       timeFormat(startTime),
//                       style: TextStyle(fontSize: b * 12, letterSpacing: 0.6),
//                     ),
//                     Spacer(),
//                     Text(
//                       ToLabel,
//                       style: TextStyle(
//                         fontSize: b * 12,
//                         letterSpacing: 0.6,
//                         color: Colors.black.withOpacity(0.5),
//                       ),
//                     ),
//                     Spacer(),
//                     SvgPicture.asset(
//                       "assets/icons/clock.svg",
//                       width: b * 14,
//                       color: Colors.black,
//                     ),
//                     sw(8),
//                     Text(
//                       timeFormat(endTime),
//                       style: TextStyle(fontSize: b * 12, letterSpacing: 0.6),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   String label(String title) {
//     if (title == ReportLabel)
//       return "assets/icons/report.svg";
//     else if (title == CancelLabel)
//       return "assets/icons/cancel.svg";
//     else if (title == UpdateLabel)
//       return "assets/icons/update.svg";
//     else if (title == ReportHisLabel)
//       return "assets/icons/report.svg";
//     else if (title == RatingLabel) return "assets/icons/rating.svg";
//     return '';
//   }
// }
