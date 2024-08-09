

import 'package:warjoe/data/model/detail/restaurant_detail.dart';
import 'package:warjoe/data/model/list/restaurants_response.dart';
import 'package:warjoe/data/model/search/restaurants_search_response.dart';

import 'dummy_response.dart';

import 'package:flutter_test/flutter_test.dart';

void main() {

  test('Parsing Test Restaurant List JSON', ()async {
    var result = RestaurantsResponse.fromJson(dummyListResult);

    expect(result.error, dummyListResult['error']);
    expect(result.message, dummyListResult['message']);
    expect(result.count, dummyListResult['count']);
    expect(result.restaurants.length, 20);

    expect(result.restaurants[0].id, 'gehrbsvjbsdjkcvnsdjk');
  });



  test('Parsing Test Detail Restaurant Data JSON', ()async {
    var result = RestaurantDetailResponse.fromJson(dummyDetailResult);

    expect(result.error, dummyDetailResult['error']);
    expect(result.message, dummyDetailResult['message']);
    expect(result.message, 'success');

    expect(result.restaurant.id, 'gehrbsvjbsdjkcvnsdjk');
    expect(result.restaurant.name, 'Melting Pot');
    expect(result.restaurant.city, 'Medan');
  });

  test('Parsing Test Restaurant Search Data JSON', ()async {
    var result = RestaurantsSearch.fromJson(dummySearchResult);

    expect(result.error, dummySearchResult['error']);
    expect(result.founded, dummySearchResult['founded']);

    expect(result.restaurants.length, 1);
    expect(result.restaurants[0].id, 'gehrbsvjbsdjkcvnsdjk');
  });

  test('Parsing Test Restaurant Search Data JSON Kosong', ()async {
    var result = RestaurantsSearch.fromJson(emptySearchResult);

    expect(result.error, emptySearchResult['error']);
    expect(result.founded, emptySearchResult['founded']);

    expect(result.restaurants.length, 0);

  });


}