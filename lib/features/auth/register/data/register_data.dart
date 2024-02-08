
import '../../../../core/class/crud.dart';
import '../../../../core/constant/apiLink.dart';

class RegisterData{
 Crud crud;
  RegisterData(this.crud);
 registerData(String email, String password, String firstName, String lastName) async {
   try {
     var response = await crud.postData(AppLink.register, {
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