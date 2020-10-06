import 'package:dio/dio.dart';
import 'package:zl_app/api/dio_singleton.dart';
import 'package:zl_app/api/models.dart';
import 'package:zl_app/settings/user.dart';

abstract class ModelDecorator {
  Model model;

  int httpStatusCode;
  dynamic retCode;
  String msg;
  DateTime _operationStartTime, _operationEndTime;
  bool _hasError = false;
  bool get hasError => this._hasError;
  Exception _ex;
  StackTrace _stack;
  dynamic _result;
  String url;

  Model fromJson(Map<String, dynamic> json) => model.fromJson(json);
  Map<String, dynamic> toJson() => model.toJson();

  ModelDecorator(this.model);
  Future<ModelDecorator> doOperation() async {
    print('Your token: ${Account.token}');
    _operationStartTime = DateTime.now();
    try {
      await _doRequest();
    } catch (e, r) {
      _ex = e;
      if (e is DioError) {
        var _e = _ex as DioError;
        httpStatusCode = _e.response.statusCode;
        url = _e.request.uri.toString();
      }
      _stack = r;
      _hasError = true;
    } finally {
      _operationEndTime = DateTime.now();
    }
    return this;
  }

  Future _doRequest();

  Model getInstance() => this.model;
  dynamic getResult() => this._result;

  String get log =>
      "[ ${this._operationStartTime.toIso8601String()} - ${this._operationEndTime.toIso8601String()} ]\n" +
      "\tUrl: $url\n" +
      "\tHttpStatusCode: ${this.httpStatusCode ?? 'null'}\n" +
      "\tServerCode: ${this.retCode ?? 'null'} ServerMessage: ${msg ?? 'null'}\n" +
      "Exception: $_ex\n" +
      "StackTrace: \n" +
      "${_stack.toString()?.replaceAll('\n', '\t\n')}";
}

class Create extends ModelDecorator {
  Create(Model model) : super(model);

  @override
  Future _doRequest() async {
    var dio = DioSingleton.getInstance();
    var response = await dio.post(
      '$apiUrl${super.model.endpoint}', // path
      data: this.toJson(),
    );
    super.httpStatusCode = response.statusCode;
    super.retCode = response.extra['ServerCode'];
    super.msg = response.extra['ServerMessage'];
    if (super.httpStatusCode != 200 || super.retCode != 0) {
      super._hasError = true;
      return;
    }
    super._result = response.data;
  }
}

class Update extends ModelDecorator {
  Update(Model model) : super(model);

  @override
  Future _doRequest() async {
    var dio = DioSingleton.getInstance();
    var response = await dio.put(
      '$apiUrl${super.model.endpoint}/${super.model.id}', // path
      data: this.toJson(),
    );
    super.httpStatusCode = response.statusCode;
    super.retCode = response.extra['ServerCode'];
    super.msg = response.extra['ServerMessage'];
    if (super.httpStatusCode != 200 || super.retCode != 0) {
      super._hasError = true;
      return;
    }
    super._result = response.data;
  }
}

class Destory extends ModelDecorator {
  Destory(Model model) : super(model);

  @override
  Future _doRequest() async {
    var dio = DioSingleton.getInstance();
    var response = await dio.delete(
      '$apiUrl${super.model.endpoint}/${super.model.id}',
    );
    super.httpStatusCode = response.statusCode;
    super.retCode = response.extra['ServerCode'];
    super.msg = response.extra['ServerMessage'];
    if (super.httpStatusCode != 200 || super.retCode != 0) {
      super._hasError = true;
      return;
    }
    super._result = response.data;
  }
}

class Confirm extends ModelDecorator {
  Confirm(Model model) : super(model);

  @override
  Future _doRequest() async {
    var dio = DioSingleton.getInstance();
    var response = await dio.get(
      '$apiUrl${super.model.endpoint}', // path
      queryParameters: this.toJson(),
    );
    super.httpStatusCode = response.statusCode;
    super.retCode = response.extra['ServerCode'];
    super.msg = response.extra['ServerMessage'];
    if (super.httpStatusCode != 200 || super.retCode != 0) {
      super._hasError = true;
      return;
    }
    super._result = response.data;
  }
}

class Get extends ModelDecorator {
  Get(Model model) : super(model);

  @override
  Future _doRequest() async {
    var dio = DioSingleton.getInstance();
    var response = await dio.get(
      '$apiUrl${super.model.endpoint}/${super.model.id}', // path
      queryParameters: this.toJson(),
    );
    super.httpStatusCode = response.statusCode;
    super.retCode = response.extra['ServerCode'];
    super.msg = response.extra['ServerMessage'];
    if (super.httpStatusCode != 200 || super.retCode != 0) {
      super._hasError = true;
      return;
    }
    super._result = response.data;
    model = model.fromJson(_result);
  }
}
