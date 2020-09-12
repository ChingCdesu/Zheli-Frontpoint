import 'package:zl_app/api/dio_singleton.dart';
import 'package:zl_app/api/models.dart';

abstract class ModelDecorator extends Model {
  final Model model;

  int httpStatusCode;
  dynamic retCode;
  String msg;
  DateTime _operationStartTime, _operationEndTime;
  bool _hasError = false;
  bool get hasError => this._hasError;
  Exception _ex;
  StackTrace _stack;
  dynamic _result;

  Model fromJson(Map<String, dynamic> json) => model.fromJson(json);
  Map<String, dynamic> toJson() => model.toJson();

  ModelDecorator(this.model) : super(model.endpoint);
  Future<ModelDecorator> doOperation();
  Model getInstance() => this.model;
  dynamic getResult() => this._result;

  String get log =>
      "[ ${this._operationStartTime.toIso8601String()} - ${this._operationEndTime.toIso8601String()} ]\n" +
      "\tHttpStatusCode: ${this.httpStatusCode ?? 'null'}\n" +
      "\tServerCode: ${this.retCode ?? 'null'} ServerMessage: ${msg ?? 'null'}\n" +
      "Exception: $_ex\n" +
      "StackTrace: \n\t" +
      "${_stack.toString()?.replaceAll('\n', '\t\n')}";
}

class Create extends ModelDecorator {
  Create(Model model) : super(model);

  @override
  Future<ModelDecorator> doOperation() async {
    super._operationStartTime = DateTime.now();
    try {
      await await _doRequest();
    } catch (e, r) {
      super._ex = e;
      super._stack = r;
      super._hasError = true;
    } finally {
      super._operationEndTime = DateTime.now();
    }
    return this;
  }

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
  Future<ModelDecorator> doOperation() async {
    super._operationStartTime = DateTime.now();
    try {
      await _doRequest();
    } catch (e, r) {
      super._ex = e;
      super._stack = r;
      super._hasError = true;
    } finally {
      super._operationEndTime = DateTime.now();
    }
    return this;
  }

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
  Future<ModelDecorator> doOperation() async {
    super._operationStartTime = DateTime.now();
    try {
      await _doRequest();
    } catch (e, r) {
      super._ex = e;
      super._stack = r;
      super._hasError = true;
    } finally {
      super._operationEndTime = DateTime.now();
    }
    return this;
  }

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
  Future<ModelDecorator> doOperation() async {
    super._operationStartTime = DateTime.now();
    try {
      await _doRequest();
    } catch (e, r) {
      super._ex = e;
      super._stack = r;
      super._hasError = true;
    } finally {
      super._operationEndTime = DateTime.now();
    }
    return this;
  }

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
  Future<ModelDecorator> doOperation() async {
    super._operationStartTime = DateTime.now();
    try {
      await _doRequest();
    } catch (e, r) {
      super._ex = e;
      super._stack = r;
      super._hasError = true;
    } finally {
      super._operationEndTime = DateTime.now();
    }
    return this;
  }

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
  }
}
