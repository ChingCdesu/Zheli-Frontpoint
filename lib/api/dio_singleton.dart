import 'package:dio/dio.dart';
import 'package:zl_app/settings/user.dart';
import 'package:zl_app/utils/env.dart';

final String apiUrl = "http://sunba.asuscomm.com:54954/api/";
final String publicUrl = "http://sunba.asuscomm.com:54954/public/";
final String host = "sunba.asuscomm.com";

class DioSingleton {
  static Dio _dio;
  DioSingleton._();
  // lazy init
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
      options.headers.addAll(_headers);
      options.responseType = ResponseType.json;
      options.headers.addAll({
        'user': Account.userId ?? null,
        'token': Account.token ?? null,
      });
      // options.queryParameters.addAll({
      //   'user': Account.userId ?? null,
      //   'token': Account.token ?? null,
      // });
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
        // Account.token = response.headers.value('token');
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
    'Accept': 'application/json',
  };
}
