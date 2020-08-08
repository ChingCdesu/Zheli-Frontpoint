import 'package:zl_app/api/model_operations.dart' as API;
import 'package:zl_app/api/models.dart' as API;
import 'package:zl_app/utils/crypto.dart';

void main(List<String> args) {
  // Demo: 注册
  API.User newUser = new API.User(
    username: '_ChingC',
    email: '172368@qq.com',
    phone: '12345678910',
    password: generateMd5('myPassword'),
  );

  var operation = API.Create(newUser).doOperation();
  if (!operation.hasError) {
    print(operation.getResult());
  } else {
    print(operation.log);
  }

  // Demo: 修改密码
  API.User updatePassword = new API.User(
    id: 1,
    password: generateMd5('changedPassword'),
  );
  operation = API.Update(updatePassword).doOperation();
  if (!operation.hasError) {
    print(operation.getResult());
  } else {
    print(operation.log);
  }

  // Demo: 退出登录
  API.User logout = new API.User(
    id: 1,
    nextToken: "",
  );
  operation = API.Update(logout).doOperation();
  if (!operation.hasError) {
    print(operation.getResult());
  } else {
    print(operation.log);
  }

  // Demo: 获取个人数据
  API.User getInfo = new API.User(id: 1);
  operation = API.Get(getInfo).doOperation();
  if (!operation.hasError) {
    print(operation.getResult());
  } else {
    print(operation.log);
  }
}
