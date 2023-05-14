import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sultan_cab/utils/colors.dart';
import 'package:sultan_cab/widgets/app_button.dart';

class AppWidgets {
  static Future<String> chooseImageSource() async {
    String value = "";
    await Get.bottomSheet(
      Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: Get.width * .9,
                  child: AppButton(
                    onPressed: () {
                      value = "Camera";

                      if (Get.isBottomSheetOpen!) Get.back();
                      return value;
                    },
                    label: 'Camera',
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: Get.width * .9,
                  child: AppButton(
                    onPressed: () {
                      value = "Gallery";
                      if (Get.isBottomSheetOpen!) Get.back();
                      return value;
                    },
                    label: "Gallery",
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          SizedBox(
            width: Get.width * .9,
            child: AppButton(
              onPressed: () {
                value = "";
                if (Get.isBottomSheetOpen!) Get.back();
                return value;
              },
              label: "Cancel",
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
      enableDrag: true,
      isDismissible: false,
    );
    return value;
  }

  static Widget dpImageFile({VoidCallback? onTap, XFile? xFile}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 100,
        width: 100,
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(width: 2, color: primaryColor),
            borderRadius: BorderRadius.circular(100)),
        child: Padding(
          padding: const EdgeInsets.all(2),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(100),
              image: xFile != null
                  ? DecorationImage(
                      image: FileImage(
                        File(xFile.path),
                      ),
                      fit: BoxFit.cover,
                    )
                  : null,
            ),
          ),
        ),
      ),
    );
  }

  static Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();
  }
}




class LinearGradientButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const LinearGradientButton({
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF35B66D),
              Color(0xFFF1E41B)],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0,bottom: 8,left: 12,right: 12),
            child: Text(
              text,
              style: TextStyle(
                color: Colors.black,
                fontSize: 16.0,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
