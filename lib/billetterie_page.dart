import 'package:festival/navbar.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class BilletteriePage extends StatefulWidget {
  const BilletteriePage({Key? key}) : super(key: key);

  @override
  State<BilletteriePage> createState() => _BilletteriePageState();
}

class _BilletteriePageState extends State<BilletteriePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Billetterie'),
      ),
      body: WebView(
        initialUrl: 'https://www.hoppophop.fr/billetterie/',
        onWebViewCreated: (controller) {},
        javascriptMode: JavascriptMode.unrestricted, // Active JavaScript
        navigationDelegate: (NavigationRequest request) {
          // Check if the navigation request is for a trusted domain
          String domain = Uri.parse(request.url).host;
          if (domain != 'hoppophop.fr') {
            // Prevent the navigation request if it is not for a trusted domain
            return NavigationDecision.prevent;
          }

          // If the navigation request is for a trusted domain, allow it
          return NavigationDecision.navigate;
        },
      ),
    );
  }
}
