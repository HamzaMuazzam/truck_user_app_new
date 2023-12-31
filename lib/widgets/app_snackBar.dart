import 'package:flutter/material.dart';
import 'package:sultan_cab/utils/colors.dart';

appSnackBar(
    {@required BuildContext? context,
    @required String? msg,
    @required bool? isError}) {
  return ScaffoldMessenger.of(context!).showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.fixed,
      backgroundColor: isError! ? Colors.black : primaryColor,
      content: Text(
        msg!,
        style: TextStyle(
          color: isError ? Colors.white : Colors.black,
        ),
      ),
      duration: Duration(seconds: 2),
    ),
  );
}
