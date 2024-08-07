// To parse this JSON data, do
//
//     final restaurantsSearch = restaurantsSearchFromJson(jsonString);

import 'dart:convert';

import '../Restaurant.dart';

RestaurantsSearch restaurantsSearchFromJson(String str) => RestaurantsSearch.fromJson(json.decode(str));

String restaurantsSearchToJson(RestaurantsSearch data) => json.encode(data.toJson());

class RestaurantsSearch {
  bool error;
  int founded;
  List<Restaurant> restaurants;

  RestaurantsSearch({
    required this.error,
    required this.founded,
    required this.restaurants,
  });

  factory RestaurantsSearch.fromJson(Map<String, dynamic> json) => RestaurantsSearch(
    error: json["error"],
    founded: json["founded"],
    restaurants: List<Restaurant>.from(json["restaurants"].map((x) => Restaurant.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "founded": founded,
    "restaurants": List<dynamic>.from(restaurants.map((x) => x.toJson())),
  };
}

