import 'package:apple_online_shop/data/data_source/product_datasource.dart';
import 'package:apple_online_shop/data/dependency_Injection/di.dart';
import 'package:apple_online_shop/data/errors/api_exception.dart';
import 'package:apple_online_shop/data/model/product.dart';
import 'package:dartz/dartz.dart';

abstract class IProductsRepository {
  Future<Either<String, List<Product>>> getProducts();
  Future<Either<String, List<Product>>> getHotestProducts();
  Future<Either<String, List<Product>>> getBestSellerProducts();
}

class ProductsRepository implements IProductsRepository {
  final IProductDataSource _dataSource = locator.get();
  @override
  Future<Either<String, List<Product>>> getProducts() async {
    try {
      final response = await _dataSource.getProducts();
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message ?? 'متن خطا وجود ندارد');
    }
  }
  
  @override
  Future<Either<String, List<Product>>> getBestSellerProducts() async {
    try {
      final response = await _dataSource.getBestSellerProducts();
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message ?? 'متن خطا وجود ندارد');
    }
  }
  
  @override
  Future<Either<String, List<Product>>> getHotestProducts() async {
    try {
      final response = await _dataSource.getHotestProducts();
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message ?? 'متن خطا وجود ندارد');
    }
  }
}
