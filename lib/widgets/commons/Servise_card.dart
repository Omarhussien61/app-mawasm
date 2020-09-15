import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:html/parser.dart';
import 'package:provider/provider.dart';
import 'package:shoppingapp/modal/Servisemodel.dart';
import 'package:shoppingapp/modal/productmodel.dart';
import 'package:shoppingapp/pages/printing.dart';
import 'package:shoppingapp/pages/product_detail.dart';
import 'package:shoppingapp/pages/shopping_cart_page.dart';
import 'package:shoppingapp/utils/commons/AddFavorite.dart';
import 'package:shoppingapp/utils/commons/AddToCart.dart';
import 'package:shoppingapp/utils/commons/show_dialog.dart';
import 'package:shoppingapp/utils/dialogVeriation.dart';
import 'package:shoppingapp/utils/navigator.dart';
import 'package:shoppingapp/utils/screen.dart';
import 'package:shoppingapp/utils/theme_notifier.dart';
import 'package:shoppingapp/utils/util/LanguageTranslated.dart';
import 'package:shoppingapp/utils/util/sql_helper.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../config.dart';

class serviseCard extends StatefulWidget {
  const serviseCard({
    Key key,
    @required this.themeColor,
    this.product,
  }) : super(key: key);

  final ThemeNotifier themeColor;
  final ServiseModel product;

  @override
  _serviseCardState createState() => _serviseCardState();
}

class _serviseCardState extends State<serviseCard> {
  bool isliked;

  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        InkWell(
          onTap: () {
            Nav.route(context, Printing());
          },
          child: Container(
            width: ScreenUtil.getWidth(context) / 1,
            margin: EdgeInsets.only(left: 16, top: 8, right: 16, bottom: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
            ),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey[200],
                        blurRadius: 5.0,
                        spreadRadius: 1,
                        offset: Offset(0.0, 2)),
                  ]),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    child: Stack(
                      children: <Widget>[
                        Container(
                            width:  ScreenUtil.getWidth(context) / 1,
                            height:  ScreenUtil.getHeight(context)/5 ,
                            child: ClipRRect(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(8),
                                topRight: Radius.circular(8),
                              ),
                              child: CachedNetworkImage(
                                imageUrl: 'https://mawasmbookstore.com/wp-content/uploads/2020/08/4.jpg',
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                              ),
                            )),
                      ],
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    padding: EdgeInsets.only(left: 10, right: 10,top: 4),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        AutoSizeText(
                          widget.product.name,
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: Color(0xFF5D6A78),
                            fontWeight: FontWeight.w300,
                          ),
                          maxLines: 1,
                          minFontSize: 11,
                        ),


                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _launchInBrowser() async {
    String url = 'https://mawasmbookstore.com/%d9%83%d9%8a%d9%81-%d8%a7%d8%b7%d8%a8%d8%b9/';
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: false,
        //headers: <String, String>{'my_header_key': 'my_header_value'},
      );
    } else {
      throw 'Could not launch $url';
    }
  }


}
