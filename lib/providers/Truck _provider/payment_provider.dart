import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:sultan_cab/models/Truck_models/get_payment_evidence_response.dart';
import 'package:sultan_cab/utils/commons.dart';
import 'package:sultan_cab/utils/const.dart';
import 'package:http/http.dart' as http;
import '../../models/Truck_models/getAllOrdersResponse.dart';
import '../../services/apiServices/StorageServices/get_storage.dart';
import '../../services/apiServices/api_services.dart';
import '../../services/apiServices/api_urls.dart';
import '../../widgets/app_widgets.dart';
import 'dart:convert';

PaymentProvider paymentProvider =
    Provider.of<PaymentProvider>(Get.context!, listen: false);

class PaymentProvider extends ChangeNotifier {
   XFile? paymentFile;
Widget? paymentWidget;
   Future<String> _multiPartPostMethodTruck(
      {String? fileName,
      Map<String, String>? fields,
      required String feed}) async {
     AppConst.startProgress();
     var headers = {
       'Content-Type': 'application/json'
     };

     if (paymentFile != null) {
       final fileBytes = await paymentFile!.readAsBytes();
       final base64String = base64Encode(fileBytes);
       fields!["PaymentProof"]=base64String;

     }
     var request = http.Request('POST', Uri.parse('https://admin.truc-king.io/api/PaymentEvidence/Upload-Payment-Evidence'));


     request.body = json.encode(fields);
     request.headers.addAll(headers);

     http.StreamedResponse response = await request.send();
     var s = await response.stream.bytesToString();
     AppConst.stopProgress();
     if (response.statusCode == 200) {
       print(s);
       return s;
     }
     else {
       print(response.reasonPhrase);
         AppConst.errorSnackBar('Something is wrong \n ${response.reasonPhrase}');
         return "";
     }
  }

  Future<bool> uploadPaymentEvidence(String orderId) async {
    Map<String, String> fields = {
      'UserId': StorageCRUD.getUser().id.toString(),
      'OrderId': orderId,
    };
    logger.e(paymentFile!.path.toString());
    String body = await _multiPartPostMethodTruck(
        feed: ApiUrls.UPLOAD_PAYMENT_EVIDENCE,
        fields: fields,
        fileName: 'PaymentProof');
    if (body.isEmpty) {
      return false;
    }
    await getPaymentEvidence(orderId);
    AppConst.successSnackBar(body);
    return true;
  }

  Future<void> getPaymentImage(String orderId) async {
    ImagePicker picker = ImagePicker();
    paymentFile == null;
    notifyListeners();
    String choice = await AppWidgets.chooseImageSource();
    if (choice == "Camera") {
      paymentFile = await picker.pickImage(source: ImageSource.camera, imageQuality: 50);
      notifyListeners();
    } else if (choice == "Gallery") {
      paymentFile = await picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
      notifyListeners();
    }
    else if(choice=="Cancel"){
      paymentFile=null;
      return;
    }
    if (paymentFile != null) {

      var bool = await uploadPaymentEvidence(orderId);
      // paymentFile == null;
    }
    logger.i(paymentFile!.path);
  }

  String paymentEvidenceUrl = '';
  GetPaymentEvidenceResponse? getPaymentEvidenceResponse;

  Future<bool> getPaymentEvidence(String orderId) async {
    AppConst.startProgress();
    paymentEvidenceUrl = '';
    String body = '?userId=${StorageCRUD.getUser().id}&orderId=${orderId}';
    var response = await ApiServices.getMethodTruckWithBody(
        feedUrl: ApiUrls.GET_PAYMENT_EVIDENCE, body: body);
    if (response.isEmpty) return false;
    getPaymentEvidenceResponse = getPaymentEvidenceResponseFromJson(response);
    paymentEvidenceUrl = getPaymentEvidenceResponse!.filePath.toString();

    notifyListeners();
    return true;
  }


}
