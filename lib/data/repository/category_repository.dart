import 'package:apple_online_shop/data/data_source/category_datasource.dart';
import 'package:apple_online_shop/data/dependency_Injection/di.dart';
import 'package:apple_online_shop/data/errors/api_exception.dart';
import 'package:apple_online_shop/data/model/category.dart';
import 'package:dartz/dartz.dart';

abstract class ICategoryRepository {
  Future<Either<String, List<Category>>> getCategories();
}

class CategoryRepository extends ICategoryRepository {
  final ICategoryDataSource _dataSource = locator.get();
  @override
  Future<Either<String, List<Category>>> getCategories() async {
    try {
      var response = await _dataSource.getCategories();
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message ?? 'متنی ندارد');
    }
  }
}
