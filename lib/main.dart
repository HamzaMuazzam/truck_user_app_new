import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_phone_auth_handler/firebase_phone_auth_handler.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sultan_cab/auth_widget.dart';
import 'package:sultan_cab/providers/Truck%20_provider/payment_provider.dart';
import 'package:sultan_cab/providers/auth_provider.dart';
import 'package:sultan_cab/providers/booking_provider.dart';
import 'package:sultan_cab/providers/home_provider.dart';
import 'package:sultan_cab/providers/track_provider.dart';
import 'package:sultan_cab/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'providers/AddToFav/add_to_fav_controller.dart';
import 'providers/ChatProvider/chat_provider.dart';
import 'providers/Dispute/dispute_provider.dart';
import 'providers/GoogleMapProvider/location_and_map_provider.dart';
import 'providers/NotificationProvider/notification_provider.dart';
import 'providers/Reoccurring/reoccurring.dart';
import 'providers/RideHistory/ride_history.dart';
import 'providers/SubscriptionModel/subscription_plan.dart';
import 'providers/TaxiBookingProvider/in_progress_ride_provider.dart';
import 'providers/TaxiBookingProvider/truck_booking_provider.dart';
import 'providers/Truck _provider/fair_provider.dart';
import 'providers/truck_provider/app_flow_provider.dart';


class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() async {
  HttpOverrides.global = MyHttpOverrides();

  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();

  await Firebase.initializeApp(
    options: FirebaseOptions(
        apiKey: 'AIzaSyCrE9nXUcr0QSd18fiv4-juxqXD9Ch6Ad0',
        appId: '1:236880847063:android:95fe652d2293b1cef15092',
        messagingSenderId: '236880847063',
        projectId:
        'tucking-app-c9418'),
  );
  // setUrlStrategy(PathUrlStrategy());
  runApp(
    MyApp(),
  );
}

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => NotificationsProvider()),
        ChangeNotifierProvider(create: (_) => HomeProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => BookingProvider()),
        ChangeNotifierProvider(create: (_) => TrackProvider()),
        ChangeNotifierProvider(create: (_) => TruckBookingProvider()),
        ChangeNotifierProvider(create: (_) => AppFlowProvider()),
        ChangeNotifierProvider(create: (_) => ChatProvider()),
        ChangeNotifierProvider(create: (_) => LocationAndMapProvider()),
        ChangeNotifierProvider(create: (_) => RideHistoryProvider()),
        ChangeNotifierProvider(create: (_) => ReoccurringProvider()),
        ChangeNotifierProvider(create: (_) => AddToFavourite()),
        ChangeNotifierProvider(create: (_) => SubscriptionProvider()),
        ChangeNotifierProvider(create: (_) => DisputeProvider()),
        ChangeNotifierProvider(create: (_) => FirebasePhoneAuthController()),
        ChangeNotifierProvider(create: (_) => InProgressRideProvider()),
        ChangeNotifierProvider(create: (_) => FairTruckProvider()),
        ChangeNotifierProvider(create: (_) => PaymentProvider()),
      ],
      child: GetMaterialApp(
        title: 'Truc-king',
        debugShowCheckedModeBanner: false,
        navigatorKey: navigatorKey,
        theme: ThemeData.dark(),
        home: AuthWidget(),
      ),
    );
  }
}
