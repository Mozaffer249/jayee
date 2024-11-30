import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:taxi_app/app/data/common/common_variables.dart';
import 'package:taxi_app/app/module/wallet/controller/wallet_controller.dart';

class SavePaymentCardView extends GetView<WalletController> {
  SavePaymentCardView({super.key});
  final GlobalKey webViewKey = GlobalKey();
  InAppWebViewSettings settings = InAppWebViewSettings(
      isInspectable: kDebugMode,
      mediaPlaybackRequiresUserGesture: false,
      allowsInlineMediaPlayback: true,
      iframeAllow: "camera; microphone",
      iframeAllowFullscreen: true);
  PullToRefreshController? pullToRefreshController;
  InAppWebViewController? webViewController;
  @override
  Widget build(BuildContext context) {
    String url = 'https://api.faster.sa:5000/MoayserPayment/SaveCards?token=${CommonVariables.userData.read("token")}';
    // late WebViewController webViewController;
    return  Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.only(top: 20),
        child: InAppWebView(
          initialUrlRequest: URLRequest(
            url: WebUri(url), // Use WebUri for compatibility with InAppWebView
          ),
          onWebViewCreated: (controller) {
            webViewController = controller;
          },
        ),
      ),
    );
  }
    // Function to show the progress/loading dialog
    void showLoadingDialog() {
      if (!Get.isDialogOpen!) {
        Get.dialog(
          Center(child: CircularProgressIndicator()),
          barrierDismissible: false, // Prevent dismissing the dialog by tapping outside
        );
      }
    }

    // Function to dismiss the progress/loading dialog
    void dismissLoadingDialog() {
      if (Get.isDialogOpen!) {
        Get.back(); // Close the dialog
      }
    }

}
