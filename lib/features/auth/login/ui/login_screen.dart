import 'package:chat_socket/core/routing/routes.dart';
import 'package:chat_socket/core/theming/colors.dart';
import 'package:chat_socket/core/theming/syles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/helpers/functions/valid_Input.dart';
import '../../widgets/end_of_auth_screen.dart';
import '../../widgets/textfild_auth.dart';
import '../../widgets/title_auth.dart';
import '../logic/login_controller.dart';
import 'widget/textfiled_login.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isObscureText = true;
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
