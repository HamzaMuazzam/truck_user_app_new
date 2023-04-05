import 'package:flutter/material.dart';

class ReoccurringProvider extends ChangeNotifier {
  ReoccurringSchedule? reoccurringSchedule;

  void setReoccurringValue({
    required List<dynamic> days,
    required String time,
  }) {
    reoccurringSchedule = ReoccurringSchedule(days: days, time: time);

    notifyListeners();
  }
}

class ReoccurringSchedule {
  final List<dynamic> days;
  final String time;

  ReoccurringSchedule({required this.days, required this.time});
}
