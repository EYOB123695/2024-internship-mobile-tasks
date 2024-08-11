import 'package:ecommerce_app/core/constants/network/network_info.dart';
import 'package:ecommerce_app/features/product/data/datasource/product_local_data_source.dart';
import 'package:ecommerce_app/features/product/data/datasource/product_local_data_source_impl.dart';
import 'package:mockito/annotations.dart';
import 'package:ecommerce_app/features/product/domain/repository/product_repository.dart';
import 'package:http/http.dart' as http;
import 'package:ecommerce_app/features/product/data/datasource/product_remote_data_source.dart';
import 'package:shared_preferences/shared_preferences.dart';

@GenerateMocks(
  [
    ProductRepository,
    ProductRemoteDataSource,
    ProductLocalDataSource,
    NetworkInfo,
    SharedPreferences,
  ],
  customMocks: [
    MockSpec<http.Client>(as: #MockHttpClient),
  ],
)
void main() {
  // Your test code here
}
