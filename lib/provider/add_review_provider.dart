import 'package:flutter/cupertino.dart';
import 'package:warjoe/data/model/review/add_review_body.dart';
import 'package:warjoe/data/model/review/add_review_response.dart';

import '../data/remote/api_service.dart';

enum ResultState { loading, success, error }

class AddReviewProvider extends ChangeNotifier {
  final ApiService apiService;

  AddReviewProvider({required this.apiService});

  late ResultState _state;

  ResultState get state => _state;

  late AddReview _response;

  AddReview get response => _response;

  String _message = "";

  String get message => _message;

  String _rId = '';
  String _rName = '';
  String _rReview = '';

  Future<dynamic> addReview() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final restaurant = await apiService
          .addReview(AddReviewBody(id: _rId, name: _rName, review: _rReview));
      if (restaurant.error) {
        _state = ResultState.error;
        notifyListeners();
        return _message = restaurant.message;
      } else {
        _state = ResultState.success;
        notifyListeners();
        return _response = restaurant;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'No Internet Connection';
    }
  }

  void changeId(String id) {
    _rId = id;
    notifyListeners();
  }

  void changeName(String name) {
    _rName = name;
    notifyListeners();
  }

  void changeReview(String review) {
    _rReview = review;
    notifyListeners();
  }
}
