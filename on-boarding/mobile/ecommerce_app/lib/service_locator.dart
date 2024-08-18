// final GetIt getIt = GetIt.instance;

// Future<void> setupLocator() async {
//   // Register the Http Client
//   getIt.registerLazySingleton<http.Client>(() => http.Client());

//   // Register SharedPreferences (which is async)
//   final sharedPreferences = await SharedPreferences.getInstance();
//   getIt.registerLazySingleton<SharedPreferences>(() => sharedPreferences);

//   // Register InternetConnectionChecker
//   getIt.registerLazySingleton<InternetConnectionChecker>(
//       () => InternetConnectionChecker());

//   // Register NetworkInfo
//   getIt.registerLazySingleton<NetworkInfo>(
//       () => NetworkInfoImpl(getIt<InternetConnectionChecker>()));

//   // Register ProductRemoteDataSource
//   getIt.registerLazySingleton<ProductRemoteDataSource>(
//     () => ProductRemoteDataSourceImpl(client: getIt<http.Client>()),
//   );

//   // Register ProductLocalDataSource
//   getIt.registerLazySingleton<ProductLocalDataSource>(
//     () => ProductLocalDataSourceImpl(
//         sharedpreferences: getIt<SharedPreferences>()),
//   );

//   // Register the repository implementation
//   getIt.registerLazySingleton<ProductRepositoryImpl>(
//     () => ProductRepositoryImpl(
//       getIt<NetworkInfo>(),
//       getIt<ProductRemoteDataSource>(),
//       getIt<ProductLocalDataSource>(),
//     ),
//   );

//   // Register the use case
//   getIt.registerLazySingleton<GetProductsUseCase>(
//     () => GetProductsUseCase(getIt<ProductRepositoryImpl>()),
//   );
// }

import 'core/constants/network/network_info.dart';
import 'features/product/data/datasource/product_local_data_source.dart';
import 'features/product/data/datasource/product_local_data_source_impl.dart';
import 'features/product/data/datasource/product_remote_data_source.dart';
import 'features/product/data/repository/product_repository_impl.dart';
import 'features/product/domain/usecases/deleteproduct.dart';
import 'features/product/domain/usecases/get_products.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'features/product/domain/usecases/insert_product.dart';
import 'features/product/domain/usecases/update_product.dart';
import 'features/product/presentation/bloc/bloc/detailpage_bloc.dart';
import 'features/product/presentation/bloc/bloc/homepage_bloc.dart';
import 'features/product/presentation/bloc/bloc/searchproduct_bloc.dart';
import 'features/product/presentation/bloc/bloc/updateproduct_bloc.dart';

final getIt = GetIt.instance;

Future<void> setup() async {
  var client = http.Client();
  var internetChechker = InternetConnectionChecker();
  var sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerSingleton<InternetConnectionChecker>(internetChechker);
  getIt.registerFactory<NetworkInfo>(() => NetworkInfoImpl(internetChechker));
  getIt.registerLazySingleton<ProductRemoteDataSource>(
      () => ProductRemoteDataSourceImpl(client: client));
  getIt.registerLazySingleton<ProductLocalDataSource>(
      () => ProductLocalDataSourceImpl(sharedpreferences: sharedPreferences));
  getIt
      .registerLazySingleton<ProductRepositoryImpl>(() => ProductRepositoryImpl(
            getIt<NetworkInfo>(),
            getIt<ProductRemoteDataSource>(),
            getIt<ProductLocalDataSource>(),
          ));
  getIt.registerLazySingleton<GetProductsUseCase>(
      () => GetProductsUseCase(getIt<ProductRepositoryImpl>()));
  // getIt.registerLazySingleton<GetOneProduct>(()=>GetOneProduct(getIt()));
  // getIt.registerLazySingleton<InsertProduct>(()=>
  //     InsertProduct(productRepository: getIt()));
  // getIt.registerLazySingleton<UpdateProduct>(()=>UpdateProduct(getIt()));
  // getIt.registerLazySingleton<DeleteProduct>(()=>DeleteProduct(getIt()));
  getIt.registerLazySingleton<HomepageBloc>(
      () => HomepageBloc(getProductsUseCase: getIt()));
  getIt.registerLazySingleton<InsertProductUseCase>(
      () => InsertProductUseCase(getIt<ProductRepositoryImpl>()));
  getIt.registerLazySingleton<DeleteProductUseCase>(
      () => DeleteProductUseCase(getIt<ProductRepositoryImpl>()));
  getIt.registerLazySingleton<DetailpageBloc>(
      () => DetailpageBloc(deleteProductUseCase: getIt()));
  getIt.registerLazySingleton<UpdateProductUseCase>(
      () => UpdateProductUseCase(getIt<ProductRepositoryImpl>()));
  getIt.registerLazySingleton<UpdateproductBloc>(() =>
      UpdateproductBloc(updateProductUseCase: getIt<UpdateProductUseCase>()));
  getIt.registerLazySingleton<SearchproductBloc>(() => SearchproductBloc());
}
