import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/class/status_request.dart';
import '../../../../core/helpers/functions/handling_data.dart';
import '../../../../core/routing/routes.dart';
import '../data/register_data.dart';

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
  goToRegister() async {
    if (formState.currentState!.validate()) {
      statusRequest = StatusRequest.loading;
      update();
      var response = await registerData.registerData(
          email.text, password.text, firstname.text, lastname.text);
      print("=============================== Controller $response ");
      statusRequest = handlingData(response);
      if (StatusRequest.success == statusRequest) {
        if (response['status'] == 'success') {
          print("=============================== $statusRequest");
        } else {
          Get.defaultDialog(
              title: "Warning", middleText: "Email Already Was Taken");
          statusRequest = StatusRequest.failure;
        }
      }
      update();
    } else {}
  }

  @override
  goToLogin() {
    Get.offNamed(AppRouter.loginScreen);
  }

  @override
  @override
  void onInit() {
    print('Controller initialized');
    email = TextEditingController();
    password = TextEditingController();
    firstname = TextEditingController();
    lastname = TextEditingController();

    super.onInit();
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    firstname.dispose();
    lastname.dispose();

    super.dispose();
  }
}
