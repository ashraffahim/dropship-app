import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Browser extends StatefulWidget {
  final String id;

  const Browser(this.id, {Key? key}) : super(key: key);

  @override
  BrowserState createState() => BrowserState();
}

class BrowserState extends State<Browser> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  late WebViewController _webViewController;

  @override
  void initState() {
    super.initState();
    // Enable virtual display.
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: const BackButton(),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black87,
        shadowColor: Colors.black12,
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: getCookie(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              String cookie = RegExp('PHPSESSID=(.*)')
                  .firstMatch(snapshot.data.toString())![1]
                  .toString();
              return WebView(
                onWebViewCreated: (controller) {
                  _webViewController = controller;
                  controller.runJavascript('''const d = new Date();
                  d.setTime(d.getTime() + (7*24*60*60*1000));
                  let expires = "expires="+ d.toUTCString();
                  document.cookie = "$cookie;" + expires + ";path=/";location.reload()''');
                },
                initialUrl:
                    'https://api.grap.store/checkout/pay/stripe/${widget.id}?sessid=$cookie',
                javascriptMode: JavascriptMode.unrestricted,
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Column(
                  children: [
                    Icon(
                      Icons.error,
                      color: Theme.of(context).colorScheme.error,
                    ),
                    const Divider(
                      height: 8.0,
                      color: Colors.transparent,
                    ),
                    Text('${snapshot.error}')
                  ],
                ),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }

  Future<String?> getCookie() async {
    final SharedPreferences prefs = await _prefs;
    String? cookie = prefs.getString('cookie');
    return cookie;
  }
}
