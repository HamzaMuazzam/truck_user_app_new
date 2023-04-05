// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:thrifty_cab/main.dart';
// import 'package:thrifty_cab/models/booking_history_model.dart';
// import 'package:thrifty_cab/screens/bookingDetail.dart';
// import 'package:thrifty_cab/services.dart/booking_services.dart';

// onMessage(RemoteMessage message) {
//   print("OnMessage");

//   final data = message.data;

//   print(data);

//   showNotification(message);
// }

// Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   print("Handling a background message: ${message.data}");
//   showNotification(message);
// }

// showNotification(RemoteMessage message) {
//   var flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
//   final androidSettings =
//       AndroidInitializationSettings('@mipmap/launcher_icon');
//   final iosSettngs = IOSInitializationSettings();
//   final initializationSettings =
//       InitializationSettings(android: androidSettings, iOS: iosSettngs);

//   flutterLocalNotificationsPlugin.initialize(initializationSettings,
//       onSelectNotification: onTapNotification);

//   const androidSpecificNotification = AndroidNotificationDetails(
//       'booking_status', 'booking_notifications',
//       importance: Importance.high,
//       color: Colors.yellow,
//       priority: Priority.high,
//       styleInformation: BigTextStyleInformation(''));

//   const iosSpecificNotification = IOSNotificationDetails();

//   const NotificationDetails platformChannelSpecifics = NotificationDetails(
//       android: androidSpecificNotification, iOS: iosSpecificNotification);

//   final msg = jsonDecode(message.data['message']);

//   flutterLocalNotificationsPlugin.show(0, msg['notification']['title'],
//       msg['notification']['body'], platformChannelSpecifics,
//       payload: jsonEncode(msg['data']));
// }

// onTapNotification(String? payload) async {
//   print("Tapped on Notification");
//   // ignore: unused_local_variable
//   final data = jsonDecode(payload!);
//   print(data);

//   if (data['type'] == 'booking') {
//     final res = await BookingServices.getBookingHistory();

//     final booking = BookingHistoryModel.fromJson(res['data'].where((ele) {
//       return ele['booking_id'] == data['booking_id'] ? true : false;
//     }).first);

//     Navigator.of(navigatorKey.currentContext!).push(
//         MaterialPageRoute(builder: (_) => BookingDetail(booking: booking)));
//   }
// }
