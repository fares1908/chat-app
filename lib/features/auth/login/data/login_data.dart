
import 'package:untitled9/core/constant/apiLink.dart';

import '../../../../core/class/crud.dart';

class LoginData{
  Crud crud;
  LoginData(this.crud);
  loginData(String email, String password) async {
    try {
      var response = await crud.postData('${AppLink.server}/api/users/login', {
        "email": email,
        "password": password,
      });
      return response.fold((l) => l, (r) => r);
    } catch (e) {
      print('Error during login: $e');
      return 'Error during login: $e';
    }
  }


}