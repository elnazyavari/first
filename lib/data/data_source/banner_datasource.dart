import 'package:apple_online_shop/data/dependency_Injection/di.dart';
import 'package:apple_online_shop/data/errors/api_exception.dart';
import 'package:apple_online_shop/data/model/banners.dart';
import 'package:dio/dio.dart';

abstract class IBannerDatasource {
  Future<List<Banners>> getBanners();
}

class BannerRemote implements IBannerDatasource {
  final Dio _dio = locator.get();
  @override
  Future<List<Banners>> getBanners() async {
    try {
      var response = await _dio.get('collections/banner/records');
      return response.data['items']
          .map<Banners>((jsonObject) => Banners.fromMapJson(jsonObject))
          .toList();
    } on DioException catch (ex) {
      throw ApiException(ex.response?.statusCode, ex.response?.data['message']);
    } catch (ex) {
      throw ApiException(0, 'unKnow error');
    }
  }
}
