import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:shoppingapp/modal/about_model.dart';
import 'package:shoppingapp/modal/contact_model.dart';
import 'package:shoppingapp/modal/faq_model.dart';
import 'package:shoppingapp/modal/slider.dart';
import 'package:shoppingapp/modal/support_model.dart';

class information_service{

  static String Base_url='https://wshalqafs.com/';

  static Future<faq_model> get_faq() async {
    var dio = Dio();
    String URL=Base_url+'faq.php';
    dio.interceptors.add(DioCacheManager(
        CacheConfig(baseUrl:URL))
        .interceptor);
    faq_model theam;
    try {
      var response = await dio.get(
        URL,
        options: buildCacheOptions(Duration(days: 7)),
      );
      print(json.decode(response.data));
      if (response.statusCode == 200) {
        theam = new faq_model.fromJson(json.decode(response.data));
      } else {
        //  return await SharedPreferencesHelper.getThemeColor().toString();
        print('Somthing went wrong');
      }
    } catch (e) {
      print(e);
    } finally {
      dio.close();
    }
    return theam;
  }
  static Future<about_model> get_about() async {
    var dio = Dio();
    String URL=Base_url+'About.php';
    dio.interceptors.add(DioCacheManager(
        CacheConfig(baseUrl:URL))
        .interceptor);
    about_model theam;
    try {
      var response = await dio.get(
        URL,
        options: buildCacheOptions(Duration(days: 7)),
      );
      print(json.decode(response.data));
      if (response.statusCode == 200) {
        theam = new about_model.fromJson(json.decode(response.data));
      } else {
        //  return await SharedPreferencesHelper.getThemeColor().toString();
        print('Somthing went wrong');
      }
    } catch (e) {
      print(e);
    } finally {
      dio.close();
    }
    return theam;
  }
  static Future<support_model> get_support() async {
    var dio = Dio();
    String URL=Base_url+'Support.php';
    dio.interceptors.add(DioCacheManager(
        CacheConfig(baseUrl:URL))
        .interceptor);
    support_model theam;
    try {
      var response = await dio.get(
        URL,
        options: buildCacheOptions(Duration(days: 7)),
      );
      print(json.decode(response.data));
      if (response.statusCode == 200) {
        theam = new support_model.fromJson(json.decode(response.data));
      } else {
        //  return await SharedPreferencesHelper.getThemeColor().toString();
        print('Somthing went wrong');
      }
    } catch (e) {
      print(e);
    } finally {
      dio.close();
    }
    return theam;
  }
  static Future<contact_model> get_contact() async {
    var dio = Dio();
    String URL=Base_url+'Contact.php';
    dio.interceptors.add(DioCacheManager(
        CacheConfig(baseUrl:URL))
        .interceptor);
    contact_model theam;
    try {
      var response = await dio.get(
        URL,
        options: buildCacheOptions(Duration(days: 7)),
      );
      print(json.decode(response.data));
      if (response.statusCode == 200) {
        theam = new contact_model.fromJson(json.decode(response.data));
      } else {
        //  return await SharedPreferencesHelper.getThemeColor().toString();
        print('Somthing went wrong');
      }
    } catch (e) {
      print(e);
    } finally {
      dio.close();
    }
    return theam;
  }
  static Future<List<Slider_model>> get_Slider() async {
    List<Slider_model> products;
    String URL="https://mawasmbookstore.com/slider-api/";
    var dio = Dio();
    dio.interceptors.add(DioCacheManager(CacheConfig(baseUrl:  URL)).interceptor);

    var completer = new Completer<List<Slider_model>>();

    try {
      var response = await dio.get(
        URL,
        options: buildCacheOptions(Duration(days: 7), forceRefresh: true),
      );
      print(response.data);
      var data = jsonDecode(response.data);
      var list = data as List;
      if (response.statusCode == 200) {
        completer.complete(products = list
            .map<Slider_model>((i) => Slider_model.fromJson(i))
            .toList());

      } else {
        print('Somthing went wrong');
      }
    } catch (e) {
      print(e);
    } finally {
      dio.close();
    }
    return completer.future;
  }

}