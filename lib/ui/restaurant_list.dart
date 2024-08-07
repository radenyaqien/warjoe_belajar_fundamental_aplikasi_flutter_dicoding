import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:warjoe/provider/restaurants_provider.dart';
import 'package:warjoe/util.dart';

import '../data/model/Restaurant.dart';
import 'detail_page.dart';

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
            return buildRestaurantItem(context, restaurant);
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

Widget buildRestaurantItem(BuildContext context, Restaurant restaurant) {
  return InkWell(
    onTap: () {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => DetailPage(id: restaurant.id),
        ),
      );
    },
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 100,
                width: 100,
                clipBehavior: Clip.antiAlias,
                decoration: const BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.all(Radius.circular(4))),
                child: Image.network(
                  parseRestaurantUrl(
                      restaurant.pictureId, ImageResolution.medium),
                  fit: BoxFit.cover,
                ),
              ),
            )),
        Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(restaurant.name,
                      style: const TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Open Sans',
                          fontSize: 16)),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.location_on,
                          color: Colors.black54,
                          size: 14.0,
                          semanticLabel: 'location',
                        ),
                        Text(restaurant.city,
                            style: const TextStyle(
                                color: Colors.black54,
                                fontFamily: 'Open Sans',
                                fontSize: 14)),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.star,
                          color: Colors.black54,
                          size: 14.0,
                          semanticLabel: 'location',
                        ),
                        Text(restaurant.rating.toString(),
                            style: const TextStyle(
                                color: Colors.black54,
                                fontFamily: 'Open Sans',
                                fontSize: 14)),
                      ],
                    ),
                  ),
                ],
              ),
            ))
      ],
    ),
  );
}
