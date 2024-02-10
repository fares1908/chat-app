import 'package:untitled9/core/class/crud.dart';

import '../../../core/constant/apiLink.dart';

class IndividualData{
  Crud crud;
  IndividualData(this.crud);
  uploadImage(String path)async{
    try {
      var response = await crud.postData(AppLink.imagePath, {
        "img": path,
      });
      return response.fold((l) => l, (r) => r);
    } catch (e) {
      print('Error during login: $e');
      return 'Error during login: $e';
    }
  }
}