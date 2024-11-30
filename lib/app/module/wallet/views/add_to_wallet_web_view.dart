
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taxi_app/app/data/common/common_variables.dart';
import 'package:taxi_app/app/module/wallet/controller/wallet_controller.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class AddToWalletWebView extends GetView<WalletController> {
    AddToWalletWebView({super.key});
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
      String url = 'https://api.faster.sa:5000/MoayserPayment/WalletDepositPay?token=${CommonVariables.userData.read("token")}&amount=${controller.amountToAdd.value}';

      // late WebViewController webViewController;
      return Scaffold(
        backgroundColor: Colors.white,
        body:InAppWebView(
          initialUrlRequest: URLRequest(
            url: WebUri(url), // Use WebUri for compatibility
          ),
          onWebViewCreated: (controller) {
            webViewController = controller;
            // Inject JavaScript to capture form submissions and other interactions
            controller.evaluateJavascript(source: """
            (function() {
              // Function to handle form submissions and XHR requests
              function handleFormSubmission(event) {
                event.preventDefault(); // Prevent default form submission
                var formData = new FormData(event.target);
                fetch(event.target.action, {
                  method: event.target.method,
                  body: formData,
                })
                .then(response => {
                  window.flutter_inappwebview.callHandler('handleResponse', response.status, response.url);
                })
                .catch(error => {
                  window.flutter_inappwebview.callHandler('handleResponse', 0, ''); // Error case
                });
              }

              // Attach form submission handler
              document.addEventListener('submit', handleFormSubmission, true);
            })();
          """);

            // Add JavaScript handler for form submissions and XHR responses
            controller.addJavaScriptHandler(
                handlerName: 'handleResponse',
                callback: (args) {
                  int statusCode = args[0];
                  String responseUrl = args[1];
                  print('Response URL: $responseUrl, Status Code: $statusCode');
                  if (statusCode == 200) {
                    Get.snackbar('Success', 'Request succeeded with status code 200.');
                  } else {
                    Get.snackbar('Error', 'Request failed with status code $statusCode.');
                  }
                }
            );
          },
          onLoadStart: (controller, url) {
            showLoadingDialog();
          },
          onLoadStop: (controller, url) async {
            dismissLoadingDialog();
          },
          onLoadError: (controller, url, code, message) {
            dismissLoadingDialog();
            Get.snackbar('Error', 'Failed to load page: $message');
          },
          onLoadHttpError: (controller, url, statusCode, description) {
            dismissLoadingDialog();
            Get.snackbar('Error', 'HTTP error: $statusCode - $description');
          },
          shouldInterceptRequest: (controller, request) async {
            // Log all HTTP requests
            print('Intercepted request to: ${request.url}');
            return null; // Proceed with the original request
          },
          onReceivedServerTrustAuthRequest: (controller, challenge) async {
            // Handle SSL/TLS certificate challenges
            return ServerTrustAuthResponse(action: ServerTrustAuthResponseAction.PROCEED);
          },
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
