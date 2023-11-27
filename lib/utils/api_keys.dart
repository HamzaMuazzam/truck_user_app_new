import 'package:get_storage/get_storage.dart';

/// TH
// const String GoogleMapApiKey = 'AIzaSyCqcZ7xj1BPJeC3Uyo2coGi9qaGNpyU_EA';
//
const String GoogleMapApiKey = 'AIzaSyCDj6L424YNh9KEwxJXDedzc49D_BMicuE';
const String RazorPayID = 'YOUR_PAY_ID_HERE';
const String RazorPaySecretID = 'YOUR_SECRET_KEY_HERE';

String? getLocal() {
  return GetStorage().read("locale");
}
