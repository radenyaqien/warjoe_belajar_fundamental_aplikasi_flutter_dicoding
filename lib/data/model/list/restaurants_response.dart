// To parse this JSON data, do
//
//     final restaurantsList = restaurantsListFromJson(jsonString);

import 'dart:convert';

import '../Restaurant.dart';

RestaurantsResponse restaurantsListFromJson(String str) => RestaurantsResponse.fromJson(json.decode(str));

String restaurantsListToJson(RestaurantsResponse data) => json.encode(data.toJson());

class RestaurantsResponse {
  bool error;
  String message;
  int count;
  List<Restaurant> restaurants;

  RestaurantsResponse({
    required this.error,
    required this.message,
    required this.count,
    required this.restaurants,
  });

  factory RestaurantsResponse.fromJson(Map<String, dynamic> json) => RestaurantsResponse(
    error: json["error"],
    message: json["message"],
    count: json["count"],
    restaurants: List<Restaurant>.from(json["restaurants"].map((x) => Restaurant.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "message": message,
    "count": count,
    "restaurants": List<dynamic>.from(restaurants.map((x) => x.toJson())),
  };
}


