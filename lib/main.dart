import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_phone_auth_handler/firebase_phone_auth_handler.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:sultan_cab/languages/ContollerBindings.dart';
import 'package:sultan_cab/languages/LanguageController.dart';
import 'package:sultan_cab/languages/Localization.dart';
import 'package:sultan_cab/providers/Truck%20_provider/payment_provider.dart';
import 'package:sultan_cab/providers/auth_provider.dart' as Auth;
import 'package:url_launcher/url_launcher.dart';

import 'auth_widget.dart';
import 'customized_plugins/lib/src/WebMapProvider.dart';
import 'providers/GoogleMapProvider/location_and_map_provider.dart';
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

  if (kIsWeb) {
    await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: 'AIzaSyCrE9nXUcr0QSd18fiv4-juxqXD9Ch6Ad0',
          appId: '1:236880847063:android:95fe652d2293b1cef15092',
          messagingSenderId: '236880847063',
          projectId: 'tucking-app-c9418'),
    );
  }
  {
    await Firebase.initializeApp();
  }
  runApp(
    Phoenix(child: MyApp()),
  );
}

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var local = GetStorage().read("locale");

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Auth.AuthProvider()),
        ChangeNotifierProvider(create: (_) => TruckBookingProvider()),
        ChangeNotifierProvider(create: (_) => AppFlowProvider()),
        ChangeNotifierProvider(create: (_) => LocationAndMapProvider()),
        ChangeNotifierProvider(create: (_) => FirebasePhoneAuthController()),
        ChangeNotifierProvider(create: (_) => FairTruckProvider()),
        ChangeNotifierProvider(create: (_) => PaymentProvider()),
        ChangeNotifierProvider(create: (_) => WebMapProvider()),
      ],
      child: GetMaterialApp(
        title: 'Truc-king',
        debugShowCheckedModeBanner: false,
        navigatorKey: navigatorKey,
        theme: ThemeData.dark(),
        localizationsDelegates: const <LocalizationsDelegate<dynamic>>[],
        locale: Locale(local ?? "en"),
        translations: Localization(),
        initialBinding: LanguageControllerBinding(),
        localeResolutionCallback: (locale, supportedLocales) {
          final languageController = LanguageController.to;
          for (var supportedLocale in supportedLocales) {
            if (supportedLocale.languageCode == languageController.locale) {
              return supportedLocale;
            }
          }
          return supportedLocales.first;
        },
        home: LayoutBuilder(builder: (context, constraints) {
          if (GetPlatform.isWeb && constraints.biggest.width <= 650.0) {
            print(constraints.biggest.width);

            return Material(
              child: Container(
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("Download App from the stores.".tr),
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            children: [
                              Expanded(
                                  child: InkWell(
                                onTap: () {
                                  openAppInStore(
                                      "https://play.google.com/store/apps/details?id=com.lahdatech.trucking");
                                },
                                child: Container(
                                  child: Image.asset(
                                      "assets/images/google-play-badge.png"),
                                ),
                              )),
                              SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                  child: InkWell(
                                onTap: () {
                                  openAppInStore(
                                      "https://apps.apple.com/app/id<your_app_id>");
                                },
                                child: Container(
                                  child: Image.asset(
                                      "assets/images/app-store-badge-128x128.png"),
                                ),
                              )),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          }

          return AuthWidget();
        }),
        // home: VehicleChooseScreenWeb(),
      ),
    );
  }
}

Future<void> openAppInStore(String appId) async {
  var parse = Uri.parse(appId);

  if (await canLaunchUrl(parse)) {
    await launchUrl(parse);
  } else {
    throw 'Could not launch $appId';
  }
}
