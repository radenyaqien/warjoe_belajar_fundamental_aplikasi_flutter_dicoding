import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:warjoe/data/remote/api_service.dart';
import 'package:warjoe/provider/restaurants_provider.dart';
import 'package:warjoe/ui/detail_page.dart';
import 'package:warjoe/ui/favorite_page.dart';
import 'package:warjoe/ui/restaurant_list.dart';
import 'package:warjoe/ui/search_page.dart';
import 'package:warjoe/ui/setting_page.dart';

import '../utils/background_service.dart';
import '../utils/notification_helper.dart';

class HomePage extends StatelessWidget {
  static String routeName="/homepage";
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RestaurantsProvider>(
      create: (context) => RestaurantsProvider(apiService: ApiService()),
      child: const HomeContent(),
    );
  }
}

class HomeContent extends StatefulWidget {
  const HomeContent({super.key});

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  final NotificationHelper _notificationHelper = NotificationHelper();
  final BackgroundService _service = BackgroundService();

  @override
  void initState() {
    super.initState();

    _notificationHelper
        .configureSelectNotificationSubject(DetailPage.routeName);
  }

  @override
  void dispose() {
    selectNotificationSubject.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Restaurant Menu"),
          actions: [
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const SearchPage(),
                  ),
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.favorite_rounded),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const FavoritePage(),
                  ),
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const SettingPage(),
                  ),
                );
              },
            ),
          ],
        ),
        body: const RestaurantListPage());
  }
}
