import 'package:flutter/material.dart';

import '../data/model/detail/restaurant_detail.dart';

class HorizontalGridView extends StatelessWidget {
  final List<Category> drinks;

  const HorizontalGridView({super.key, required this.drinks});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150, // Adjust height as needed
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: drinks.length,
        itemBuilder: (context, index) {
          final item = drinks[index].name;
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: 120, // Adjust width as needed
              decoration: BoxDecoration(
                color: Colors.blueGrey[200],
                borderRadius: BorderRadius.circular(10.0),
              ),
              padding: const EdgeInsets.all(8.0),
              child: Center(
                  child: Text(
                item,
                textAlign: TextAlign.center,
              )),
            ),
          );
        },
      ),
    );
  }
}
