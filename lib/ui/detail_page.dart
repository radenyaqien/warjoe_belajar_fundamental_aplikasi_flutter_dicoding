import 'package:flutter/material.dart';
import 'package:flutter_pannable_rating_bar/flutter_pannable_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:warjoe/data/local/database_helper.dart';
import 'package:warjoe/data/remote/api_service.dart';
import 'package:warjoe/provider/database_provider.dart';
import 'package:warjoe/provider/restaurant_detail_provider.dart';
import 'package:warjoe/utils/imageurl_helper.dart';

import '../data/model/detail/restaurant_detail.dart';
import '../provider/restaurants_provider.dart';
import '../widget/horizontal_gridview.dart';

class DetailPage extends StatefulWidget {
  static String routeName="detailpage";
  const DetailPage({super.key, required this.id});

  final String id;

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider<RestaurantDetailProvider>(
          create: (_) => RestaurantDetailProvider(
              apiService: ApiService(), id: widget.id)),
      ChangeNotifierProvider(
          create: (_) => DatabaseProvider(databaseHelper: DatabaseHelper()))
    ], child: const DetailState());
  }
}

class DetailState extends StatelessWidget {
  const DetailState({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back)),
        title: const Text("Restaurant Detail"),
      ),
      body: Consumer<RestaurantDetailProvider>(builder: (context, state, _) {
        if (state.state == ResultState.loading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state.state == ResultState.hasData) {
          return DetailContent(restaurant: state.result.restaurant);
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
      }),
    );
  }
}

class DetailContent extends StatelessWidget {
  const DetailContent({super.key, required this.restaurant});

  final RestaurantDetail restaurant;

  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseProvider>(builder: (context, provider, _) {
      return Scaffold(
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Stack(
                children: [
                  Container(
                      clipBehavior: Clip.antiAlias,
                      decoration: const BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.all(Radius.circular(4))),
                      child: Image.network(parseRestaurantUrl(
                          restaurant.pictureId, ImageResolution.medium))),
                  FutureBuilder<bool>(
                      future: provider.isFavorite(restaurant.id),
                      builder: (context, snapshot) {
                        var isfavorite = snapshot.data ?? false;
                        return Positioned(
                          top: 0,
                          right: 0,
                          child: IconButton(
                              onPressed: () {},
                              icon: isfavorite
                                  ? IconButton.filled(
                                      padding: const EdgeInsets.all(8.0),
                                      style: IconButton.styleFrom(
                                        backgroundColor: Colors.white70,
                                      ),
                                      icon: const Icon(
                                        Icons.favorite,
                                        color: Colors.redAccent,
                                      ),
                                      onPressed: () => provider
                                          .removeFavorite(restaurant.id),
                                    )
                                  : IconButton.filledTonal(
                                      padding: const EdgeInsets.all(8.0),
                                      style: IconButton.styleFrom(
                                        backgroundColor: Colors.white70,
                                      ),
                                      icon: const Icon(
                                          Icons.favorite_outline_outlined),
                                      onPressed: () =>
                                          provider.addFavorite(restaurant),
                                    )),
                        );
                      })
                ],
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 16.0, right: 16.0, top: 16),
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
    });
  }
}
