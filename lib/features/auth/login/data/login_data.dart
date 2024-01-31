
import '../../../../core/class/crud.dart';

class LoginData{
  Crud crud;
  LoginData(this.crud);
  loginData(String email, String password) async {
    try {
      var response = await crud.postData('http://192.168.1.4:3000/api/users/login', {
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