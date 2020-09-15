import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shoppingapp/utils/theme_notifier.dart';

const kAndroidUserAgent =
    'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.94 Mobile Safari/537.36';

String selectedUrl = 'https://mawasmbookstore.com/%d8%aa%d8%b5%d9%86%d9%8a%d9%81%d8%a7%d8%aa-%d8%a7%d9%84%d8%ae%d8%af%d9%85%d8%a7%d8%aa/';

// ignore: prefer_collection_literals
final Set<JavascriptChannel> jsChannels = [
  JavascriptChannel(
      name: 'Print',
      onMessageReceived: (JavascriptMessage message) {
        print(message.message);
      }),
].toSet();



class Servise_Page extends StatelessWidget {
  final flutterWebViewPlugin = FlutterWebviewPlugin();

  @override
  Widget build(BuildContext context) {
    final themeColor = Provider.of<ThemeNotifier>(context);

    return WebviewScaffold(
      url: selectedUrl,
      javascriptChannels: jsChannels,
      mediaPlaybackRequiresUserGesture: false,
      appBar: AppBar(
        title:  Text('خدمات',style: GoogleFonts.cairo(color: themeColor.getColor()),),
        backgroundColor:Colors.white ,
        iconTheme: IconThemeData(color:  themeColor.getColor()),
        centerTitle: true,
      ),
      withZoom: true,
      withLocalStorage: true,
      hidden: true,
      initialChild: Container(
        child:  Center(child:
        CircularProgressIndicator(
            valueColor:
            AlwaysStoppedAnimation<Color>(themeColor.getColor()
            ))),
      ),
    );
  }
}
