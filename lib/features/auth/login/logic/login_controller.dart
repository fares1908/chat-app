// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../../../../core/class/status_request.dart';
// import '../../../../core/routing/routes.dart';
//
// abstract class LoginController extends GetxController {
//   login();
//   goToSignup();
//   goToRecoveryPassword();
// }
// class LoginControllerImpl extends LoginController {
//   late TextEditingController email;
//   StatusRequest statusRequest = StatusRequest.none;
//   LoginData loginData = LoginData(Get.find());
//   late TextEditingController password;
//
//   MyServices services = Get.find();
//   IconData showPasswordIcon = Icons.visibility_off_outlined;
//   GlobalKey<FormState> formState = GlobalKey<FormState>();
//
//
//
//   @override
//   goToSignup() {
//     Get.offNamed(AppRouter.register);
//   }
//
//   @override
//   login() async {
//     var formdata = formState.currentState;
//     if (formdata!.validate()) {
//       statusRequest = StatusRequest.loading;
//       update();
//       var response = await loginData.loginData(password.text, email.text);
//       print("=============================== Controller $response ");
//       statusRequest = handlingData(response);
//       if (StatusRequest.success == statusRequest) {
//         if (response["status"] == 'success') {
//           if (response['data']['users_approve'] == "1") {
//             services.sharedPreferences
//                 .setString('id', response['data']['users_id']);
//             services.sharedPreferences
//                 .setString('email', response['data']['users_email']);
//             services.sharedPreferences
//                 .setString('username', response['data']['users_name']);
//             services.sharedPreferences.setString('step', "2");
//             // data.addAll(response['data']);
//             print("=============================== $statusRequest");
//             Get.offNamed(AppRouter.home);
//           } else {
//             Get.offNamed(AppRouter.verifyCodeSignUp, arguments: {
//               "email": email.text,
//             });
//           }
//         } else {
//           Get.defaultDialog(title: "Warning", middleText: "Email or Password  is incorrect");
//           statusRequest = StatusRequest.failure;
//         }
//       }
//       update();
//     } else {}
//   }
//
//   @override
//   void onInit() {
//     email = TextEditingController();
//     password = TextEditingController();
//   }
//
//   @override
//   void dispose() {
//     email.dispose();
//     password.dispose();
//     super.dispose();
//   }
// }