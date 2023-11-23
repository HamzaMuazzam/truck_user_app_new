import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sultan_cab/utils/sizeConfig.dart';

const Color secondaryColor = Color(0xFF4ED19A);
const Color textColor = Colors.white;
const Color textGreyColor = Color(0xffBDBDBD);
// const Color primaryColor = Color(0xffDAE238);
const Color primaryColor = Color(0xffffffff);
const Color yellowColor = Color(0xffffe600);

const Color borderColor = Color(0xffe5e5e5);
const Color scaffoldColor = Color(0xff000000);
const Color greenColor = Colors.green;
const Color greyColor = Color(0xff555555);
const Color greybackColor = Color(0xff303031);
const Color textYellowColor = Color(0xFFffC700);
const Color phoneBoxBackground = Color(0xFF4B4C4F);

const Gradient buttonGradient = LinearGradient(
  colors: [primaryColor, primaryColor],
);

var boxShadow2 = [
  BoxShadow(
    color: Color(0xff555555).withOpacity(0.1),
    blurRadius: 9,
    offset: Offset(0, 0),
  )
];
var constBoxDecoration = BoxDecoration(
    // color: Colors.white,
    color: greybackColor);
var allBoxDecoration = BoxDecoration(
  // color: Colors.white,
  color: greybackColor,

  borderRadius: BorderRadius.circular(4),
  boxShadow: [
    BoxShadow(
      color: Color(0xff0000000).withOpacity(0.1),
      spreadRadius: 0,
      blurRadius: 4,
      offset: Offset(0, 4),
    ),
  ],
);

Map<int, Color> swatch = {
  50: primaryColor.withOpacity(0.1),
  100: primaryColor.withOpacity(0.2),
  200: primaryColor.withOpacity(0.3),
  300: primaryColor.withOpacity(0.4),
  400: primaryColor.withOpacity(0.5),
  500: primaryColor.withOpacity(0.6),
  600: primaryColor.withOpacity(0.7),
  700: primaryColor.withOpacity(0.8),
  800: primaryColor.withOpacity(0.9),
  900: primaryColor.withOpacity(1.0),
};
MaterialColor colorSwatch = MaterialColor(0xffffffff, swatch);
// MaterialColor colorSwatch = MaterialColor(0xffDAE238, swatch);

String timeFormat(TimeOfDay _selectedTime) {
  DateTime tempDate = DateFormat("hh:mm").parse(
      _selectedTime.hour.toString() + ":" + _selectedTime.minute.toString());
  var dateFormat = DateFormat("h:mm a");
  return dateFormat.format(tempDate);
}

String timeFormatDate(DateTime _selectedTime) {
  DateTime tempDate = DateFormat("hh:mm").parse(
      _selectedTime.hour.toString() + ":" + _selectedTime.minute.toString());
  var dateFormat = DateFormat("h:mm a");
  return dateFormat.format(tempDate);
}

String dateFormat(DateTime date) {
  var formatDate = DateFormat('dd-MM-yyyy').format(date);
  return formatDate.toString();
}

String dateFormatString(String date) {
  DateTime dateFormatted = DateTime.parse(date);
  var formatDate = DateFormat('dd-MM-yyyy').format(dateFormatted);
  return formatDate.toString();
}

DropdownMenuItem<int> hubItem() {
  var h = SizeConfig.screenHeight / 812;
  var b = SizeConfig.screenWidth / 375;

  return DropdownMenuItem<int>(
    child: Container(
      height: h * 23,
      width: b * 120,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Color(0xff1a1a1a),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        "HubLabel",
        style: TextStyle(
          color: Colors.white,
          fontSize: b * 12,
          letterSpacing: 0.6,
          fontStyle: FontStyle.italic,
        ),
      ),
    ),
    value: -2,
  );
}
//
// ThemeData lightTheme(){
//   return ThemeData(
//     scaffoldBackgroundColor: scaffoldColor,
//     primarySwatch: colorSwatch,
//     primaryColor: Colors.black,
//     appBarTheme: AppBarTheme(
//       centerTitle: true,
//       backgroundColor: Colors.black,
//       elevation: 3,
//       titleTextStyle: TextStyle(
//         color: secondaryColor,
//         fontSize: 15,
//         fontWeight: FontWeight.bold,
//       ),
//     ),
//   );
// }
//
// ThemeData darkTheme(){
//   return ThemeData(
//     scaffoldBackgroundColor: scaffoldColor,
//     primarySwatch: colorSwatch,
//     primaryColor: Colors.white,
//     appBarTheme: AppBarTheme(
//       centerTitle: true,
//       backgroundColor: primaryColor,
//       elevation: 3,
//       titleTextStyle: TextStyle(
//         color: secondaryColor,
//         fontSize: 15,
//         fontWeight: FontWeight.bold,
//       ),
//     ),
//   );
// }
