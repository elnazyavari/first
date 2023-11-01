import 'package:apple_online_shop/bloc/home/home_event.dart';
import 'package:apple_online_shop/bloc/home/home_state.dart';
import 'package:apple_online_shop/data/dependency_Injection/di.dart';
import 'package:apple_online_shop/data/repository/banner_repository.dart';
import 'package:apple_online_shop/data/repository/category_repository.dart';
import 'package:apple_online_shop/data/repository/product_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final IBannerRepository _bannerRepository = locator.get();
  final ICategoryRepository _categoryRepository = locator.get();
  final IProductsRepository _productRepository = locator.get();
  HomeBloc() : super(HomeInitialState()) {
    on<HomeGetInitializedDataEvent>(
      (event, emit) async {
        emit(HomeLoadingState());
        final bannerList = await _bannerRepository.getBanners();
        final categoryList = await _categoryRepository.getCategories();
        final productList = await _productRepository.getProducts();
        final hotestProductList = await _productRepository.getHotestProducts();
        final bestSellerProductList =
            await _productRepository.getBestSellerProducts();
        emit(HomeRequestSuccessState(
          bannerList,
          categoryList,
          productList,
          hotestProductList,
          bestSellerProductList,
        ));
      },
    );
  }
}
