import 'package:dio/dio.dart';
import 'package:zl_app/utils/env.dart';

final String apiUrl = "http://api.chingc.online/";
final String host = "api.chingc.online";

class DioSingleton {
  static Dio _dio;
  DioSingleton._();
  static Dio getInstance() {
    if (null == _dio) {
      _dio = Dio();
      _dio.interceptors.add(_interceptor);
    }
    return _dio;
  }

  // 拦截器(预处理器)
  static InterceptorsWrapper _interceptor = InterceptorsWrapper(
    // 发送请求前预处理
    onRequest: (RequestOptions options) async {
      // 添加header
      options.headers = _headers;
      options.responseType = ResponseType.json;

      return options;
    },
    // 响应预处理
    onResponse: (Response response) async {
      // 转换服务器给的数据
      if (200 == response.statusCode) {
        response.extra = {
          'ServerCode': response.data['retCode'],
          'ServerMessage': response.data['message'],
        };
        response.data = response.data['data'];
      }
      return response;
    },
    // 错误预处理
    onError: (DioError err) async {
      return err;
    },
  );

  static Map<String, dynamic> _headers = {
    'Host': host,
    'User-Agent': '${AppEnvironment.appName}/${AppEnvironment.version}(${AppEnvironment.platform})',
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };
}
