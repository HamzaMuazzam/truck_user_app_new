import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class StorageServices {
  static String aadharFileName = 'aadhar';
  static String driveLicFileName = 'driveLic';
  static String overseasLicFileName = 'overseasLic';
  static String intLicFileName = 'intLic';
  static String passportFileName = 'passport';

  static Future<File?> getDocFromLocal({@required String? fileName}) async {
    Directory? tempDir = await getExternalStorageDirectory();
    String tempPath = tempDir!.path;

    final file = File("$tempPath/$fileName.jpg");

    if (await file.exists())
      return file;
    else
      return null;
  }

  static Future<void> saveDocToLocalOnUpdate(
      {@required String? docType,
      List<Uint8List?>? aadhaar,
      List<Uint8List?>? driveLic,
      List<Uint8List?>? overseasLic,
      List<Uint8List?>? intLic,
      List<Uint8List?>? passport}) async {
    Directory? tempDir = await getExternalStorageDirectory();
    String tempPath = tempDir!.path;

    await Directory(tempPath).delete(recursive: true);
    await tempDir.create(recursive: true);

    if (docType == '1') {
      for (int i = 0; i < 4; i++)
        if (aadhaar![i] != null) {
          File file = File('$tempPath/aadhar$i.jpg');
          await file.writeAsBytes(aadhaar[i]!);
        }

      print("Success writing file");

      for (int i = 0; i < 4; i++)
        if (driveLic![i] != null) {
          File file = File('$tempPath/driveLic$i.jpg');
          await file.writeAsBytes(driveLic[i]!);
        }

      print("Success writing file");
    } else if (docType == '0') {
      for (int i = 0; i < 4; i++)
        if (overseasLic![i] != null) {
          File file = File('$tempPath/overseasLic$i.jpg');
          await file.writeAsBytes(overseasLic[i]!);
        }

      for (int i = 0; i < 4; i++)
        if (intLic![i] != null) {
          File file = File('$tempPath/intLic$i.jpg');
          await file.writeAsBytes(intLic[i]!);
        }

      for (int i = 0; i < 4; i++)
        if (passport![i] != null) {
          File file = new File('$tempPath/passport$i.jpg');
          await file.writeAsBytes(passport[i]!);
        }
    }
  }

  static Future saveDocToLocal(
      {@required String? docType, @required Map? data}) async {
    Directory? tempDir = await getExternalStorageDirectory();
    String tempPath = tempDir!.path;

    if (docType == '1') {
      if (data!['aadhar_card'] != null) {
        List<String> aadharImages = new List<String>.from(data['aadhar_card']);

        for (int i = 0; i < aadharImages.length; i++) {
          if (aadharImages[i].isNotEmpty) {
            final res = await http.get(Uri.parse(aadharImages[i]));
            File file = new File('$tempPath/aadhar$i.jpg');
            await file.writeAsBytes(res.bodyBytes);
          } else
            break;
        }
        print("Success writing file");
      }
      if (data['domestic_license'] != null) {
        List<String> driveLicImages =
            new List<String>.from(data['domestic_license']);
        for (int i = 0; i < driveLicImages.length; i++) {
          if (driveLicImages[i].isNotEmpty) {
            final res = await http.get(Uri.parse(driveLicImages[i]));
            File file = new File('$tempPath/driveLic$i.jpg');
            await file.writeAsBytes(res.bodyBytes);
          } else
            break;
        }
        print("Success writing file");
      }
    } else if (docType == '0') {
      if (data!['driving_permit'] != null) {
        List<String> overseasImages =
            new List<String>.from(data['driving_permit']);

        for (int i = 0; i < overseasImages.length; i++) {
          if (overseasImages[i].isNotEmpty) {
            final res = await http.get(Uri.parse(overseasImages[i]));
            File file = new File('$tempPath/overseasLic$i.jpg');
            await file.writeAsBytes(res.bodyBytes);
          } else
            break;
        }
        print("Success writing file");
      }
      if (data['international_license'] != null) {
        List<String> intLicImage =
            new List<String>.from(data['international_license']);

        for (int i = 0; i < intLicImage.length; i++) {
          if (intLicImage[i].isNotEmpty) {
            final res = await http.get(Uri.parse(intLicImage[i]));
            File file = new File('$tempPath/intLic$i.jpg');
            await file.writeAsBytes(res.bodyBytes);
          } else
            break;
        }
        print("Success writing file");
      }
      if (data['passport'] != null) {
        List<String> passportImage = new List<String>.from(data['passport']);

        for (int i = 0; i < passportImage.length; i++) {
          if (passportImage[i].isNotEmpty) {
            final res = await http.get(Uri.parse(passportImage[i]));
            File file = new File('$tempPath/passport$i.jpg');
            await file.writeAsBytes(res.bodyBytes);
          } else
            break;
        }
        print("Success writing file");
      }
    }
  }

  static Future clearStorageOnLogout() async {
    Directory? tempDir = await getExternalStorageDirectory();

    tempDir!.listSync().forEach((element) {
      element.delete(recursive: true);
    });
  }
}
