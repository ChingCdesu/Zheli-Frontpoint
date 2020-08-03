import 'package:zl_app/api/dio_singleton.dart';
import 'package:zl_app/api/models.dart';

abstract class ModelDecorator extends Model {
  final Model model;

  int httpStatusCode, retCode;
  String msg;
  DateTime _operationStartTime, _operationEndTime;
  bool _hasError = false;
  bool get hasError => this._hasError;
  Exception _ex;
  StackTrace _stack;
  dynamic _result;

  ModelDecorator(this.model) : super(model.endpoint);
  ModelDecorator doOperation();
  Model getInstance() => this.model;
  dynamic getResult() => this._result;

  String get log =>
      "[ ${this._operationStartTime.toIso8601String()} - ${this._operationEndTime.toIso8601String()} ]\n" +
      "\tHttpStatusCode: ${this.httpStatusCode ?? 'null'}\n" +
      "\tServerCode: ${this.retCode ?? 'null'} ServerMessage: ${msg ?? 'null'}\n" +
      "Exception: $_ex\n" +
      "StackTrace: \n" +
      // ignore: can_be_null_after_null_aware
      "${_stack?.toString().replaceAll('\n', '\t\n')}";
}

class AddModel extends ModelDecorator {
  AddModel(Model model) : super(model);

  @override
  Model fromJson(Map<String, dynamic> json) => super.model.fromJson(json);

  @override
  Map<String, dynamic> toJson() => super.model.toJson();

  @override
  ModelDecorator doOperation() {
    super._operationStartTime = DateTime.now();
    try {
      _doRequest();
    } catch (e, r) {
      super._ex = e;
      super._stack = r;
      super._hasError = true;
    } finally {
      super._operationEndTime = DateTime.now();
    }
    return this;
  }

  void _doRequest() async {
    var dio = DioSingleton.getInstance();
    var response = await dio.post(
      '$apiUrl${super.model.endpoint}/add', // path
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
