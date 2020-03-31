import 'dart:async';
// import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class RecipeView extends StatefulWidget {
  final String postUrl;
  RecipeView({@required this.postUrl});

  @override
  _RecipeViewState createState() => _RecipeViewState();
}

class _RecipeViewState extends State<RecipeView> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  String finalUrl;

  @override
  void initState() {
    super.initState();
    finalUrl = widget.postUrl;
    if (widget.postUrl.contains('http://')) {
      finalUrl = widget.postUrl.replaceAll("http://", "https://");
      print(finalUrl + "this is final url");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff213A50),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Text(
            //   "My",
            //   style: TextStyle(
            //     fontSize: 20,
            //     color: Colors.white,
            //     fontFamily: 'Overpass',
            //   ),
            // ),
            Text(
              "Recipes",
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontFamily: 'Overpass',
              ),
            ),
            Text(
              "Book",
              style: TextStyle(
                fontSize: 20,
                color: Colors.blue,
                fontFamily: 'Overpass',
              ),
            ),
          ],
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: WebView(
          onPageFinished: (val) {
            print(val);
          },
          javascriptMode: JavascriptMode.unrestricted,
          initialUrl: finalUrl,
          onWebViewCreated: (WebViewController webViewController) {
            setState(() {
              _controller.complete(webViewController);
            });
          },
        ),
      ),
    );
  }
}
