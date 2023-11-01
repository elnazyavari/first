import 'package:apple_online_shop/data/dependency_Injection/di.dart';
import 'package:apple_online_shop/data/errors/api_exception.dart';
import 'package:apple_online_shop/data/model/category.dart';
import 'package:apple_online_shop/data/model/product_image.dart';
import 'package:apple_online_shop/data/model/product_variant.dart';
import 'package:apple_online_shop/data/model/variant.dart';
import 'package:apple_online_shop/data/model/variant_type.dart';
import 'package:dio/dio.dart';

abstract class IProductDetailsDatasource {
  Future<List<Productimage>> getGallery(String productId);
  Future<List<VariantType>> getVariantTypes();
  Future<List<Variant>> getVariant(String productId);
  Future<List<ProductVariant>> getProductVariant(String productId);
  Future<Category> getProductCategory(String categoryId);
}

class ProductDetailsRemote implements IProductDetailsDatasource {
  final Dio _dio = locator.get();
  @override
  Future<List<Productimage>> getGallery(String productId) async {
    try {
      Map<String, String> qParams = {'filter': 'product_id="$productId"'};
      final response = await _dio.get(
        'collections/gallery/records',
        queryParameters: qParams,
      );
      return response.data['items']
          .map<Productimage>(
              (jsonObject) => Productimage.fromMapJson(jsonObject))
          .toList();
    } on DioException catch (ex) {
      throw ApiException(ex.response?.statusCode, ex.response?.data['message']);
    } catch (ex) {
      throw ApiException(0, 'خطایی دیگر');
    }
  }

  @override
  Future<List<VariantType>> getVariantTypes() async {
    try {
      final response = await _dio.get('collections/variants_type/records',);
      return response.data['items']
          .map<VariantType>((jsonObject) => VariantType.fromMapJson(jsonObject))
          .toList();
    } on DioException catch (ex) {
      throw ApiException(ex.response?.statusCode, ex.response?.data['message']);
    } catch (ex) {
      throw ApiException(0, 'خطایی دیگر');
    }
  }

  @override
  Future<List<Variant>> getVariant(String productId) async {
    try {
      Map<String, String> qParams = {'filter': 'product_id="$productId"'};
      final response = await _dio.get(
        'collections/variants/records',
        queryParameters: qParams,
      );
      return response.data['items']
          .map<Variant>((jsonObject) => Variant.fromMapJson(jsonObject))
          .toList();
    } on DioException catch (ex) {
      throw ApiException(ex.response?.statusCode, ex.response?.data['message']);
    } catch (ex) {
      throw ApiException(0, 'خطایی دیگر');
    }
  }

  @override
  Future<List<ProductVariant>> getProductVariant(String productId) async {
    final variantTypeList = await getVariantTypes();
    final variantList = await getVariant(productId);

    List<ProductVariant> productVariantList = [];

    try {
      for (var variantType in variantTypeList) {
        final variant = variantList
            .where((element) => element.typeId == variantType.id)
            .toList();
        productVariantList.add(ProductVariant(variantType, variant));
      }
      return productVariantList;
    } catch (e) {
      throw ApiException(0, 'create ProductVariant Model Error');
    }
  }

  @override
  Future<Category> getProductCategory(String categoryId) async {
    try {
      Map<String, String> qParams = {'filter': 'id="$categoryId"'};
      final response = await _dio.get(
        'collections/category/records',
        queryParameters: qParams,
      );
      return Category.fromMapJson(response.data['items'][0]);
    } on DioException catch (ex) {
      throw ApiException(ex.response?.statusCode, ex.response?.data['message']);
    } catch (ex) {
      throw ApiException(0, 'getProductCategoryDataSourceError');
    }
  }
}
