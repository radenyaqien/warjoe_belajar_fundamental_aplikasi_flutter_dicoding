import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:warjoe/data/local/database_helper.dart';
import 'package:warjoe/provider/database_provider.dart';
import 'package:warjoe/provider/restaurants_provider.dart';
import 'package:warjoe/ui/widget/restaurant_item.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DatabaseProvider(databaseHelper: DatabaseHelper()),
      child: const FavoriteProvider(),
    );
  }
}

class FavoriteProvider extends StatelessWidget {
  const FavoriteProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back)),
        title: const Text("Favorite Restaurant"),
      ),
      body: Consumer<DatabaseProvider>(builder: (context, provider, _) {
        if (provider.state == ResultState.loading) {
          return const Center(child: CircularProgressIndicator());
        } else if (provider.state == ResultState.hasData) {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: provider.favorites.length,
            itemBuilder: (context, index) {
              var restaurant = provider.favorites[index];
              return RestaurantItem(restaurant: restaurant);
            },
          );
        } else if (provider.state == ResultState.noData) {
          return Center(
            child: Material(
              child: Text(provider.message),
            ),
          );
        } else if (provider.state == ResultState.error) {
          return Center(
            child: Material(
              child: Text(provider.message),
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
