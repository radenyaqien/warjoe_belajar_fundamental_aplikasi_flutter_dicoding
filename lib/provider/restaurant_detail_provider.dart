import 'package:flutter/cupertino.dart';
import 'package:warjoe/data/model/detail/restaurant_detail.dart';
import 'package:warjoe/provider/restaurants_provider.dart';

import '../data/remote/api_service.dart';

class RestaurantDetailProvider extends ChangeNotifier {
  final ApiService apiService;
  final String id;

  RestaurantDetailProvider({required this.apiService, required this.id}) {
    _fetchRestaurant(id);
  }

  late RestaurantDetail _apiResponse;
  late ResultState _state;
  String _message = '';

  String get message => _message;

  RestaurantDetail get result => _apiResponse;

  ResultState get state => _state;

  Future<dynamic> _fetchRestaurant(String id) async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final restaurant = await apiService.getDetailRestorant(id);
      if (restaurant.error) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _apiResponse = restaurant;
      }
    } on Exception catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = "No Internet Connection";
    }
  }
}
