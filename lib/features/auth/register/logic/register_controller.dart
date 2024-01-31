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
  goToLogin() {
    Get.offNamed(AppRouter.loginScreen);
  }

  @override
  goToRegister() async {
    if (formState.currentState!.validate()) {
      statusRequest = StatusRequest.loading;
      update();
      try {
        var response = await registerData.registerData(
            email.text, password.text, firstname.text, lastname.text);
        print("=============================== Controller $response");
        statusRequest = handlingData(response);
        if (StatusRequest.success == statusRequest) {
          // Check if the status in the response is 'success'
          if (response['status'] == 'success') {
            goToLogin();

            print("=============================== $statusRequest");
          } else {
            statusRequest = StatusRequest.failure;
          }
        } else {
          Get.snackbar('Warning', 'Email already exists');
          print('Error');
        }

        update();
      } catch (e) {
        // Handle any exceptions that may occur during the registration process
        print('Error during registration: $e');
        // Update the statusRequest to indicate failure
        statusRequest = StatusRequest.failure;
        // Update the UI if needed
        update();
      }
    } else {
      Get.snackbar('Error', 'Registration failed. Please try again.');
    }
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
