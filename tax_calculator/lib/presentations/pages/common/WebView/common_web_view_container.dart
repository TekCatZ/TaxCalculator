import 'package:flutter/material.dart';
import 'package:tax_calculator/presentations/pages/common/WebView/navigation_controls.dart';
import 'package:tax_calculator/presentations/pages/common/WebView/web_view_stack.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CommonWebViewContainer extends StatefulWidget {
  final String url;

  const CommonWebViewContainer({super.key, required this.url});

  static Route<void> route(String url) {
    return MaterialPageRoute<void>(
        builder: (_) => CommonWebViewContainer(url: url));
  }

  @override
  createState() => _CommonWebViewContainerState();
}

class _CommonWebViewContainerState extends State<CommonWebViewContainer> {
  late final WebViewController _webViewController;
  var loadingPercentage = 0;

  @override
  void initState() {
    super.initState();
    print("Url: ${widget.url}");
    WebViewCookie cookie = const WebViewCookie(
      name: "sessionId",
      value: "123456789",
      domain: "localhost",
    );
    WebViewCookieManager()
        .setCookie(cookie)
        .then((_) => _webViewController = WebViewController()
          ..loadRequest(
            Uri.parse(widget.url),
          ));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Flutter WebView'),
            actions: [NavigationControls(controller: _webViewController)],
          ),
          body: WebViewStack(controller: _webViewController),
        ),
        onWillPop: () => _exitApp(context));
  }

  // Handle for go back on android button
  Future<bool> _exitApp(BuildContext context) async {
    if (await _webViewController.canGoBack()) {
      _webViewController.goBack();
      return Future.value(false);
    } else {
      return Future.value(true);
    }
  }
}
