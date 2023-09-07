import 'package:flutter/material.dart';
import 'package:get/get.dart';

// import 'package:flutter_inappwebview/flutter_inappwebview.dart' as web;
import 'package:sultan_cab/utils/commons.dart';
import 'package:webviewx/webviewx.dart';


class PaymentWebView extends StatefulWidget {
  String? initUrl;

  PaymentWebView({Key? key, required this.initUrl}) : super(key: key);

  @override
  _PaymentWebViewState createState() => _PaymentWebViewState(initUrl);
}

class _PaymentWebViewState extends State<PaymentWebView> {

  bool isLoading = true;
  String? initUrl;
  int progress = 0;

  _PaymentWebViewState(this.initUrl);

  @override
  void initState() {
    super.initState();
  }
int x=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            )),
        title: const Text(
          "Payment",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
      ),
      body: Builder(builder: (BuildContext context) {
        return Stack(
          children: <Widget>[

            WebViewX(
              initialContent: initUrl!,
              onPageStarted: (value){

              },
              onPageFinished: (value){

                    logger.e(value.toString());
                    if(value.toString().contains("message=APPROVED") || value.toString().contains("status=success") || value.toString().contains("status=authorized") || value.toString().contains("status=paid")|| value.toString().contains("message=Succeeded")) {
                      if(x==0){
                      Get.back(result: true);
                     }
                      ++x;
                    }
                    else{
                      print("Fool");
                    }
              },

              initialSourceType: SourceType.url,
              onWebViewCreated: (controller) {

              },
              width: Get.width,
              height: Get.height,
            ),


          ],
        );
      }),
    );
  }


}