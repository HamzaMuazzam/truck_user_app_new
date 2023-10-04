import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sultan_cab/services/apiServices/StorageServices/get_storage.dart';
import 'notification_service.dart';
int notificationNumber = 0;

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage event) async {
  print('_firebaseMessagingBackgroundHandler');
  print("event.data ${event.data.toString()}");

  NotificationRoutes.onMessageRecived(event, isDataFromBackground: true);
  await Firebase.initializeApp();
}

class FCM {
  FirebaseMessaging? _messaging;

  FCM() {
    try{
      FlutterLocalNotificationsPlugin fltrNotification;
      var androidInitilize = const AndroidInitializationSettings('logo');
      var iOSinitilize = const DarwinInitializationSettings();
      var initilizationsSettings =
          InitializationSettings(android: androidInitilize, iOS: iOSinitilize);
      var androidDetails = const AndroidNotificationDetails(
          "TRUC-KING",
          "HAMZA "
              "MUAZZAM programmer",
          importance: Importance.max,
          priority: Priority.max);
      var iSODetails = const DarwinNotificationDetails();
      var generalNotificationDetails =
          NotificationDetails(android: androidDetails, iOS: iSODetails);

      fltrNotification = FlutterLocalNotificationsPlugin();
      Firebase.initializeApp().then((fbr) async {
        _messaging = FirebaseMessaging.instance;
        _messaging!.getToken().then((token) async {
          FirebaseMessaging.onBackgroundMessage(
              _firebaseMessagingBackgroundHandler);

          await _messaging!.subscribeToTopic("AllUsers").then((value) => null);
          if (StorageCRUD.getUser().id != null) {
            await _messaging!
                .subscribeToTopic("${StorageCRUD.getUser().id}")
                .then((value) => null);
          }

          NotificationSettings settings = await _messaging!.requestPermission(
            alert: true,
            badge: true,
            provisional: false,
            sound: true,
          );

          if (settings.authorizationStatus == AuthorizationStatus.authorized) {
            await Firebase.initializeApp();
            FirebaseMessaging.onMessageOpenedApp.listen((event) {
              NotificationRoutes.onNotificationClick(event.data);
            });
            FirebaseMessaging.onMessage.listen((event) async {
              print('FirebaseMessaging.onMessage.listen');
              print("event.data ${event.data.toString()}");

              NotificationRoutes.onMessageRecived(event,
                  isDataFromBackground: false,
                  fltrNotification: fltrNotification,
                  initilizationsSettings: initilizationsSettings,
                  generalNotificationDetails: generalNotificationDetails);
            });
          }
        });
      });
    }catch(e){
      print(e);
      Fluttertoast.showToast(msg: e.toString());
    }
  }
}
