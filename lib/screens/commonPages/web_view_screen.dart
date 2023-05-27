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
              initialUrlRequest: web.URLRequest(url: Uri.parse(initUrl!),
                headers: {
                'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/87.0.4280.88 Safari/537.36',
                },
              ),

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