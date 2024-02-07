import '../../../core/class/crud.dart';
import '../../../core/constant/apiLink.dart';

class ChatData{
  Crud crud;
  ChatData(this.crud);
 getUser(String token )async{
   try {
     var response = await crud.getDataWithAuthorization('${AppLink.server}/api/users', token);
     return response.fold((l) => l, (r) => r);
   } catch (e) {
     print('Error during login: $e');
     return 'Error during login: $e';
   }
 }
}