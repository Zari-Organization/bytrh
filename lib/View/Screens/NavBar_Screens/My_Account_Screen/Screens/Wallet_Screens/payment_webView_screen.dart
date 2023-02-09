import 'dart:developer';

import 'package:bytrh/Utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../../../Logic/controllers/Wallet_Controllers/wallet_controllers.dart';
import '../../../../../../Utils/app_alerts.dart';

class PaymentWebViewScreen extends StatefulWidget {
  const PaymentWebViewScreen({super.key, required this.PaymentURL});

  final PaymentURL;

  @override
  State<PaymentWebViewScreen> createState() => _PaymentWebViewScreenState();
}

class _PaymentWebViewScreenState extends State<PaymentWebViewScreen> {
  late final WebViewController controller;
  var loadingPercentage = 0;
  var currentUrl = '';
  final walletController = Get.find<WalletController>();

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (progress) {
            setState(() {
              loadingPercentage = progress;
            });
          },
          onPageStarted: (String url) {
            setState(() {
              loadingPercentage = 0;
              currentUrl = url;
              log("web page url --> $currentUrl");
              const start = "https://";
              const end = "/api";
              final startIndex = currentUrl.indexOf(start);
              final endIndex =
                  currentUrl.indexOf(end, startIndex + start.length);
              final result =
                  currentUrl.substring(startIndex + start.length, endIndex);
              log("currentUrl.split --> $result");
              if (result == "bytrh.com") {
                log("YES");
                walletController.walletPaymentStatus(context);
              }
            });
          },
          onPageFinished: (url) {
            setState(() {
              loadingPercentage = 100;
            });
          },
          onWebResourceError: (WebResourceError error) {},
          // onNavigationRequest: (NavigationRequest request) {
          //   if (request.url.startsWith('https://www.youtube.com/')) {
          //     return NavigationDecision.prevent;
          //   }
          //   return NavigationDecision.navigate;
          // },
        ),
      )
      ..loadRequest(Uri.parse(widget.PaymentURL));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.MAIN_COLOR,
        title: const Text('الدفع'),
        centerTitle: true,
      ),
      body: WillPopScope(
        onWillPop: () => AppAlerts().onPaymentPop()!,
        child: Stack(
          children: [
            WebViewWidget(
              controller: controller,
            ),
            if (loadingPercentage < 100)
              LinearProgressIndicator(
                value: loadingPercentage / 100.0,

              ),
          ],
        ),
      ),
    );
  }
}
