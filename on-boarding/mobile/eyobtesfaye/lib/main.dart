import 'package:eyobtesfaye/details_page.dart';
import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'add_product.dart';
import 'search_product.dart';
import 'custom_page_route.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter task',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/',
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/':
            return CustomPageRoute(
                page: const HomeScreen(), settings: settings);
          case '/add-product':
            return CustomPageRoute(
                page: const AddProductScreen(), settings: settings);
          case '/search-product':
            return CustomPageRoute(
                page: const SearchProduct(), settings: settings);
          case '/details':
            // Ensure the argument is properly passed
            final imagepath = settings.arguments as String?;
            return CustomPageRoute(
              page: DetailsPage(imagepath: imagepath ?? ''),
              settings: settings,
            );
          default:
            return null;
        }
      },
    );
  }
}
