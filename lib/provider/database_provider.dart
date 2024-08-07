import 'package:flutter/cupertino.dart';
import 'package:warjoe/data/model/Restaurant.dart';
import 'package:warjoe/data/model/detail/restaurant_detail.dart';
import 'package:warjoe/provider/restaurants_provider.dart';

import '../data/local/database_helper.dart';

class DatabaseProvider extends ChangeNotifier {
  final DatabaseHelper databaseHelper;

  DatabaseProvider({required this.databaseHelper}) {
    _getFavorites();
  }

  late ResultState _state;

  ResultState get state => _state;

  String _message = '';

  String get message => _message;

  List<Restaurant> _favorites = [];

  List<Restaurant> get favorites => _favorites;

  void _getFavorites() async {
    _state = ResultState.loading;
    _favorites = await databaseHelper.getFavorites();
    if (_favorites.isNotEmpty) {
      _state = ResultState.hasData;
    } else {
      _state = ResultState.noData;
      _message = 'Empty Data';
    }
    notifyListeners();
  }

  void addFavorite(RestaurantDetail restaurantdetail) async {
    try {
      Restaurant restaurant = Restaurant(
          id: restaurantdetail.id,
          name: restaurantdetail.name,
          description: restaurantdetail.description,
          pictureId: restaurantdetail.pictureId,
          city: restaurantdetail.city,
          rating: restaurantdetail.rating);
      await databaseHelper.insertFavorite(restaurant);
      _getFavorites();
    } catch (e) {
      _state = ResultState.error;
      _message = 'Gagal Menambah data favorite';
      notifyListeners();
    }
  }

  Future<bool> isFavorite(String id) async {
    final favoriteRestaurant = await databaseHelper.getFavoriteById(id);
    return favoriteRestaurant.isNotEmpty;
  }

  void removeFavorite(String id) async {
    try {
      await databaseHelper.removeFavorite(id);
      _getFavorites();
    } catch (e) {
      _state = ResultState.error;
      _message = 'gagal mengahapus data favorite, coba lagi';
      notifyListeners();
    }
  }
}
