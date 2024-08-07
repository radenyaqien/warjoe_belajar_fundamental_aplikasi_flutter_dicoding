import 'package:flutter/cupertino.dart';
import 'package:warjoe/data/model/search/restaurants_search_response.dart';

import '../data/remote/api_service.dart';

enum ResultState { loading, noData, hasData, error }

class SearchRestaurantProvider extends ChangeNotifier {
  final ApiService apiService;

  SearchRestaurantProvider({required this.apiService});

  late RestaurantsSearch _apiResponse;

  RestaurantsSearch get result => _apiResponse;

  ResultState? _state;

  ResultState? get state => _state;

  String _message = '';

  String get message => _message;

  String _searchQuery = '';

  void performSearch(String query) {
    _searchQuery = query;
    notifyListeners();
    fetchSearchRestaurant();
  }

  Future<dynamic> fetchSearchRestaurant() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final article = await apiService.searchRestorant(_searchQuery);
      if (article.restaurants.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _apiResponse = article;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'No Internet Connection';
    }
  }
}
