import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/widgets.dart';
import 'package:sultan_cab/models/user_model.dart';
import 'package:sultan_cab/services/profile_services.dart';
import 'package:sultan_cab/services/storage_services.dart';

class UserProvider extends ChangeNotifier {
  List<dynamic> _nationalities = [];
  List<dynamic> get nationalities => _nationalities;

  int _docType = 1;
  int get docType => _docType;

  Future<void> setDocType(int type) async {
    _docType = type;
  }

  Future<void> getNationality() async {
    try {
      final res = await ProfileServices.getNationalityServices();
      _nationalities = res['data']['nationality'];
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<void> getProfile() async {
    try {
      final res = await ProfileServices.getProfileData();
      // ignore: unused_local_variable
      final data = res['data'];
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<void> updateProfile(
      {@required Userinfo? user,
      List<File?>? aadhar,
      List<File?>? driveLic,
      List<File?>? overseasLic,
      List<File?>? intLic,
      List<File?>? passport}) async {
    try {
      await ProfileServices.updateProfile();
      print(user!.docType);

      List<Uint8List?> aadharBytes = [];
      List<Uint8List?> driveLicBytes = [];
      List<Uint8List?> overseasBytes = [];
      List<Uint8List?> intlLicBytes = [];
      List<Uint8List?> passportBytes = [];

      if (aadhar != null)
        for (int i = 0; i < 4; i++) {
          if (aadhar[i]!.path != '') {
            aadharBytes.add(aadhar[i]!.readAsBytesSync());
          } else
            aadharBytes.add(null);
        }

      if (driveLic != null)
        for (int i = 0; i < 4; i++) {
          if (driveLic[i]!.path != '') {
            driveLicBytes.add(driveLic[i]!.readAsBytesSync());
          } else
            driveLicBytes.add(null);
        }
      if (overseasLic != null)
        for (int i = 0; i < 4; i++) {
          if (overseasLic[i]!.path != '') {
            overseasBytes.add(overseasLic[i]!.readAsBytesSync());
          } else
            overseasBytes.add(null);
        }

      if (intLic != null)
        for (int i = 0; i < 4; i++) {
          if (intLic[i]!.path != '') {
            intlLicBytes.add(intLic[i]!.readAsBytesSync());
          } else
            intlLicBytes.add(null);
        }

      if (passport != null)
        for (int i = 0; i < 4; i++) {
          if (passport[i]!.path != '') {
            passportBytes.add(passport[i]!.readAsBytesSync());
          } else
            passportBytes.add(null);
        }

      await StorageServices.saveDocToLocalOnUpdate(
          docType: user.docType,
          aadhaar: aadharBytes,
          driveLic: driveLicBytes,
          overseasLic: overseasBytes,
          intLic: intlLicBytes,
          passport: passportBytes);

      print("Profile Updated");
    } catch (e) {
      print(e);
      throw e;
    }
  }
}
