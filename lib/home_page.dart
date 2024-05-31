import 'package:flutter/material.dart';
import 'package:warjoe/detail_page.dart';
import 'package:warjoe/model/ApiResponse.dart';
import 'package:warjoe/model/restaurant.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Restaurant Menu")),
      body: FutureBuilder(
        future: DefaultAssetBundle.of(context)
            .loadString('assets/local_restaurant.json'),
        builder: (contex, snapshot) {
          final ApiResponse response =
              apiResponseFromJson(snapshot.data!.toString());
          final List<Restaurant> restaurants = response.restaurants;
          return ListView.builder(
            itemCount: restaurants.length,
            itemBuilder: (context, index) {
              return _buildRestaurantItem(context, restaurants[index]);
            },
          );
        },
      ),
    );
  }
}

Widget _buildRestaurantItem(BuildContext context, Restaurant restaurant) {
  return InkWell(
    onTap: () {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => DetailPage(restaurant: restaurant),
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
                    borderRadius: BorderRadius.all(Radius.circular(4)) 
                ),
                child: Image.network(
                  restaurant.pictureId,
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
