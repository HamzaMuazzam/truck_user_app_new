// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:thrifty_cab/providers/auth_provider.dart';
// import 'package:thrifty_cab/utils/appBar.dart';
// import 'package:thrifty_cab/utils/sizeConfig.dart';
// import 'package:thrifty_cab/utils/strings.dart';
// import 'package:thrifty_cab/widgets/app_text_field.dart';
//
// class ChangePassword extends StatefulWidget {
//   @override
//   State<ChangePassword> createState() => _ChangePasswordState();
// }
//
// class _ChangePasswordState extends State<ChangePassword> {
//   late AuthProvider authProvider;
//   bool isError = false;
//   bool isError1 = false;
//   bool isError2 = false;
//
//   bool isMisMatch = false;
//   GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//
//   @override
//   void initState() {
//     authProvider = Provider.of<AuthProvider>(context, listen: false);
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     SizeConfig().init(context);
//     var h = SizeConfig.screenHeight / 812;
//     var b = SizeConfig.screenWidth / 375;
//
//     return Scaffold(
//       appBar: appBarCommon(context, h, b, ChangePassLabel),
//       body: Column(children: [
//         Expanded(
//           child: Container(
//             color: Colors.white,
//             child: SingleChildScrollView(
//               padding: EdgeInsets.symmetric(horizontal: b * 15),
//               physics: BouncingScrollPhysics(),
//               child: Form(
//                 key: _formKey,
//                 child: Column(
//                   children: [
//                     sh(40),
//                     Image.asset(
//                       'assets/images/change_pass.png',
//                       height: h * 165,
//                       width: b * 142,
//                     ),
//                     Container(
//                       width: SizeConfig.screenWidth,
//                       margin: EdgeInsets.only(top: h * 20),
//                       padding: EdgeInsets.fromLTRB(b * 15, h * 20, b * 15, h * 20),
//                       child: Column(
//                         children: [
//                           sh(20),
//                           AppTextFieldPassword(
//                             label: CurPassLabel,
//                             controller: TextEditingController(),
//                             isMisMatch: false,
//                             error: isError2,
//                             // validator: (val) {
//                             //   if (authProvider.curPwdController.text.trim() == "") {
//                             //     setState(() {
//                             //       isError2 = true;
//                             //     });
//                             //     return FieldEmptyError;
//                             //   } else {
//                             //     setState(() {
//                             //       isError = false;
//                             //     });
//                             //     return null;
//                             //   }
//                             // },
//                           ),
//                           sh(20),
//                           AppTextFieldPassword(
//                             label: NewPassword,
//                             controller: TextEditingController(),
//                             isMisMatch: isMisMatch,
//                             error: isError,
//                             // validator: (val) {
//                             //   if (authProvider.newPwdController.text.trim() == "") {
//                             //     setState(() {
//                             //       isMisMatch = false;
//                             //       isError = true;
//                             //     });
//                             //     return FieldEmptyError;
//                             //   } else if (authProvider.confPwdController.text !=
//                             //       authProvider.newPwdController.text) {
//                             //     setState(() {
//                             //       isMisMatch = true;
//                             //       isError = true;
//                             //     });
//                             //     return PasswordMatchError;
//                             //   } else {
//                             //     setState(() {
//                             //       isError = false;
//                             //       isMisMatch = false;
//                             //     });
//                             //     return null;
//                             //   }
//                             // },
//                           ),
//                           sh(20),
//                           AppTextFieldPassword(
//                             label: CnfmPasswordLabel,
//                             isMisMatch: isMisMatch,
//                             controller: TextEditingController(),
//                             error: isError1,
//                             // validator: (val) {
//                             //   if (authProvider.confPwdController.text.trim() == "") {
//                             //     setState(() {
//                             //       isError1 = true;
//                             //       isMisMatch = false;
//                             //     });
//                             //     return FieldEmptyError;
//                             //   } else if (authProvider.confPwdController.text !=
//                             //       authProvider.newPwdController.text) {
//                             //     setState(() {
//                             //       isMisMatch = true;
//                             //       isError1 = true;
//                             //     });
//                             //     return PasswordMatchError;
//                             //   } else {
//                             //     setState(() {
//                             //       isMisMatch = false;
//                             //       isError1 = false;
//                             //     });
//                             //     return null;
//                             //   }
//                             // },
//                           ),
//                           sh(30),
//                           // AppButton(
//                           //   label: ChangePassLabel.toUpperCase(),
//                           //   onPressed: () async {
//                           //     if (!_formKey.currentState!.validate()) return;
//                           //     if (authProvider.newPwdController.text.trim().length < 8 ||
//                           //         authProvider.newPwdController.text.trim().length > 14) {
//                           //       appSnackBar(
//                           //         context: context,
//                           //         msg: PasswordLengthErrorLabel,
//                           //         isError: true,
//                           //       );
//                           //     } else {
//                           //       bool status =
//                           //           await Provider.of<AuthProvider>(context, listen: false)
//                           //               .changePassword();
//                           //
//                           //       if (status) {
//                           //         authProvider.disposeControllers();
//                           //         Navigator.pop(context);
//                           //       }
//                           //     }
//                           //   },
//                           // ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ]),
//     );
//   }
// }
