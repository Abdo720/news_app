import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:news_app/home/data/api/api_constants.dart';
import 'package:news_app/home/data/api_result.dart';
import 'package:news_app/home/data/models/news_model.dart';


class Api {
  static Future<Result<NewsModel>> getData() async {
    try {
      Uri url = Uri.https(ApiConstants.baseUrl, ApiConstants.endPoint, {
        'q': 'bitcoin',
        'apiKey': ApiConstants.apiKey,
      });
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var responseBody = response.body;
        Map<String, dynamic> json = jsonDecode(responseBody);
        return Success(NewsModel.fromJson(json));
      } else {
        return Error("Failed to load news: Status ${response.statusCode}");
      }
    } catch (e) {
      return Error(e.toString());
    }
  }
}