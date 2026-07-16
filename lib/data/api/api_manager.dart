import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news_app/data/api/api_constants.dart';
import 'package:news_app/data/models/news_model.dart';

abstract class Api {

  static Future<NewsModel>  getData() async {
    Uri url = Uri.https(ApiConstants.baseUrl, ApiConstants.endPoint, {
      'q': 'bitcoin',
      'apiKey': ApiConstants.apiKey,
    });

    var response = await http.get(url);
    var responseBody = response.body;
    Map<String, dynamic> json = jsonDecode(responseBody);
    return NewsModel.fromJson(json);
  }
}