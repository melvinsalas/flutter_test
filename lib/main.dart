import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurantour/data/models/restaurant.dart';
import 'package:restaurantour/presentation/bloc/restaurants_bloc.dart';
import 'package:restaurantour/presentation/bloc/restaurants_event.dart';
import 'package:restaurantour/presentation/pages/restaurant_detail_page.dart';
import 'package:restaurantour/presentation/pages/restaurants_page.dart';
import 'package:restaurantour/presentation/utils/style_util.dart';
import 'injection.dart' as di;

void main() {
  di.init();
  runApp(const Restaurantour());
}

class Restaurantour extends StatelessWidget {
  const Restaurantour({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => di.locator<RestaurantsBloc>()
            ..add(const FetchRestaurants('Las Vegas')),
        ),
      ],
      child: MaterialApp(
        routes: {
          '/detail': (context) {
            final arguments = ModalRoute.of(context)!.settings.arguments;
            final restaurant = arguments as Restaurant;
            return RestaurantDetailPage(id: restaurant.id!);
          },
        },
        title: 'Restaurantour',
        theme: ThemeData(
          primaryColor: Colors.white,
          colorScheme: const ColorScheme.light(
            primary: Colors.black,
            secondary: Colors.black,
          ),
          scaffoldBackgroundColor: const Color(0xFFFAFAFA),
          appBarTheme: AppBarTheme(
            color: Colors.white,
            iconTheme: const IconThemeData(color: Colors.black),
            titleTextStyle: StyleUtil.appBarTitle,
          ),
        ),
        home: const RestaurantsPage(),
      ),
    );
  }
}
