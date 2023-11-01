import 'package:apple_online_shop/bloc/product/product_event.dart';
import 'package:apple_online_shop/bloc/product/product_state.dart';
import 'package:apple_online_shop/data/dependency_Injection/di.dart';
import 'package:apple_online_shop/data/repository/product_details_repository.dart';
import 'package:bloc/bloc.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final IProductDetailsRepository _dataSource = locator.get();
  ProductBloc() : super(ProductInitialState()) {
    on<ProductInitialEvent>((event, emit) async {
      emit(ProductLoadingState());
      final galleryResponse = await _dataSource.getGallery(event.productId);
      final productVariantResponse = await _dataSource.getProductVariant(event.productId);
      final productCategory = await _dataSource.getProductCategory(event.productCategoryId);
      emit(
          ProductResponseSuccessState(galleryResponse, productVariantResponse, productCategory));
    });
  }
}
