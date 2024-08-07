import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:warjoe/data/model/list/restaurants_response.dart';
import 'package:warjoe/data/model/review/add_review_body.dart';
import 'package:warjoe/data/model/review/add_review_response.dart';

import '../model/detail/restaurant_detail.dart';
import '../model/search/restaurants_search_response.dart';

class ApiService {
  static const String _baseUrl = 'https://restaurant-api.dicoding.dev/';


  Future<RestaurantsResponse> getRestaurants() async {
    final response = await http.get(Uri.parse("${_baseUrl}list"));
    if (response.statusCode == 200) {
      return RestaurantsResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load Restaurants List');
    }
  }

  Future<RestaurantDetailResponse> getDetailRestorant(String id) async {
    final response = await http.get(Uri.parse("${_baseUrl}detail/$id"));
    if (response.statusCode == 200) {
      return RestaurantDetailResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load Restaurant Detail');
    }
  }

  Future<RestaurantsSearch> searchRestorant(String query) async {
    final response = await http.get(Uri.parse("${_baseUrl}search?q=$query"));
    if (response.statusCode == 200) {
      return RestaurantsSearch.fromJson(json.decode(response.body));
    } else if (response.statusCode == 404) {
      throw Exception("Data Not Found");
    } else {
      throw Exception('Failed to load Restaurant Detail');
    }
  }

  Future<AddReview> addReview(AddReviewBody body) async {
    final response = await http.post(Uri.parse("${_baseUrl}review"),
        headers: {"Content_Type": "application/json"}, body: body);
    if (response.statusCode == 200) {
      return AddReview.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to Add Review');
    }
  }
}
