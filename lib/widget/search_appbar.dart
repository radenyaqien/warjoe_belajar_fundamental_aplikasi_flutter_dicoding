import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:warjoe/provider/search_restaurant_provider.dart';

class SearchAppbar extends StatelessWidget {
  final Widget body;

  const SearchAppbar({super.key, required this.body});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pencarian"),
      ),
      resizeToAvoidBottomInset: false,
      body: SafeArea(
          child: Column(
        children: [
          const BuildSearchAppBar(),
          Expanded(
            child: body,
          ),
        ],
      )),
    );
  }
}

class BuildSearchAppBar extends StatefulWidget {
  const BuildSearchAppBar({super.key});

  @override
  State<BuildSearchAppBar> createState() => _BuildSearchAppBarState();
}

class _BuildSearchAppBarState extends State<BuildSearchAppBar> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            cursorColor: Colors.black,
            controller: _controller,
            decoration: const InputDecoration(

              hintText: 'Search your favorite restaurant',
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(100.0),
                ),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10.0),
                ),
              ),
            ),
            onSubmitted: (value) {
              Provider.of<SearchRestaurantProvider>(context, listen: false)
                  .performSearch(value);
            },
          ),
        ),
      ],
    );
  }
}
