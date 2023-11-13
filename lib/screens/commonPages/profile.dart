import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sultan_cab/providers/auth_provider.dart';
import 'package:sultan_cab/utils/colors.dart';
import 'package:sultan_cab/utils/sizeConfig.dart';
import 'package:sultan_cab/utils/strings.dart';
import 'package:sultan_cab/widgets/app_button.dart';
import 'package:sultan_cab/widgets/app_text_field.dart';

import '../../models/registration/userRegResponse.dart';
import '../../services/apiServices/StorageServices/get_storage.dart';
import '../../services/apiServices/api_urls.dart';

class ProfileScreen extends StatefulWidget {
  final bool? isBooking;

  ProfileScreen({Key? key, @required this.isBooking}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController phoneController = TextEditingController();

  bool isRead = true;

  UserRegResponse? data;

  @override
  void initState() {
    super.initState();
    data = StorageCRUD.getUser();
    authProvider.nameController.text = data!.name!;
    phoneController.text = data!.phoneNumber.toString();
  }

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Gradient buttonGradient = LinearGradient(
    colors: [greybackColor, greybackColor],
  );

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var h = SizeConfig.screenHeight / 812;
    var b = SizeConfig.screenWidth / 375;

    return Scaffold(
      backgroundColor: greybackColor,
      appBar: Get.width < 700
          ? AppBar(
              backgroundColor: secondaryColor,
              centerTitle: true,
              elevation: 0,
              leading: Align(
                alignment: Alignment.centerLeft,
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: h * 22,
                      horizontal: b * 20,
                    ),
                    child: Icon(
                      Icons.arrow_back_ios_new_rounded,
                      size: h * 18,
                      color: secondaryColor,
                    ),
                  ),
                ),
              ),
              title: Text(
                ProfileLabel,
                style: TextStyle(
                    fontSize: h * 18,
                    fontWeight: FontWeight.w700,
                    color: secondaryColor),
              ),
              flexibleSpace: Container(
                decoration: BoxDecoration(
                  gradient: buttonGradient,
                ),
              ),
            )
          : AppBar(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              leading: Container(),
            ),
      body: Row(
        children: [
          if (Get.width > 700) Expanded(flex: 2, child: Container()),
          Expanded(
            flex: 7,
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    physics: ClampingScrollPhysics(),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          sh(41),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: b * 25),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AppTextField(
                                    label: FullName,
                                    readOnly: isRead,
                                    controller: authProvider.nameController,
                                    suffix: null,
                                    size: h * 12,
                                    spacing: 0.6,
                                    isVisibilty: null,
                                    validator: (val) {
                                      if (authProvider.nameController.text
                                              .trim() ==
                                          "")
                                        return FieldEmptyError;
                                      else
                                        return null;
                                    },
                                  ),
                                  sh(20),
                                  AppTextField(
                                    label: PhoneNoLabel,
                                    readOnly: true,
                                    controller: phoneController,
                                    suffix: null,
                                    size: h * 12,
                                    spacing: 0.6,
                                    isVisibilty: null,
                                    validator: (val) {
                                      if (authProvider.nameController.text
                                              .trim() ==
                                          "")
                                        return FieldEmptyError;
                                      else
                                        return null;
                                    },
                                  ),
                                ]),
                          ),
                          sh(20),
                          !isRead
                              ? Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: b * 25),
                                  child: AppButton(
                                    label: widget.isBooking!
                                        ? ContinueLabel
                                        : SaveLabel,
                                    onPressed: () async {
                                      FocusScope.of(context).unfocus();
                                      bool result =
                                          await authProvider.updateProfile();

                                      if (result) {}
                                    },
                                  ),
                                )
                              : sh(0),
                          sh(40),
                          if (!GetPlatform.isWeb)
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 25),
                              child: InkWell(
                                onTap: () {
                                  showDeleteConfirmationDialog(context);
                                },
                                child: Container(
                                  height: 56,
                                  width: Get.width,
                                  decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Center(
                                    child: Text(
                                      "Delete account".tr,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          if (Get.width > 700) Expanded(flex: 2, child: Container()),
        ],
      ),
    );
  }

  Widget userDP({
    XFile? xFile,
    String? dpUrl,
  }) {
    return GestureDetector(
      onTap: () async {
        if (!isRead) {
          await authProvider.getDpImage();
          setState(() {});
        }
      },
      child: CircleAvatar(
        radius: 55,
        child: xFile != null
            ? CircleAvatar(
                radius: 55,
                backgroundImage: FileImage(
                  File(
                    xFile.path,
                  ),
                ),
              )
            : CachedNetworkImage(
                imageUrl: "${ApiUrls.BASE_URL_TRUCK}${data!.email}",
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                        colorFilter:
                            ColorFilter.mode(Colors.red, BlendMode.colorBurn)),
                  ),
                ),
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
        backgroundColor: Colors.grey,
      ),
    );
  }

  void showDeleteConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Account'.tr),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Are you sure you want to delete your account?'.tr,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text('This action will delete all your data and settings.'.tr),
              SizedBox(height: 10),
              Text(
                  'You will need to create a new account if you wish to come back.'
                      .tr),
              SizedBox(height: 10),
              Text(
                'Please note that this will perform a hard delete from our database, and no information will remain stored in our system.'
                    .tr,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Cancel'.tr),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: ElevatedButton(
                onPressed: () async {
                  Navigator.of(context).pop();
                  await authProvider.deleteAccount();
                },
                child: Text('Delete Account'.tr),
              ),
            ),
          ],
        );
      },
    );
  }
}
