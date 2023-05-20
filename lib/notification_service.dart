import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:sultan_cab/services/ApiServices/api_services.dart';

import 'FCM.dart';
import 'models/Truck_models/getAllOrdersResponse.dart';
import 'screens/TruckBooking/getOrderDetailsById.dart';
import 'utils/commons.dart';

backGroundListen(NotificationResponse notificationResponse) async {
  try {
    NotificationRoutes.onNotificationClick(
        data ?? json.decode(notificationResponse.payload ?? ""));
  } catch (e) {
    print(e);
  }
}

Map<String, dynamic>? data;

class NotificationRoutes {
  //TODO: Message data/pay load received from foreground and background.
  static onMessageRecived(RemoteMessage event,
      {bool? isDataFromBackground,
      FlutterLocalNotificationsPlugin? fltrNotification,
      InitializationSettings? initilizationsSettings,
      NotificationDetails? generalNotificationDetails}) async {
    try{
      ///TODO: this check will insure that if app is open and in foreground and
      ///we need to show notification or not
      ///TODO: like if chat screen is open and message come for the same chat user so here we will prevent to not to show notification
      ///TODO: if(!isDataFromBackground && chatNextUserId==event.data['nextUserIs']) { return don't  show notification here.}. ==> {HAMZA MUAZZAM 01-07-2022}

      if (!isDataFromBackground!) {
        fltrNotification!.initialize(initilizationsSettings!,
            onDidReceiveNotificationResponse:
                (NotificationResponse notificationResponse) async {
          NotificationRoutes.onNotificationClick(event.data);
        }, onDidReceiveBackgroundNotificationResponse: backGroundListen);
        await fltrNotification.show(
            notificationNumber,
            event.notification != null ? event.notification!.title : "".tr,
            event.notification != null ? event.notification!.body : "".tr,
            generalNotificationDetails,
            payload: event.data.toString());
        ++notificationNumber;

        ///TODO: I added this line here to trigger the notification click auto and will open order detail screen automatically once any notification reached
        onNotificationClick(event.data);

      }
    }
    catch(e){
      print(e);
      Fluttertoast.showToast(msg: e.toString());

    }
  }

  //TODO: when user click on notification in  foreground or background.
  static onNotificationClick(Map<String, dynamic> payload) async {
    try{
      logger.e(payload);

      // String? screen = payload['Screen'];
      //TODO: if app is not open so we have to wait here to let the app open... if context is null we will not go further. wait instead .
      while (Get.context == null) {}

      ///  maryam do work here if payload has specific value then go to that screen accordingly
      ///  like payload['screenName']=="Order Details Screen" or   payload['orderId']!=null then go to order details screen with id

      if (payload['Route'] == "order_screen" &&
          (payload['orderId'] != null || payload['OrderId'] != null)) {
        String? orderID = payload['OrderId'] ?? "";
        String response = await ApiServices.getMethod(
            feedUrl: "/Order/get-order-by-Id?id=$orderID");

        if (response.isNotEmpty) {
          if (Get.currentRoute.contains("OrderDetailById")) {
            Get.back();
          }
          Get.to(OrderDetailById(
              GetAllOrdersResponse.fromJson(json.decode(response))));
        }
      }
    }catch(e){
      print(e);
      Fluttertoast.showToast(msg: e.toString());

    }
  }
}
