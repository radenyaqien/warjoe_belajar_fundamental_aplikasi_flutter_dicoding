import 'package:flutter/material.dart';
import 'package:flutter_pannable_rating_bar/flutter_pannable_rating_bar.dart';
import 'package:warjoe/model/restaurant.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({super.key, required this.restaurant});

  final Restaurant restaurant;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
              clipBehavior: Clip.antiAlias,
              decoration: const BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.all(Radius.circular(4))),
              child: Image.network(restaurant.pictureId)),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 16),
            child: Text(restaurant.name,
                style: const TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Open Sans',
                    fontSize: 18)),
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
          Padding(
            padding: const EdgeInsets.only(left: 16, top: 16, right: 16),
            child: Text(
              restaurant.description,
              textAlign: TextAlign.justify,
            ),
          ),
          SizedBox(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: restaurant.menus.drinks.length,
              itemBuilder: (context, index) {
                return SizedBox(
                    height: 100,
                    width: 100,
                    child: Text(restaurant.menus.drinks[index].name));
              },
            ),
          )
        ],
      ),
    );
  }
}
