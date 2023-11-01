import 'package:apple_online_shop/data/data_source/authentication_datasource.dart';
import 'package:apple_online_shop/data/data_source/banner_datasource.dart';
import 'package:apple_online_shop/data/data_source/category_datasource.dart';
import 'package:apple_online_shop/data/data_source/product_datasource.dart';
import 'package:apple_online_shop/data/data_source/product_details_datasource.dart';
import 'package:apple_online_shop/data/repository/authentication_repository.dart';
import 'package:apple_online_shop/data/repository/banner_repository.dart';
import 'package:apple_online_shop/data/repository/category_repository.dart';
import 'package:apple_online_shop/data/repository/product_details_repository.dart';
import 'package:apple_online_shop/data/repository/product_repository.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

var locator = GetIt.I;
Future<void> getItInit() async {
  //components
  locator.registerSingleton<Dio>(
      Dio(BaseOptions(baseUrl: 'http://startflutter.ir/api/')));

  locator.registerSingleton<SharedPreferences>(
      await SharedPreferences.getInstance());

  //dataSource
  locator.registerFactory<IAuthenticationDataSourcec>(
      () => AuthenticationRemote());
  locator.registerFactory<ICategoryDataSource>(() => CagetoryRemote());
  locator.registerFactory<IBannerDatasource>(() => BannerRemote());
  locator.registerFactory<IProductDataSource>(() => ProductsRemote());
  locator
      .registerFactory<IProductDetailsDatasource>(() => ProductDetailsRemote());

  //repositories
  locator.registerFactory<IAuthRepository>(() => AuthenticationRepository());
  locator.registerFactory<ICategoryRepository>(() => CategoryRepository());
  locator.registerFactory<IBannerRepository>(() => Bannerrepository());
  locator.registerFactory<IProductsRepository>(() => ProductsRepository());
  locator.registerFactory<IProductDetailsRepository>(
      () => ProductDetailsRepository());
}
