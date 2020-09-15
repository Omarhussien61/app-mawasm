import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:clippy_flutter/diagonal.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:getflutter/components/button/gf_button.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shoppingapp/modal/Recentview.dart';
import 'package:shoppingapp/modal/category.dart';
import 'package:shoppingapp/modal/productmodel.dart';
import 'package:shoppingapp/modal/slider.dart';
import 'package:shoppingapp/pages/printing.dart';
import 'package:shoppingapp/pages/product_detail.dart';
import 'package:shoppingapp/pages/search_page.dart';
import 'package:shoppingapp/service/categoryservice.dart';
import 'package:shoppingapp/service/productdervice.dart';

import 'package:shoppingapp/utils/dummy_data/discountImages.dart';
import 'package:shoppingapp/utils/navigator.dart';
import 'package:shoppingapp/utils/screen.dart';
import 'package:shoppingapp/utils/theme_notifier.dart';
import 'package:shoppingapp/utils/util/LanguageTranslated.dart';
import 'package:shoppingapp/utils/util/recentId.dart';
import 'package:shoppingapp/utils/util/sql_helper.dart';
import 'package:shoppingapp/widgets/homepage/category_list_view.dart';
import 'package:shoppingapp/widgets/homepage/discount_list.dart';
import 'package:shoppingapp/widgets/homepage/product_list.dart';
import 'package:shoppingapp/widgets/homepage/product_list_titlebar.dart';
import 'package:shoppingapp/widgets/homepage/search_box.dart';

import 'Servise_page.dart';

class HomePage extends StatefulWidget {
  List<Category> maincat;
  Future<List<ProductModel>> productDiscount,
      productNew,
      moreSale,
      productview,
      product_low_priced;
  List<Slider_model> slider;

  HomePage(this.maincat, this.productDiscount, this.productNew, this.moreSale,
      this.productview, this.product_low_priced,this.slider);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _carouselCurrentPage = 0;
  SQL_Helper helper = new SQL_Helper();
  SQL_Rercent sql_rercent = new SQL_Rercent();
  String contVeiw;
  bool connected;
  List<Widget> imageSliders;



  @override
  void initState() {
    //updateListView();
    countCart();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final themeColor = Provider.of<ThemeNotifier>(context);


    return Scaffold(
      backgroundColor: Color.fromARGB(255, 252, 252, 252),
      body: OfflineBuilder(
        connectivityBuilder: (
          BuildContext context,
          ConnectivityResult connectivity,
          Widget child,
        ) {
          connected = connectivity != ConnectivityResult.none;
          return themeColor.config_model != null
              ? themeColor.config_model.offlineAppMode
                  ? getListview(context)
                  : connected
                      ? getListview(context)
                      : Center(
                          child: Container(
                          child: Column(
                            children: [
                              Image.asset(
                                'assets/images/not_found_smile.PNG',
                                height: ScreenUtil.getHeight(context) / 2,
                              ),
                              Text(getTransrlate(context, 'NotConnection')),
                              SizedBox(
                                height: 50,
                              ),
                              GFButton(
                                onPressed: () {
                                  //Nav.route(context, SearchPage());
                                },
                                text: getTransrlate(context, 'retry'),
                                color: themeColor.getColor(),
                                textStyle: GoogleFonts.cairo(fontSize: 18),
                              )
                            ],
                          ),
                        ))
              : Center(
                  child: Container(
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/images/not_found_smile.PNG',
                        height: ScreenUtil.getHeight(context) / 2,
                      ),
                      Text(getTransrlate(context, 'NotConnection')),
                      SizedBox(
                        height: 50,
                      ),
                      GFButton(
                        onPressed: () {
                          //Nav.route(context, SearchPage());
                        },
                        text: getTransrlate(context, 'retry'),
                        color: themeColor.getColor(),
                        textStyle: GoogleFonts.cairo(fontSize: 18),
                      )
                    ],
                  ),
                ));
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text(
              'There are no bottons to push :)',
            ),
            new Text(
              'Just turn off your internet.',
            ),
          ],
        ),
      ),
    );
  }

  void countCart() async {
    helper.getCount().then((value) {
      Provider.of<ThemeNotifier>(context).intcountCart(value);
    });
  }


  Widget getListview(BuildContext context) {

    final themeColor = Provider.of<ThemeNotifier>(context);
    if (widget.slider != null) {
      _carouselCurrentPage = widget.slider.length;
    }
    ;
    if(widget.slider!=null){
      imageSliders = widget.slider
          .map((item) => Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Colors.grey[200],
                blurRadius: 5.0,
                spreadRadius: 1,
                offset: Offset(0.0, 1)),
          ],
        ),
        margin: EdgeInsets.only(left: 12.0, right: 16, top: 16, bottom: 16),
        child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            child: Stack(
              children: <Widget>[
                Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                        color: Colors.grey,
                        width: 230,
                        child: CachedNetworkImage(imageUrl: item.image,
                            fit: BoxFit.cover, width: 220.0))),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Diagonal(
                    clipHeight: 70.0,
                    axis: Axis.vertical,
                    position: DiagonalPosition.BOTTOM_RIGHT,
                    child: Container(
                      color: Colors.white,
                      width: 200.0,
                      height: 175.0,
                      child: Align(
                        alignment: Alignment.center,
                        child: Container(
                          width: 150,
                          margin: EdgeInsets.only(right: 54, left: 12),
                          child: AutoSizeText(
                            item.title,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 3,
                            maxFontSize: 15,
                            minFontSize: 11,
                            style: GoogleFonts.poppins(
                              color: Color(0xFF5D6A78),
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )),
      ))
          .toList();
    }
    return ListView(shrinkWrap: true, children: [
      SearchBox(),
      themeColor.config_model.slider != null
          ? themeColor.config_model.slider
              ? Column(
                  children: [
                    widget.slider!=null? CarouselSlider(
                      items: imageSliders,
                      options: CarouselOptions(
                          autoPlay: true,
                          height: 175,
                          viewportFraction: 1.0,
                          enlargeCenterPage: false,
                          onPageChanged: (index, reason) {
                            setState(() {
                              _carouselCurrentPage = index;
                            });
                          }),
                    ):Container(),
                    //SliderDot(current: _carouselCurrentPage)
                  ],
                )
              : Container()
          : Container(),
      themeColor.config_model.productCategories != null
          ? themeColor.config_model.productCategories
              ? CategoryListView(widget.maincat)
              : Container()
          : Container(),
      Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: (){
              Nav.route(context, Printing());

            },
            child: Container(
              margin: EdgeInsets.only(top: 8, left: 8, bottom: 8,right: 8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey[200],
                        blurRadius: 5.0,
                        spreadRadius: 1,
                        offset: Offset(0.0, 1)),
                  ]),
              width: ScreenUtil.getWidth(context) / 2.5,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('خدمات',
                    style: GoogleFonts.cairo(fontSize: 20),),
                ),
              ),
            ),
          ),
          InkWell(
            onTap: (){
              Nav.route(context, SearchPage());

            },
            child: Container(
              margin: EdgeInsets.only(top: 8, left: 8, bottom: 8,right: 8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey[200],
                        blurRadius: 5.0,
                        spreadRadius: 1,
                        offset: Offset(0.0, 1)),
                  ]),
              width: ScreenUtil.getWidth(context) / 2.5,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('منتجات',
                    style: GoogleFonts.cairo(fontSize: 20),),
                ),
              ),
            ),
          ),
        ],
      ),
      themeColor.config_model.lowPriced != null
          ? themeColor.config_model.lowPriced
              ? DiscountList(
                  themeColor: themeColor,
                  product: widget.product_low_priced,
                  productListTitleBar: ProductListTitleBar(
                    themeColor: themeColor,
                    title: getTransrlate(context, 'Low-PricedProducts'),
                    isCountShow: false,
                  ),
                )
              : Container()
          : Container(),
      themeColor.config_model.topProduct != null
          ? themeColor.config_model.topProduct
              ? ProductList(
                  themeColor: themeColor,
                  product: widget.moreSale,
                  productListTitleBar: ProductListTitleBar(
                    themeColor: themeColor,
                    title: getTransrlate(context, 'MostRated'),
                    isCountShow: false,
                  ),
                )
              : Container()
          : Container(),
    ]);
  }
}
