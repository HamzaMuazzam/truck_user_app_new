import 'package:firebase_phone_auth_handler/firebase_phone_auth_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/route_manager.dart';
// import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:sultan_cab/providers/auth_provider.dart';
import 'package:sultan_cab/utils/colors.dart';
import 'package:sultan_cab/utils/commons.dart';
import 'package:sultan_cab/utils/const.dart';

/// 03244748112
class VerifyPhoneNumberScreen extends StatefulWidget {
  static const id = 'VerifyPhoneNumberScreen';

  final String phoneNumber;

  const VerifyPhoneNumberScreen({Key? key, required this.phoneNumber}) : super(key: key);

  @override
  State<VerifyPhoneNumberScreen> createState() => _VerifyPhoneNumberScreenState();
}

class _VerifyPhoneNumberScreenState extends State<VerifyPhoneNumberScreen>
    with WidgetsBindingObserver {
  bool isKeyboardVisible = false;
  bool isAnyException = false;

  final ScrollController scrollController = ScrollController();
  final TextEditingController otpCtrl = TextEditingController();

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    // FirebasePhoneAuthHandler.signOut(context);
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    final bottomViewInsets = WidgetsBinding.instance.window.viewInsets.bottom;
    isKeyboardVisible = bottomViewInsets > 0;
  }

  @override
  Widget build(BuildContext context) {
    return FirebasePhoneAuthProvider(
      child: FirebasePhoneAuthHandler(
        signOutOnSuccessfulVerification: false,
        otpExpirationDuration: Duration(seconds: 60),
        phoneNumber: widget.phoneNumber,
        onLoginSuccess: (userCredential, autoVerified) async {
          logger.i(autoVerified);
          // await authProvider.signInWithMobile();
          await authProvider.userRegistration();
          logger.i(
            '${VerifyPhoneNumberScreen.id},\n${autoVerified ? 'OTP was fetched automatically!' : 'OTP was verified manually!'}',
          );

          AppConst.successSnackBar('Phone number verified successfully!');

          logger.d(
            ' h${VerifyPhoneNumberScreen.id},\nLogin Success UID: '
                '${userCredential.user?.uid}',
          );

          Get.back(result: true);
        },
        onError: (_obj, _stacktrace) {
          logger.i('Object onError => $_obj');
          logger.i('StackTrace onError => $_stacktrace');
        },
        onCodeSent: () {
          logger.wtf('on code sent function executed.');
        },
        autoRetrievalTimeOutDuration: const Duration(minutes: 1),
        onLoginFailed: (FirebaseAuthException exception, StackTrace? trace) {
          AppConst.errorSnackBar('${exception.message}');
          setState(() {
            isAnyException = true;
          });
        },
        builder: (context, controller) {
          return Scaffold(
            // backgroundColor: Colors.white,
            appBar: AppBar(
              elevation: 0,
              title: const Text('Verify Phone Number'),
              leading: InkWell(onTap: (){
                Get.back();
              },child: Icon(Icons.arrow_back_ios,color: secondaryColor,)),


              actions: [
                // Resend OTP code button
                if (controller.codeSent)
                  TextButton(
                    child: Text(
                      controller.isListeningForOtpAutoRetrieve
                          ? '${controller.autoRetrievalTimeLeft.inSeconds}s'
                          : 'Resend',
                      style: const TextStyle(color: Colors.blue, fontSize: 18),
                    ),
                    onPressed: controller.isListeningForOtpAutoRetrieve
                        ? null
                        : () async {
                            // log(VerifyPhoneNumberScreen.id, msg: 'Resend OTP');
                            await controller.sendOTP();
                          },
                  ),
                const SizedBox(width: 5),
              ],
            ),
            body: controller.codeSent
                ? ListView(
                    padding: const EdgeInsets.all(20),
                    controller: scrollController,
                    children: [
                      Text(
                        "We've sent an SMS with a verification code to ${widget.phoneNumber}",
                        style: const TextStyle(fontSize: 25, color: textColor),
                      ),
                      const SizedBox(height: 10),
                      const Divider(),
                      if (controller.isListeningForOtpAutoRetrieve)
                        Column(
                          children: [
                            const SizedBox(height: 40),
                            const Text(
                              'Listening for OTP',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w600,
                                color: textColor,
                              ),
                            ),
                            const SizedBox(height: 15),
                          ],
                        ),
                      const SizedBox(height: 15),
                      const Text(
                        'Enter OTP',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: textColor,
                        ),
                      ),
                      const SizedBox(height: 15),
                      // PinCodeTextField(
                      //   appContext: context,
                      //   length: 6,
                      //   // onFocusChange: (hasFocus) async {
                      //   //   if (hasFocus) await _scrollToBottomOnKeyboardOpen();
                      //   // },
                      //   // onSubmit: (enteredOTP) async {
                      //   //   final isValidOTP = await controller.verifyOTP(
                      //   //     otp: enteredOTP,
                      //   //   );
                      //   //   // Incorrect OTP
                      //   //   if (!isValidOTP) {
                      //   //     Get.snackbar('', 'The entered OTP is invalid!');
                      //   //   }
                      //   // },
                      //   showCursor: false,
                      //   animationType: AnimationType.scale,
                      //   pinTheme: PinTheme(
                      //     inactiveColor:secondaryColor,
                      //     shape: PinCodeFieldShape.box,
                      //     selectedColor: secondaryColor,
                      //     activeColor: secondaryColor,
                      //     // inactiveColor: ColorRes.COLOR_PRIMARY.withOpacity(0.3),
                      //     borderRadius: const BorderRadius.all(Radius.circular(5)),
                      //   ),
                      //   // textStyle: theme.style25W800.copyWith(fontSize: 30, fontWeight: FontWeight.w600),
                      //   animationDuration: const Duration(milliseconds: 150),
                      //   useExternalAutoFillGroup: true,
                      //   useHapticFeedback: true,
                      //   textStyle: TextStyle(color: textColor),
                      //   keyboardType:
                      //       const TextInputType.numberWithOptions(decimal: true, signed: false),
                      //   inputFormatters: [
                      //     FilteringTextInputFormatter.allow(RegExp("[0-9]")),
                      //   ],
                      //   hapticFeedbackTypes: HapticFeedbackTypes.selection,
                      //   onCompleted: (enteredOTP) async {
                      //     debugPrint("Completed");
                      //     final isValidOTP = await controller.verifyOtp(enteredOTP);
                      //     // Incorrect OTP
                      //     if (!isValidOTP) {
                      //       AppConst.errorSnackBar(
                      //         'The entered OTP is invalid!',
                      //       );
                      //     }
                      //   },
                      //   onChanged: (_) {},
                      //   beforeTextPaste: (text) {
                      //     debugPrint("Allowing to paste $text");
                      //     return true;
                      //   },
                      // ),
                    ],
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      if (!isAnyException) const CircularProgressIndicator(),
                      const SizedBox(height: 40),
                      Center(
                        child: TextButton(
                          onPressed: isAnyException ? () => Get.back(result: false) : null,
                          child: Text(
                            isAnyException ? 'Try Again' : 'Sending OTP',
                            style: const TextStyle(fontSize: 25, color: secondaryColor),
                          ),
                        ),
                      ),
                    ],
                  ),
          );
        },
      ),
    );
  }
}
