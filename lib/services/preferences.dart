import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sultan_cab/models/current_loc_model.dart';
import 'package:sultan_cab/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesUtils {
  static SharedPreferences? pref;
  static PreferencesUtils _prefUtils = PreferencesUtils();

  static String currentCity = "currentCity";
  static String currentDropCity = 'currentDropCity';
  static String currentCityID = 'currentCityID';
  static String currentDropCityID = 'dropCityID';
  static String pickCoordinatesLat = 'pickUpCoordinatesLat';
  static String pickCoordinatesLong = "pickUpCoordinatesLong";
  static String dropCoordinatesLat = 'dropOffCoordinatesLat';
  static String dropCoordinatesLong = 'dropOffCoordinatesLong';
  static String pickUpAddr = 'pickUpAddr';
  static String dropOffAddr = 'dropOffAddr';
  static String pickTime = 'pickTime';
  static String dropTime = 'dropTime';

  static String apiToken = "api_token";
  static String userId = 'user_id';
  static String fcmId = 'fcm_id';
  static String deviceToken = 'device_token';
  static String socialmediaUid = 'socialmedia_uid';
  static String userName = 'user_name';
  static String phone = 'phone';
  static String nationality = 'nationality';
  static String phoneCode = 'phone_code';
  static String emailid = 'emailid';
  static String profilePic = 'profile_pic';
  static String status = 'status';
  static String phoneVerified = 'phone_verified';
  static String timestamp = 'timestamp';
  static String docType = 'doc_type';
  static String address = 'address';
  static String emailVerified = 'email_verified';

  _init() async {
    pref = await SharedPreferences.getInstance();
  }

  static Future<void> setLoc({required CurrentLoc locDetails}) async {
    if (pref == null) await _prefUtils._init();
    pref!.setString(currentCity, locDetails.pickCity!);
    pref!.setString(currentCityID, locDetails.pickCityID!);
    pref!.setString(currentDropCity, locDetails.dropCity!);
    pref!.setString(currentDropCityID, locDetails.dropCityID!);
    pref!.setString(
        pickCoordinatesLat, locDetails.pickCoordinates!.latitude.toString());
    pref!.setString(
        pickCoordinatesLong, locDetails.pickCoordinates!.longitude.toString());
    pref!.setString(
        dropCoordinatesLat, locDetails.dropCoordinates!.latitude.toString());
    pref!.setString(
        dropCoordinatesLong, locDetails.dropCoordinates!.longitude.toString());
    pref!.setString(pickUpAddr, locDetails.pickCityAddr!);
    pref!.setString(dropOffAddr, locDetails.dropCityAddr!);
    pref!.setString(pickTime, locDetails.pickTime!.toString());
    pref!.setString(dropTime, locDetails.dropTime!.toString());
  }

  static Future<CurrentLoc?> getLoc() async {
    try {
      CurrentLoc loc = CurrentLoc();
      loc.pickCity = pref!.getString(currentCity);
      loc.pickCityID = pref!.getString(currentCityID);
      loc.dropCity = pref!.getString(currentDropCity);
      loc.dropCityID = pref!.getString(currentDropCityID);
      loc.pickCityAddr = pref!.getString(pickUpAddr);
      loc.dropCityAddr = pref!.getString(dropOffAddr);
      loc.pickCoordinates = LatLng(
          double.parse(pref!.getString(pickCoordinatesLat) ?? ""),
          double.parse(pref!.getString(pickCoordinatesLong) ?? ""));
      loc.dropCoordinates = LatLng(
          double.parse(pref!.getString(dropCoordinatesLat) ?? ""),
          double.parse(pref!.getString(dropCoordinatesLong) ?? ""));
      loc.pickTime = DateTime.parse(pref!.getString(pickTime) ?? "");
      loc.dropTime = DateTime.parse(pref!.getString(dropTime) ?? "");
      return loc;
    } catch (e) {
      return null;
    }
  }

  static Future<void> setPref(String key, String data) async {
    if (pref == null) await _prefUtils._init();
    pref!.setString(key, data);
  }

  static Future<void> setIntPref(String key, int data) async {
    if (pref == null) await _prefUtils._init();
    await pref!.setInt(key, data);
  }

  static Future getPref(String key) async {
    if (pref == null) await _prefUtils._init();

    var data = pref!.get(key) ?? null;
    return data;
  }

  static Future<int?> getIntPref(String key) async {
    if (pref == null) await _prefUtils._init();

    var data = pref!.getInt(key) ?? null;
    return data;
  }

  static Future<void> setUser(Userinfo user) async {
    if (pref == null) await _prefUtils._init();

    pref!.setInt(userId, user.userId!);
    pref!.setString(apiToken, user.apiToken!);
    pref!.setString(fcmId, user.fcmId!);
    pref!.setString(deviceToken, user.deviceToken ?? 'null');
    pref!.setString(socialmediaUid, user.socialmediaUid ?? 'null');
    pref!.setString(userName, user.userName ?? 'null');
    pref!.setString(nationality, user.nationality ?? 'null');
    pref!.setString(phone, user.phone ?? "null");
    pref!.setString(phoneCode, user.phoneCode ?? 'null');
    pref!.setString(emailid, user.emailid!);
    pref!.setString(profilePic, user.profilePic ?? 'null');
    pref!.setInt(status, user.status ?? 0);
    pref!.setInt(phoneVerified, user.phoneVerified ?? 0);
    pref!.setString(timestamp, user.timestamp!);
    pref!.setString(docType, user.docType ?? 'null');
    pref!.setString(address, user.address ?? "");
    pref!.setInt(emailVerified, user.emailVerified ?? 0);

    pref!.setBool("isLoggedIn", true);
  }

  static Future<Userinfo?> getUser() async {
    if (pref == null) await _prefUtils._init();

    bool isLoggedIn = pref!.getBool('isLoggedIn') ?? false;

    if (!isLoggedIn) return null;

    Userinfo user = Userinfo();

    user.userId = pref!.getInt(userId);
    user.apiToken = pref!.getString(apiToken);
    user.fcmId = pref!.getString(fcmId);
    user.deviceToken = pref!.getString(deviceToken);
    user.socialmediaUid = pref!.getString(socialmediaUid);
    user.userName = pref!.getString(userName);
    user.phone = pref!.getString(phone);
    user.phoneCode = pref!.getString(phoneCode);
    user.nationality = pref!.getString(nationality);
    user.emailid = pref!.getString(emailid);
    user.profilePic = pref!.getString(profilePic);
    user.status = pref!.getInt(status);
    user.phoneVerified = pref!.getInt(phoneVerified);
    user.timestamp = pref!.getString(timestamp);
    user.address = pref!.getString(address) ?? "";
    user.docType = pref!.getString(docType) ?? null;
    user.emailVerified = pref!.getInt(emailVerified) ?? 0;
    return user;
  }

  static Future<void> clearPref() async {
    if (pref == null) await _prefUtils._init();

    CurrentLoc? loc = await getLoc();
    await pref!.clear();
    await setLoc(locDetails: loc!);
    await setPref('isFirst', '0');
  }
}
