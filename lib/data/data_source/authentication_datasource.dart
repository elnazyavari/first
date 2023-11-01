import 'package:apple_online_shop/data/dependency_Injection/di.dart';
import 'package:apple_online_shop/data/errors/api_exception.dart';
import 'package:dio/dio.dart';

abstract class IAuthenticationDataSourcec {
  Future<void> register(
    String username,
    String password,
    String passwordConfirm,
  );
  Future<String> login(String username, String password);
}

class AuthenticationRemote implements IAuthenticationDataSourcec {
  final Dio _dio = locator.get();

  @override
  Future<void> register(
      String username, String password, String passwordConfirm) async {
    try {
      final response = await _dio.post(
        'collections/users/records',
        data: {
          'username': username,
          'password': password,
          'passwordConfirm': passwordConfirm
        },
      );
      // ignore: avoid_print
      print('${response.statusCode}');
    } on DioException catch (ex) {
      throw ApiException(ex.response?.statusCode, ex.response?.data['message']);
    } catch (ex) {
      throw ApiException(0, 'unKnow error');
    }
  }

  @override
  Future<String> login(String username, String password) async {
    try {
      final resposnse = await _dio.post(
        'collections/users/auth-with-password',
        data: {'identity': username, 'password': password},
      );
      if (resposnse.statusCode == 200) {
        return resposnse.data['token'];
      }
    } on DioException catch (ex) {
      throw ApiException(ex.response?.statusCode, ex.response?.data['message']);
    } catch (ex) {
      throw ApiException(0, 'خطایی دیگر');
    }
    return '';
  }
}
