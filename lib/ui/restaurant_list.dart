import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:warjoe/provider/restaurants_provider.dart';
import 'package:warjoe/ui/widget/restaurant_item.dart';

class RestaurantListPage extends StatelessWidget {
  const RestaurantListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildList();
  }
}

Widget _buildList() {
  return Consumer<RestaurantsProvider>(
    builder: (context, state, _) {
      if (state.state == ResultState.loading) {
        return const Center(child: CircularProgressIndicator());
      } else if (state.state == ResultState.hasData) {
        return ListView.builder(
          shrinkWrap: true,
          itemCount: state.result.restaurants.length,
          itemBuilder: (context, index) {
            var restaurant = state.result.restaurants[index];
            return RestaurantItem(restaurant: restaurant);
          },
        );
      } else if (state.state == ResultState.noData) {
        return Center(
          child: Material(
            child: Text(state.message),
          ),
        );
      } else if (state.state == ResultState.error) {
        return Center(
          child: Material(
            child: Text(state.message),
          ),
        );
      } else {
        return const Center(
          child: Material(
            child: Text(''),
          ),
        );
      }
    },
  );
}
