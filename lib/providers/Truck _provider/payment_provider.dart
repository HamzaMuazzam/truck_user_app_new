import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:sultan_cab/models/Truck_models/get_payment_evidence_response.dart';
import 'package:sultan_cab/services/ApiServices/StorageServices/get_storage.dart';
import 'package:sultan_cab/services/ApiServices/api_urls.dart';
import 'package:sultan_cab/utils/commons.dart';
import 'package:sultan_cab/utils/const.dart';
import '../../services/apiServices/api_services.dart';
import '../../widgets/app_widgets.dart';
PaymentProvider paymentProvider= Provider.of<PaymentProvider>(Get.context!,
    listen: false);
class PaymentProvider extends ChangeNotifier{
 XFile? paymentFile;
Future<bool> uploadPaymentEvidence(String orderId)async{
  Map<String,String> fields={
    'UserId':StorageCRUD.getUser().id.toString(),
    'OrderId':orderId,
  };
  logger.e(paymentFile!.path.toString());
  String body =await ApiServices.multiPartPostMethodTruck(feed: ApiUrls
      .UPLOAD_PAYMENT_EVIDENCE, fields: fields,files: paymentFile!.path.toString(),
      fileName:
  'PaymentProof');
if(body.isEmpty)
  {
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
     paymentFile =
     await picker.pickImage(source: ImageSource.camera, imageQuality: 50);
     notifyListeners();
   } else if (choice == "Gallery") {
     paymentFile =
     await picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
     notifyListeners();
   }
   if(paymentFile!=null)
     {
       await uploadPaymentEvidence(orderId);
       // paymentFile == null;
     }
   logger.i(paymentFile!.path);
 }
String paymentEvidenceUrl='';
 GetPaymentEvidenceResponse? getPaymentEvidenceResponse;
 Future<bool>getPaymentEvidence(String orderId)async{
   AppConst.startProgress();
   paymentEvidenceUrl='';
  String body='?userId=${StorageCRUD.getUser().id}&orderId=${orderId}';
  var response= await ApiServices.getMethodTruckWithBody(feedUrl: ApiUrls
      .GET_PAYMENT_EVIDENCE, body: body);
  if(response.isEmpty) return false;
  getPaymentEvidenceResponse=getPaymentEvidenceResponseFromJson(response);
   paymentEvidenceUrl= getPaymentEvidenceResponse!.filePath.toString();


notifyListeners();
  return true;
 }
}