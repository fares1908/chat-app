import 'package:chat_socket/core/routing/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../widgets/end_of_auth_screen.dart';
import '../../widgets/title_auth.dart';
import '../logic/login_controller.dart';
import 'widget/textfiled_login.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(LoginControllerImpl());
    return Scaffold(
      body: GetBuilder<LoginControllerImpl>(
        builder: (controller) =>  SafeArea(
          child: Padding(
            padding: EdgeInsets.only(top: 80.h, left: 10.w, right: 10.w),
            child: Form(
              key: controller.formState,
              child: Column(
                children: [
                  Expanded(
                    child: ListView(
                      children: [
                        const TitleAuth(),
                        SizedBox(
                          height: 100.h,
                        ),
                        const TextFieldLogin(),
                      ],
                    ),
                  ),
                  EndOfAuthScreens(
                    firstText:   'New User ?',
                    secondText:  'Create Account',
                    onPressed: () => Get.offNamed(AppRouter.registerScreen),
                  ),
                ],
              ),
            ),
          ),
        ),

      ),
    );
  }
}
