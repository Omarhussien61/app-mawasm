import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:http/http.dart' as http;
import 'package:shoppingapp/modal/Config_Model.dart';

class APICONFIQ{
  static String getconfiq='https://app.woo2.app/configuration/get_config_d1.php';
  static String Base_url='https://mawasmbookstore.com';
  static String url=Base_url+'/wp-json/wc/v3';
  static String consumer_key='ck_d7834df4d8cd70c4d3f54a421ea0a6540e63ae4c';
  static String consumer_secret='cs_6c4507d1e3bfe569746ae97349008ac42cf6a391';
  static String Key='consumer_key=$consumer_key&consumer_secret=$consumer_secret';
  static String   kGoogleApiKey = "AIzaSyBb0GpBvrtNExsQHDb55DcVVnmUgL85w4U";

  //getCategories
  static String getAllCategories=url+'/products/categories?hide_empty=false&exclude=[15,15]&per_page=100&'+Key;
  static String getMainCategories=url+'/products/categories?hide_empty=false&exclude=[15,15]&per_page=100&parent=0&'+Key;

  static String getSubCategories=url+'/products/categories?per_page=100&'+Key;

  //getproducts
  static String getproducts=url+'/products?exclude=[6018,6018]&per_page=100&';
  static String getServise=Base_url+'/wp-json/wc-product-add-ons/v1/product-add-ons?';

  static String getproduct=url+'/products';

  //getproductsHomepadge
  static String getproductsHome=url+'/products?exclude=[6018,6018]&per_page=6&'+Key;

  //getOrders
  static String getOrder=url+'/orders?'+Key;
  static String Register=url+'/customers?'+Key;
  static String Ubdateplofile=url+'/customers';

  static String setReview=url+'/products/reviews';

  //getPayment
  static String getPayment=url+'/payment_gateways?'+Key;

  ///getShipping
  static String getShipping=url+'/shipping/zones?'+Key;
  static String getCopons=url+'/coupons?';

  //Login
  static String getOrders=url+'/orders?';
  static String Login=Base_url+'/api/auth/generate_auth_cookie/';
  //Register

  static Future<Config_Model> getNewConfiq() async {
    var client = new http.Client();
    var dio = Dio();
    dio.interceptors.add(DioCacheManager(CacheConfig(baseUrl: getconfiq)).interceptor);

    Config_Model config_model;
    try {

      var response = await dio.get(getconfiq,
        options: buildCacheOptions(Duration(days: 7)),

      );
      print(response.data);
      if (response.statusCode == 200) {
        var data = json.decode(response.data);
        config_model = new Config_Model.fromJson(data);
      } else {
        print('Something went wrong');
      }
    } catch (e) {
      print(e);
    } finally {
      client.close();
    }
    return config_model;
  }


}