import 'dart:convert';

import 'package:warjoe/model/restaurant.dart';

ApiResponse apiResponseFromJson(String str) =>
    ApiResponse.fromJson(json.decode(str));

String apiResponseToJson(ApiResponse data) => json.encode(data.toJson());

class ApiResponse {
  List<Restaurant> restaurants;

  ApiResponse({
    required this.restaurants,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json) => ApiResponse(
        restaurants: List<Restaurant>.from(
            json["restaurants"].map((x) => Restaurant.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "restaurants": List<dynamic>.from(restaurants.map((x) => x.toJson())),
      };
}
