
import '../../../../core/class/crud.dart';

class RegisterData{
 Crud crud;
  RegisterData(this.crud);
 registerData(String email, String password, String firstName, String lastName) async {
   try {
     var response = await crud.postData('http://192.168.1.4:3000/api/users/register', {
       "email": email,
       "password": password,
       "firstName": firstName,
       "lastName": lastName,
     });
     return response.fold((l) => l, (r) => r);
   } catch (e) {
     print('Error during registration: $e');
     return 'Error during registration: $e';
   }
 }


}