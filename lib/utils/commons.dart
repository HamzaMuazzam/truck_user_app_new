import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';


Logger logger = Logger();


gotoPage(Widget widget,
    {Transition transition: Transition.native,
      Duration duration: const Duration(seconds: 1),
      bool isClosePrevious: false}) {
  if (isClosePrevious) {
    Get.offAll(() => widget, transition: transition, duration: duration);
  } else {
    Get.to(() => widget, transition: transition, duration: duration);
  }
}