import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

import 'features/product/domain/entities/product_entity.dart';
import 'features/product/domain/usecases/deleteproduct.dart';
import 'features/product/domain/usecases/get_products.dart';
import 'features/product/domain/usecases/insert_product.dart';
import 'features/product/domain/usecases/update_product.dart';
import 'features/product/presentation/bloc/bloc/addpage_bloc.dart';
import 'features/product/presentation/bloc/bloc/detailpage_bloc.dart';
import 'features/product/presentation/bloc/bloc/homepage_bloc.dart';
import 'features/product/presentation/bloc/bloc/searchproduct_bloc.dart';
import 'features/product/presentation/bloc/bloc/updateproduct_bloc.dart';
import 'features/product/presentation/pages/add_product.dart';
import 'features/product/presentation/pages/custom_page_route.dart';
import 'features/product/presentation/pages/details_page.dart';
import 'features/product/presentation/pages/home_screen.dart';
import 'features/product/presentation/pages/search_product.dart';
import 'features/product/presentation/pages/update_product.dart';
import 'service_locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await setup();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => HomepageBloc(
            getProductsUseCase: GetIt.instance<GetProductsUseCase>(),
          )..add(HomePageLoadEvent()),
        ),
        BlocProvider(
          create: (context) => AddpageBloc(
              insertProductUseCase: GetIt.instance<InsertProductUseCase>()),
        ),
        BlocProvider(
          create: (context) => DetailpageBloc(
              deleteProductUseCase: GetIt.instance<DeleteProductUseCase>()),
        ),
        BlocProvider(
          create: (context) => UpdateproductBloc(
              updateProductUseCase: GetIt.instance<UpdateProductUseCase>()),
        ),
        BlocProvider(
          create: (context) => GetIt.instance<SearchproductBloc>(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter task',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomeScreen(),
      initialRoute: '/',
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/':
            return CustomPageRoute(page: HomeScreen(), settings: settings);
          case '/add-product':
            return CustomPageRoute(
                page: const AddProductScreen(), settings: settings);
          case '/search-product':
            final products = settings.arguments as List<ProductEntity>;
            return CustomPageRoute(
                page: SearchProduct(products: products), settings: settings);
          case '/details':
            return CustomPageRoute(
              page: const DetailsPage(),
              settings: settings,
            );
          case '/update-products':
            return CustomPageRoute(
              page: const UpdateProductScreen(),
              settings: settings,
            );

          default:
            return null;
        }
      },
    );
  }
}
