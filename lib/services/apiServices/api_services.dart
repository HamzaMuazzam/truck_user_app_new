import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:sultan_cab/services/ApiServices/StorageServices/get_storage.dart';
import 'package:sultan_cab/services/ApiServices/api_urls.dart';
import 'package:sultan_cab/utils/commons.dart';
import 'package:sultan_cab/utils/const.dart';

class ApiServices {
  static final headers = {
    'Authorization': 'Bearer ${StorageCRUD.getUser().userTokens ?? ''}'
  };
  static final header = {'content-type': 'application/json'};

  static Future<String> postMethod(
      {Map<String, String>? fields,
      String? files,
      required String feedUrl,
      bool forSignInSignUp = false,
      bool showProgress = true}) async {
    if (showProgress) AppConst.startProgress();
    http.MultipartRequest request =
        http.MultipartRequest('POST', Uri.parse(ApiUrls.BASE_URL_TRUCK + feedUrl));
    if (fields != null) request.fields.addAll(fields);
    if (files != null)
      request.files
          .add(await http.MultipartFile.fromPath('profileImage', files));
    if (!forSignInSignUp) request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    if (showProgress) AppConst.stopProgress();

    if (response.statusCode == 200 || response.statusCode == 201) {
      String result = await response.stream.bytesToString();
      logger.i(result);
      return result;
    } else {
      String result = await response.stream.bytesToString();
      dynamic parsed = jsonDecode(result);
      // await AppConst.errorSnackBar("${response.statusCode} ${parsed["message"]}");
      await AppConst.errorSnackBar("Something went wrong.");

      logger.e(parsed);

      return "";
    }
  }

  static Future<String> getMethod({required String feedUrl}) async {
    logger.e("${ApiUrls.BASE_URL_TRUCK}${feedUrl}");
    var request =
        http.Request('GET', Uri.parse("${ApiUrls.BASE_URL_TRUCK}${feedUrl}"));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    String result = await response.stream.bytesToString();
    logger.i(result);

    if (response.statusCode == 200) {
      return result;
    } else {
      logger.e(result);
      // await 10.delay();
      // Get.dialog(Material(
      //     child: Container(
      //       child: Center(child: Text(
      //
      //           "\nURL: $feedUrl"
      //           "\nCode ${response.statusCode}"
      //           "\nResponse: $result")),
      //     )
      // ));
      return "";
    }
  }

  static Future<String> deleteMethod(
      {required String feedUrl, required Map<String, String> fields}) async {
    var request =
        http.Request('DELETE', Uri.parse("${ApiUrls.BASE_URL_TRUCK}${feedUrl}"));
    request.bodyFields = fields;
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    String result = await response.stream.bytesToString();
    logger.i(result);

    if (response.statusCode == 200) {
      return result;
    } else {
      return "";
    }
  }

  static Future<String> getMethodWithBody(
      String feedUrl, Map<String, String>? fields) async {
    var request =
        http.MultipartRequest('GET', Uri.parse(ApiUrls.BASE_URL_TRUCK + feedUrl));
    if (fields != null) request.fields.addAll(fields);
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();

    String result = await response.stream.bytesToString();

    logger.i(result);
    if (response.statusCode == 200) {
      return result;
    } else {
      print(response.reasonPhrase);
      return "";
    }
  }

  ///
  ///
  ///
  ///

  static Future<String> postMethodTruck({
    // String? files,
    String feedUrl = "",
    String body = "",
    String requestType = "POST",
    String contentType = 'application/json',
  }) async {
    var request = http.Request(
        requestType, Uri.parse("${ApiUrls.BASE_URL_TRUCK}$feedUrl"));

    request.headers.addAll({'content-type': 'application/json'});
    if (requestType == "GET") {
    } else if (requestType == "POST") {
      request.body = body;
    }
    http.StreamedResponse response = await request.send();
    AppConst.stopProgress();

    var s = await response.stream.bytesToString();
      logger.i("postMethodTruck "+ s);
    if (response.statusCode == 200 || response.statusCode == 201) {
      print("await response.stream.bytesToString()");
      return s;
    } else {
      AppConst.errorSnackBar('Something wrong \n $s');
      return "";
    }
  }

  ///
  ///
  ///
  ///

  static Future<String> multiPartPostMethodTruck(
  {String? fileName,String? files, Map<String, String>? fields,required String
  feed}
     ) async {
    AppConst.startProgress();
    var request = http.MultipartRequest('POST',
        Uri.parse('${ApiUrls.BASE_URL_TRUCK}${feed}'));
    if (fields != null) request.fields.addAll(fields);
    if (files != null && fileName!=null)
      request.files.add(await http.MultipartFile.fromPath(fileName, files));
    request.headers.addAll({'content-type': 'multipart/form-data'});
    http.StreamedResponse response = await request.send();
    AppConst.stopProgress();

    if (response.statusCode == 200 || response.statusCode == 201) {
      String result = await response.stream.bytesToString();
      logger.i(result);
      return result;
    } else {
      String result = await response.stream.bytesToString();
      logger.i(result.toString());
      AppConst.errorSnackBar('Something is wrong \n $result');

      return "";
    }
  }

  ///
  ///
  static Future<String> getMethodTruck({required String feedUrl}) async {
    var request =
        http.Request('GET', Uri.parse("${ApiUrls.BASE_URL_TRUCK}${feedUrl}"));
    http.StreamedResponse response = await request.send();
    String result = await response.stream.bytesToString();
    AppConst.stopProgress();
    if (response.statusCode == 200 || response.statusCode == 201) {
      return result;
    } else {
      AppConst.errorSnackBar('Something is wrong \n $result');
      return "";
    }
  }
  static Future<String> getMethodTruckWithBody({required String feedUrl,
  required String body})
  async {
    var request =
    http.Request('GET', Uri.parse("${ApiUrls.BASE_URL_TRUCK}${feedUrl}${body}"));
    http.StreamedResponse response = await request.send();
    String result = await response.stream.bytesToString();
    AppConst.stopProgress();
    if (response.statusCode == 200 || response.statusCode == 201) {
      return result;
    }
    else if(response.statusCode==404)
      {
        // AppConst.errorSnackBar('Something is wrong \n ');
        return '';
      }
    else {
      AppConst.errorSnackBar('Something is wrong \n $result');
      return "";
    }
  }
}
