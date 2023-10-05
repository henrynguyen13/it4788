import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Policy extends StatefulWidget {
  const Policy({super.key});

  @override
  State<Policy> createState() => _Policy();
}

class _Policy extends State<Policy> {
  late final WebViewController controller;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..loadRequest(
        Uri.parse('https://www.facebook.com/legal/terms'),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chính sách'),
      ),
      body: WebViewWidget(
        controller: controller,
      ),
    );
  }
}
