import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sultan_cab/utils/commons.dart';
import 'package:webview_flutter/webview_flutter.dart';

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

  late final WebViewController controller;

  _PaymentWebViewState(this.initUrl);

  @override
  void initState() {
    print("URL: ${this.initUrl}");

    // #docregion webview_controller
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String value) {},
          onPageFinished: (String value) {
            logger.e(value.toString());
            if (value.toString().contains("message=APPROVED") ||
                value.toString().contains("status=success") ||
                value.toString().contains("status=authorized") ||
                value.toString().contains("status=paid") ||
                value.toString().contains("message=Succeeded")) {
              if (x == 0) {
                Get.back(result: true);
              }
              ++x;
            } else {
              print("Fool");
            }
          },
          onWebResourceError: (WebResourceError error) {
            print(error);
          },
          onNavigationRequest: (NavigationRequest request) {
            // if (request.url.startsWith('https://www.youtube.com/')) {
            //   return NavigationDecision.prevent;
            // }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(this.initUrl ?? "google.com"));
    // #enddocregion webview_controller
    super.initState();
  }

  int x = 0;

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
          title: Text(
            "Payment".tr,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
        ),
        body: WebViewWidget(controller: controller));
  }
}
