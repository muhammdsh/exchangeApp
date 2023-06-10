
import 'package:dio/dio.dart';
import 'package:exchange/app+injection/di.dart';


import '../resources/apis.dart';
import '../services/session_manager.dart';

class AuthInterceptor extends Interceptor {
  final SessionManager sessionManager;
  final Dio dio;
  RequestOptions _previousRequest;

  AuthInterceptor(this.sessionManager, this.dio);

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final token = await sessionManager.authToken;

    print('RequestOptions RequestOptions RequestOptions');
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    _previousRequest = options;

    return handler.next(options);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 403 || err.response?.statusCode == 401) {
      final tokens = await Future.wait(
          [sessionManager.authToken, sessionManager.refreshToken]);

      try {
        final result = await _fetchNewToken(tokens.last, tokens.first);
        if (result.statusCode == 200) {
          final token = result.data['content']['token'];
          final refreshToken = result.data['content']['refresh_token'];

          await sessionManager.persistToken(token);
          await sessionManager.persistRefreshToken(refreshToken);

          _previousRequest.headers['Authorization'] = 'Bearer $token';

          final response = await dio.request(
            _previousRequest.path,
            data: _previousRequest.data,
            options: Options(
              method: _previousRequest.method,
              headers: _previousRequest.headers,
              responseType: _previousRequest.responseType,
              contentType: _previousRequest.contentType,
            ),
          );
          handler.resolve(response);
        }
      } catch (error) {
        handler.next(error);
      }
    } else {

      handler.next(err);
    }
  }

  Future<Response> _fetchNewToken(String refreshToken, String token) async {
    Dio dio = Dio();

    Response response = await dio.post("ApiUrls.refreshToken",
        options: Options(
            headers: {
              SessionManager.authorizeToken: 'Bearer $token',
              "refresh-token": refreshToken,
              "content-Type": "application/json",
              "Accept": "application/json"
            },
             validateStatus: (status) {
               return status < 500 && status != 403 ;
             }
          )
        );

    return response;
  }
}

mixin RefreshableRequest {
  final AuthInterceptor authInterceptor = locator<AuthInterceptor>();

  Dio getRefreshableDio() {
    final dio = Dio();
    dio.interceptors.add(authInterceptor);
    return dio;
  }
}
