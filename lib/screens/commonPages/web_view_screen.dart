import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart' as web;
import 'package:sultan_cab/utils/commons.dart';


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
            web.InAppWebView(
              initialUrlRequest: web.URLRequest(url: Uri.parse(initUrl!)),
            onLoadStop: (controller,uri) async {

                logger.e(uri.toString());
                if(uri.toString().contains("status=success") || uri.toString().contains("status=paid")) {
                  Get.back(result: true);
                }
                setState(() {
                  isLoading = false;
                });
            },
            ),
            isLoading
                ? Center(
                child: CircularProgressIndicator())
                : Stack()
          ],
        );
      }),
    );
  }


}