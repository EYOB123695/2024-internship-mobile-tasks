import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/constants/network/network_info.dart';
import 'features/authentication/data/datasource/Authlocaldatasouceimpl.dart';
import 'features/authentication/data/datasource/Authremotedatasourceimpl.dart';
import 'features/authentication/data/repository/Auth_repository_impl.dart';
import 'features/authentication/domain/Usecases/Login.dart';
import 'features/authentication/domain/Usecases/signup.dart';
import 'features/authentication/domain/repository/Authrrepository.dart';

import 'features/authentication/presentation/bloc/bloc/signin_bloc.dart';
import 'features/authentication/presentation/bloc/bloc/signup_bloc.dart';

import 'features/authentication/data/datasource/Authlocaldatasource.dart';
import 'features/authentication/data/datasource/Authremotedatasource.dart';
import 'features/product/data/datasource/product_local_data_source.dart';
import 'features/product/data/datasource/product_local_data_source_impl.dart';
import 'features/product/data/datasource/product_remote_data_source.dart';
import 'features/product/data/repository/product_repository_impl.dart';

import 'features/product/domain/usecases/deleteproduct.dart';
import 'features/product/domain/usecases/get_products.dart';
import 'features/product/domain/usecases/insert_product.dart';
import 'features/product/domain/usecases/update_product.dart';
import 'features/product/presentation/bloc/bloc/detailpage_bloc.dart';
import 'features/product/presentation/bloc/bloc/homepage_bloc.dart';
import 'features/product/presentation/bloc/bloc/searchproduct_bloc.dart';
import 'features/product/presentation/bloc/bloc/updateproduct_bloc.dart';

final getIt = GetIt.instance;

Future<void> setup() async {
  var client = http.Client();
  var internetChecker = InternetConnectionChecker();
  var sharedPreferences = await SharedPreferences.getInstance();

  // Register network and HTTP-related services
  getIt.registerSingleton<InternetConnectionChecker>(internetChecker);
  getIt.registerFactory<NetworkInfo>(() => NetworkInfoImpl(internetChecker));
  getIt.registerLazySingleton<http.Client>(() => client);

  // Register Data Sources
  getIt.registerLazySingleton<Authremotedatasource>(
      () => AuthRemoteDataSourceImpl(client: client));
  getIt.registerLazySingleton<Authlocaldatasource>(
      () => AuthLocalDataSourceImpl(sharedPreferences: sharedPreferences));

  // Register AuthRepository implementation
  getIt.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(
        authremotedatasource: getIt<Authremotedatasource>(),
        authlocaldatasource: getIt<Authlocaldatasource>(),
        networkInfo: getIt<NetworkInfo>(),
      ));

  // Product-related registrations
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
  getIt.registerLazySingleton<InsertProductUseCase>(
      () => InsertProductUseCase(getIt<ProductRepositoryImpl>()));
  getIt.registerLazySingleton<DeleteProductUseCase>(
      () => DeleteProductUseCase(getIt<ProductRepositoryImpl>()));
  getIt.registerLazySingleton<UpdateProductUseCase>(
      () => UpdateProductUseCase(getIt<ProductRepositoryImpl>()));

  // Register Blocs
  getIt.registerLazySingleton<HomepageBloc>(
      () => HomepageBloc(getProductsUseCase: getIt<GetProductsUseCase>()));
  getIt.registerLazySingleton<DetailpageBloc>(() =>
      DetailpageBloc(deleteProductUseCase: getIt<DeleteProductUseCase>()));
  getIt.registerLazySingleton<UpdateproductBloc>(() =>
      UpdateproductBloc(updateProductUseCase: getIt<UpdateProductUseCase>()));
  getIt.registerLazySingleton<SearchproductBloc>(() => SearchproductBloc());

  // Authentication-related registrations
  getIt.registerLazySingleton<LogInUseCase>(
      () => LogInUseCase(authRepository: getIt<AuthRepository>()));
  getIt.registerLazySingleton<SignUpUseCase>(
      () => SignUpUseCase(authRepository: getIt<AuthRepository>()));

  // Register Authentication Blocs
  getIt.registerLazySingleton<SigninBloc>(
      () => SigninBloc(logInUseCase: getIt<LogInUseCase>()));
  getIt.registerLazySingleton<SignupBloc>(
      () => SignupBloc(signUpUseCase: getIt<SignUpUseCase>()));
}
