// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:thrifty_cab/models/taxi/localTaxiFare.dart';
// import 'package:thrifty_cab/providers/taxi/app_flow_provider.dart';
// import 'package:thrifty_cab/services/taxiSerivces.dart';
// import 'package:thrifty_cab/utils/colors.dart';
// import 'package:thrifty_cab/utils/sizeConfig.dart';
// import 'package:thrifty_cab/utils/strings.dart';
//
// class FareDetails extends StatelessWidget {
//   const FareDetails({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     SizeConfig().init(context);
//     var h = SizeConfig.screenHeight / 812;
//     var b = SizeConfig.screenWidth / 375;
//     AppFlowProvider appFlowProvider = Provider.of<AppFlowProvider>(context, listen: false);
//
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Container(
//           decoration: allBoxDecoration,
//           child: FutureBuilder(
//               future: Services.getLocalTaxiFare(),
//               builder: (context, AsyncSnapshot<LocalTaxiFare?> snap) {
//                 if (snap.hasData) {
//                   LocalTaxiFare? data = snap.data;
//                   return Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       sh(19),
//                       TextRow(
//                         title: BookingIdLabel,
//                         content: "B3DFFG2GT46",
//                       ),
//                       TextRow(title: TotalKmLabel, content: appFlowProvider.calculateDistance()),
//                       TextRow(title: FareAppliedLabel, content: data!.body!.fareApplied!),
//                       TextRow(title: BaseFareLabel, content: "\u20b9 ${data.body!.baseFare}"),
//                       TextRow(title: ExcessKmsLabel, content: '${data.body!.excessKm} Kms'),
//                       TextRow(
//                           title: StandardFareLabel,
//                           content: '\u20b9 ${data.body!.standardFarePerKm}/Km'),
//                       TextRow(
//                           title: AdditionalFareLabel,
//                           content: '\u20b9 ${data.body!.additonalFare}'),
//                       TextRow(
//                           title: SubTotalFareLabel, content: '\u20b9 ${data.body!.subTotalFare}'),
//                       TextRow(title: DiscountLabel, content: '\u20b9 ${data.body!.totalDiscount}'),
//                       Container(
//                         margin: EdgeInsets.symmetric(horizontal: b * 17),
//                         color: borderColor,
//                         height: h * 1.5,
//                         width: SizeConfig.screenWidth,
//                       ),
//                       sh(12),
//                       TextRow(
//                         title: TotalFareLabel,
//                         content: '\u20b9 ${data.body!.totalFare}',
//                         isBold: true,
//                       ),
//                     ],
//                   );
//                 } else
//                   return sh(0);
//               }),
//         ),
//         Padding(
//           padding: EdgeInsets.only(left: b * 2, top: h * 16, bottom: h * 34),
//           child: Text(
//             "** $GSTLabel",
//             style: TextStyle(
//               fontSize: b * 10,
//               color: Colors.black.withOpacity(0.7),
//               letterSpacing: 0.6,
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
//
// class TextRow extends StatelessWidget {
//   final String title;
//   final String content;
//   final bool isBold;
//
//   const TextRow({Key? key, required this.title, required this.content, this.isBold = false})
//       : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     var h = SizeConfig.screenHeight / 812;
//     var b = SizeConfig.screenWidth / 375;
//     return Padding(
//       padding: EdgeInsets.only(left: b * 20, right: b * 20, bottom: h * 15),
//       child: Row(
//         children: [
//           Expanded(
//             child: Text(
//               title,
//               style: TextStyle(
//                 fontWeight: isBold ? FontWeight.w900 : FontWeight.w500,
//                 fontSize: b * 12,
//                 letterSpacing: 0.6,
//               ),
//             ),
//           ),
//           Expanded(
//             child: Text(
//               content,
//               textAlign: TextAlign.end,
//               style: TextStyle(
//                 fontWeight: isBold ? FontWeight.w900 : FontWeight.w500,
//                 fontSize: b * 12,
//                 color: secondaryColor,
//                 letterSpacing: 0.6,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
