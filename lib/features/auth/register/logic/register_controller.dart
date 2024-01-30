import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/class/status_request.dart';


abstract class RegisterController extends GetxController {
  goToRegister();
  goToLogin();
}

class RegisterControllerImpl extends RegisterController {
  late TextEditingController email;
  late TextEditingController password;
  late TextEditingController firstname;
  late TextEditingController lastname;
  StatusRequest statusRequest = StatusRequest.none;
  RegisterData registerData = RegisterData(Get.find());
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  @override
  goToRegister()async {
    if (formState.currentState!.validate()) {
      statusRequest = StatusRequest.loading;
      update();
      var response =
      await registerData.registerData(email.text, password.text, name.text);
      print("=============================== Controller $response ");
      statusRequest = handlingData(response);
      if (StatusRequest.success == statusRequest) {
        if (response['status'] == 'success') {
          print("=============================== $statusRequest");
          Get.offNamed(AppRouter.verifyCodeSignUp,
              arguments: {"email": email.text});
        }else {
          Get.defaultDialog(
              title:  "Warning",
              middleText: "Phone Number Or Email Already Was Taken");
          statusRequest = StatusRequest.failure;
        }
      }
      update();
    }
    else{}
  }

  @override
  goToLogin() {
    Get.offNamed(AppRouter.login);
  }


  @override
  void onInit() {
    email = TextEditingController();
    password = TextEditingController();
    name = TextEditingController();

    super.onInit();
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    name.dispose();

    super.dispose();
  }
}
