import 'package:dio/dio.dart';
import 'package:learning_dart/core/interceptors.dart';
import 'package:learning_dart/utils/endpoints.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomHttp {
  Dio client = Dio();

  CustomHttp() {
    //instância dio com configurações
    client.options.baseUrl = Endpoint.baseUrl;
    client.options.connectTimeout = 600000;
    client.interceptors.add(InterceptorDIO());
    client.interceptors
        .add(InterceptorsWrapper(onRequest: (options, handler) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? access = prefs.getString('accessToken');
      if (access != null) {
        options.headers['Authorization'] = 'Bearer ' + access;
      }
      return handler.next(options);
    }, onError: (DioError error, handler) async {
      print(error.response?.statusCode);
      if (error.response?.statusCode == 401) {
        await refreshToken();
        return handler.resolve(await _retry(error.requestOptions));
      }
    }));
  }

  //recebe as opções da requisição
  Future<Response<dynamic>> _retry(
    RequestOptions requestOptions,
  ) async {
    final options = Options(
      method: requestOptions.method,
      headers: requestOptions.headers,
    );
    Response response = await Dio().request<dynamic>(requestOptions.path,
        data: requestOptions.data,
        queryParameters: requestOptions.queryParameters,
        options: options);
    return response;
  }

  Future<void> refreshToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final response = await client.post(Endpoint.refreshToken,
        data: {'refresh_token', await prefs.getString('refreshToken')});
    if (response.statusCode == 200 || response.statusCode == 201) {
      prefs.setString('accessToken', response.data['DATA']['access_token']);
      prefs.setString('refreshToken', response.data['DATA']['refresh_token']);
    } else {
      prefs.clear();
    }
  }
}
