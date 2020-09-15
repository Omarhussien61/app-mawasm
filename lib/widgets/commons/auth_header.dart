import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shoppingapp/pages/login_page.dart';
import 'package:shoppingapp/utils/navigator.dart';
import 'package:shoppingapp/utils/screen.dart';
import 'package:shoppingapp/utils/theme_notifier.dart';

class AuthHeader extends StatelessWidget {
  final String headerTitle;
  final String headerBigTitle;
  final bool isLoginHeader;

  AuthHeader({this.headerTitle, this.headerBigTitle, this.isLoginHeader});

  @override
  Widget build(BuildContext context) {
    final themeColor = Provider.of<ThemeNotifier>(context);

    return Container(

      padding: EdgeInsets.all(16),
      height: ScreenUtil.getHeight(context) * 0.3,
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Align(
            alignment: Alignment.topCenter,
            child: Text(
              headerTitle,
              style: GoogleFonts.poppins(
                fontSize: 17,
                color: Colors.white,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
          this.isLoginHeader
              ? Container()
              : Align(
                  alignment: Alignment.topLeft,
                  child: InkWell(
                    onTap: () {
                      Nav.routeReplacement(context, LoginPage());
                    },
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                  ),
                ),
          Align(
            alignment: Alignment.center,
            child: CachedNetworkImage(

              imageUrl:  'https://mawasmbookstore.com/wp-content/uploads/2020/08/الشعار-فوتوشب-1.png',
            ),
          )
        ],
      ),
    );
  }
}
