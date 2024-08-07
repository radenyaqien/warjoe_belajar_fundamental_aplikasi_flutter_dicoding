import 'package:flutter/cupertino.dart';
import 'package:warjoe/data/model/list/restaurants_response.dart';

import '../data/remote/api_service.dart';

enum ResultState { loading, noData, hasData, error }

class RestaurantsProvider extends ChangeNotifier {
  final ApiService apiService;

  RestaurantsProvider({required this.apiService}) {
    _fetchAllRestaurants();
  }

  late RestaurantsResponse _apiResponse;
  late ResultState _state;
  String _message = '';

  String get message => _message;

  RestaurantsResponse get result => _apiResponse;

  ResultState get state => _state;

  Future<dynamic> _fetchAllRestaurants() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final article = await apiService.getRestaurants();
      if (article.restaurants.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _apiResponse = article;
      }
    } on Exception catch (_) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'No Internet Connection';
    }
  }
}
