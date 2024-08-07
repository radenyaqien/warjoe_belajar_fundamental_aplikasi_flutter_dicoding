import 'package:flutter/material.dart';
import 'package:warjoe/data/model/Restaurant.dart';

import '../../util.dart';
import '../detail_page.dart';

class RestaurantItem extends StatelessWidget {
  final Restaurant restaurant;

  const RestaurantItem({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
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
}
