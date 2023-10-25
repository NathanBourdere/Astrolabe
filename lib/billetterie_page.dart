import 'package:festival/navbar.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class BilletteriePage extends StatefulWidget {
  const BilletteriePage({Key? key}) : super(key: key);

  @override
  State<BilletteriePage> createState() => _BilletteriePageState();
}

class _BilletteriePageState extends State<BilletteriePage> {
  WebViewController? _webViewController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Billetterie'),
      ),
      drawer: const NavBar(),
      body: WebView(
        initialUrl: 'https://www.hoppophop.fr/billetterie/',
        onWebViewCreated: (controller) {
          _webViewController = controller;
        },
        navigationDelegate: (NavigationRequest request) {
          if (request.isForMainFrame) {
            return NavigationDecision.navigate;
          }
          return NavigationDecision.prevent;
        },
      ),
    );
  }
}
