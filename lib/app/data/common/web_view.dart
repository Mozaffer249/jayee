import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentWebView extends StatelessWidget {
  final String token;

  PaymentWebView({required this.token});

  @override
  Widget build(BuildContext context) {
    // Create a controller for the WebView
    late WebViewController webViewController;

    return Scaffold(
      appBar: AppBar(
        title: Text('Add Amount to Wallet'),
      ),
      body: WebView(
        initialUrl: 'https://api.faster.sa:5000/MoayserPayment/WalletDepositPay', // Replace with your actual URL
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController controller) {
          webViewController = controller;
          // Load the URL with headers
          webViewController.loadUrl(
            'https://api.faster.sa:5000/MoayserPayment/WalletDepositPa', // Replace with your actual URL
            headers: {
              'Authorization': 'Bearer $token', // Pass the token in the headers
              'Content-Type': 'application/json',
            },
          );
        },
        onPageFinished: (String url) {
          // Optional: Handle actions after the page has finished loading
          print('Page finished loading: $url');
        },
        onWebResourceError: (error) {
          // Handle errors in WebView
          Get.snackbar('Error', 'Failed to load payment page: ${error.description}');
        },
      ),
    );
  }
}
