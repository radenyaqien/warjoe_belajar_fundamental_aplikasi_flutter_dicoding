import 'package:flutter/material.dart';
import 'package:flutter_pannable_rating_bar/flutter_pannable_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:warjoe/data/remote/api_service.dart';
import 'package:warjoe/provider/restaurant_detail_provider.dart';
import 'package:warjoe/util.dart';

import '../data/model/detail/restaurant_detail.dart';
import '../provider/restaurants_provider.dart';
import '../widget/horizontal_gridview.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key, required this.id});

  final String id;

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Restaurant Menu")),
      body: ChangeNotifierProvider<RestaurantDetailProvider>(
        create: (_) =>
            RestaurantDetailProvider(apiService: ApiService(), id: widget.id),
        child: _buildState(),
      ),
    );
  }

  Widget _buildState() {
    return Consumer<RestaurantDetailProvider>(builder: (context, state, _) {
      if (state.state == ResultState.loading) {
        return const Center(child: CircularProgressIndicator());
      } else if (state.state == ResultState.hasData) {
        return _buildDetail(state.result.restaurant);
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
    });
  }

  Widget _buildDetail(Restaurant restaurant) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
                clipBehavior: Clip.antiAlias,
                decoration: const BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.all(Radius.circular(4))),
                child: Image.network(parseRestaurantUrl(
                    restaurant.pictureId, ImageResolution.medium))),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 16),
              child: Text(restaurant.name,
                  style: const TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Open Sans',
                      fontSize: 24)),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 8),
              child: Row(
                children: [
                  Text(restaurant.rating.toString(),
                      style: const TextStyle(
                          color: Colors.black54,
                          fontFamily: 'Open Sans',
                          fontSize: 14)),
                  PannableRatingBar(
                    rate: restaurant.rating,
                    items: List.generate(
                        5,
                        (index) => const RatingWidget(
                              selectedColor: Colors.yellow,
                              unSelectedColor: Colors.grey,
                              child: Icon(
                                Icons.star,
                                size: 14,
                              ),
                            )),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 8),
              child: Row(
                children: [
                  const Icon(
                    Icons.location_on,
                    color: Colors.black54,
                    size: 16.0,
                    semanticLabel: 'location',
                  ),
                  Text(restaurant.city,
                      style: const TextStyle(
                          color: Colors.black54,
                          fontFamily: 'Open Sans',
                          fontSize: 16)),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 16, top: 20, right: 16),
              child: Text(
                "Description",
                textAlign: TextAlign.justify,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: Text(
                restaurant.description,
                textAlign: TextAlign.justify,
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 16, right: 20, top: 16),
              child: Text("Menus",
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Open Sans',
                      fontSize: 20)),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 16, right: 16),
              child: Text("Drinks List",
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Open Sans',
                      fontSize: 16)),
            ),
            HorizontalGridView(
              drinks: restaurant.menus.drinks,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "Foods List",
                style: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Open Sans',
                    fontSize: 16),
                textAlign: TextAlign.justify,
              ),
            ),
            HorizontalGridView(
              drinks: restaurant.menus.foods,
            )
          ],
        ),
      ),
    );
  }
}
