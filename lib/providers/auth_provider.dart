import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:sultan_cab/models/UserModel/user_model.dart';
import 'package:sultan_cab/screens/commonPages/phone_verify.dart';
import 'package:sultan_cab/utils/commons.dart';
import 'package:sultan_cab/utils/const.dart';
import 'package:sultan_cab/widgets/app_widgets.dart';

import '../auth_widget.dart';
import '../models/registration/userRegResponse.dart';
import '../screens/TruckBooking/navigation_screen.dart';
import '../screens/commonPages/otp_verifications.dart';
import '../services/apiServices/StorageServices/get_storage.dart';
import '../services/apiServices/api_services.dart';
import '../services/apiServices/api_urls.dart';

AuthProvider authProvider = Provider.of(Get.context!, listen: false);

class AuthProvider extends ChangeNotifier {
  TextEditingController nameController = TextEditingController();
  TextEditingController companyCR = TextEditingController();
  TextEditingController companyContact = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController pinPutController = TextEditingController();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  // TextEditingController emailController = TextEditingController(text: "hamzamuazzam1011@gmail.com");
  // TextEditingController passwordController = TextEditingController(text: 'Power\$321');
  TextEditingController password2Controller = TextEditingController();
  UserCredential? userCredential;
  UserAuthModel? userAuthModel;
  FirebaseAuth fireAuth = FirebaseAuth.instance;
  String? verificationId;
  String? otpPin;
  String? emailOtp;
  XFile? xFile;
  bool isSocialLogin = false;

  void disposeController() {
    nameController.clear();
    phoneController.clear();
    pinPutController.clear();
    companyCR.clear();
    companyContact.clear();
    password2Controller.clear();
    passwordController.clear();
    emailController.clear();
    verificationId = '';
    userCredential = null;
  }

  bool checkUser() {
    return StorageCRUD.box.hasData(StorageKeys.userData);
  }

  // void mobileSignIn() async {
  //   if (phoneController.text.isNotEmpty) {
  //     await otpSend(phoneNumber: phoneController.text);
  //   } else {
  //     AppConst.errorSnackBar('Empty fields');
  //   }
  // }

  Future<bool> signInWithMobile() async {
    Map<String, String> fields = {
      'name': phoneController.text,
      'loginId': phoneController.text,
      'isSocialLogin': 'true',
      'socialType': 'PHONE',
      'isActive': 'true',
      'userType': 'Rider'
    };

    return await signUp(fields: fields, files: null);
  }

  Future<bool> signUp(
      {required Map<String, String> fields, String? files}) async {
    String response = await ApiServices.postMethod(
      fields: fields,
      feedUrl: ApiUrls.CREATE_ACCOUNT,
      files: files,
      forSignInSignUp: true,
    );
    if (response.isEmpty) return false;
    userAuthModel = userAuthModelFromJson(response);
    await AppConst.successSnackBar(userAuthModel!.message.toString());
    await StorageCRUD.saveUser(response);
    disposeController();
    gotoPage(NavigationScreen(), isClosePrevious: true);
    return true;
  }

  gotoPage(Widget widget,
      {Transition transition: Transition.native,
      Duration duration: const Duration(seconds: 1),
      bool isClosePrevious: false}) {
    if (isClosePrevious) {
      Get.offAll(() => widget, transition: transition, duration: duration);
    } else {
      Get.to(() => widget, transition: transition, duration: duration);
    }
  }

  Future<void> otpSend({
    required String phoneNumber,
  }) async {
    AppConst.startProgress();
    try {
      await fireAuth.verifyPhoneNumber(
          timeout: const Duration(seconds: 60),
          phoneNumber: phoneNumber,
          verificationCompleted: (PhoneAuthCredential credential) async {
            AppConst.stopProgress();
            AppConst.errorSnackBar("Verification completed".tr);
          },
          verificationFailed: (FirebaseAuthException exception) async {
            AppConst.stopProgress();
            logger.e(exception.message);
            AppConst.errorSnackBar("Verification Failed ${exception.message}");
            return;
          },
          codeSent: (String verificationId, int? resendToken) async {
            AppConst.stopProgress();
            AppConst.successSnackBar("Code Sent".tr);
            this.verificationId = verificationId;
            // dialogBoxOtp(Get.context!);
            Get.to(() => VerifyPhoneNumberScreen(
                phoneNumber: authProvider.phoneController.text));
            notifyListeners();
          },
          codeAutoRetrievalTimeout: (String verificationId) async {});
    } catch (e) {
      logger.e(e.toString());
      AppConst.errorSnackBar(e.toString());

      AppConst.stopProgress();
    }
  }

  Future<bool> verifyPhone() async {
    AppConst.startProgress();
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: this.verificationId!, smsCode: pinPutController.text);

    await fireAuth.signInWithCredential(credential);

    if (credential.verificationId!.isEmpty) {
      AppConst.stopProgress();
      return false;
    } else {
      await signInWithMobile();
      AppConst.stopProgress();
      AppConst.successSnackBar("Logged In".tr);
      return true;
    }
  }

  Future<bool> updateProfile() async {
    AppConst.startProgress();
    Map<String, String>? fields;
    if (nameController.text.isNotEmpty)
      fields = {
        'userId': StorageCRUD.getUser().id.toString(),
        'loginId': StorageCRUD.getUser().userLogins.toString(),
        "name": nameController.text,
      };

    String response = await ApiServices.postMethod(
        feedUrl: ApiUrls.UPDATE_PROFILE, files: xFile?.path, fields: fields);
    AppConst.stopProgress();

    if (response.isEmpty) return false;

    logger.i(response);
    await StorageCRUD.saveUser(response);

    return true;
  }

  Future<bool> logout() async {
    try {
      var instance = FirebaseMessaging.instance;
      try {
        await instance.unsubscribeFromTopic("AllUsers");
        await instance
            .unsubscribeFromTopic(StorageCRUD.getUser().id.toString());
      } catch (e) {
        logger.e(e);
      }
      await StorageCRUD.erase();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> getDpImage() async {
    ImagePicker picker = ImagePicker();
    xFile == null;
    notifyListeners();
    String choice = await AppWidgets.chooseImageSource();
    if (choice == "Camera") {
      xFile =
          await picker.pickImage(source: ImageSource.camera, imageQuality: 50);
    } else if (choice == "Gallery") {
      xFile =
          await picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
    }
    notifyListeners();
  }

  void disposeControllers() {
    nameController.clear();
    phoneController.clear();
  }

  UserRegResponse? userRegResponse;

  Future<bool> userRegistration() async {
    Map<String, String> body = {
      'Name': "${nameController.text}",
      'Email': "${emailController.text}",
      'PhoneNumber': "${phoneController.text}",
      'Password': "${passwordController.text}",
      'CompanyContact': "${companyContact.text}",
      'CompanyCR': "${companyCR.text}",
    };
    AppConst.startProgress();

    String request = await ApiServices.postMethodTruck(
        feedUrl: ApiUrls.REGISTRATION, body: json.encode(body));

    if (request.isEmpty) return false;

    AppConst.successSnackBar('user registered'.tr);
    await StorageCRUD.saveUser(request);
    gotoPage(NavigationScreen(), isClosePrevious: true);
    return true;
  }

  //TODO
  Future<bool> registrationFormValidation() async {
    if (nameController.text.isEmpty ||
        passwordController.text.isEmpty ||
        emailController.text.isEmpty ||
        phoneController.text.isEmpty ||
        companyCR.text.isEmpty ||
        companyContact.text.isEmpty) {
      AppConst.errorSnackBar('Something is missing..'.tr);
      return false;
    }

    // if(isPasswordCompliant(passwordController.text.trim())){
    // }else{
    //   AppConst.errorSnackBar("Password must contain digit, capital, small and special character.");
    //   return false;
    // }

    if (password2Controller.text != passwordController.text) {
      AppConst.errorSnackBar("password doesn't match..".tr);
      return false;
    }

    if (!passwordController.text.isValidPassword()) {
      AppConst.errorSnackBar(
          "Password must contain at least 1 special character, 1 numeric value, 1 upper case and 1 lower case."
              .tr);
      return false;
    }
    if (passwordController.text.length < 8) {
      AppConst.errorSnackBar("Password should not be less than 8 digits.".tr);
      return false;
    }

    await userRegistration();
    return true;
  }

  Future<bool> userLogin() async {
    AppConst.startProgress();
    String body = json.encode({
      "email": emailController.text,
      "Password".tr: passwordController.text
    });

    String request =
        await ApiServices.postMethodTruck(feedUrl: ApiUrls.LOGIN, body: body);
    if (request.isEmpty) {
      AppConst.errorSnackBar('user name/password is invalid'.tr);
      logger.i('user name/password is invalid');
      return false;
    }

    AppConst.successSnackBar('Logged In'.tr);
    await StorageCRUD.saveUser(request);
    logger.i(StorageCRUD.getUser());
    gotoPage(NavigationScreen(), isClosePrevious: true);
    disposeController();
    return true;
  }

  Future<bool> loginFormValidation() async {
    if (passwordController.text.isEmpty || emailController.text.isEmpty) {
      AppConst.errorSnackBar('Something is missing..'.tr);
      return false;
    } else {}
    await userLogin();
    return true;
  }

  Future<bool> deleteAccount() async {
    AppConst.startProgress();

    var request = http.Request(
        'POST',
        Uri.parse(
            'https://apitruck.deeps.info/api/Accounts/delete-user?id=${StorageCRUD.getUser().id}'));

    http.StreamedResponse response = await request.send();
    AppConst.stopProgress();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      await StorageCRUD.erase();
      gotoPage(AuthWidget(), isClosePrevious: true);
      disposeController();
      return true;
    } else {
      print(response.reasonPhrase);
      return false;
    }
  }
}
