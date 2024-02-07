import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/helpers/functions/valid_Input.dart';
import '../../../../core/routing/routes.dart';
import '../../widgets/end_of_auth_screen.dart';
import '../../widgets/textfild_auth.dart';
import '../../widgets/title_auth.dart';
import '../logic/register_controller.dart';
import 'widget/textfileds_register.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(RegisterControllerImpl());
    return Scaffold(
      body: GetBuilder<RegisterControllerImpl>(
        builder: (controller) => SafeArea(
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
                        const TextFieldRegister(),
                      ],
                    ),
                  ),
                  EndOfAuthScreens(
                    firstText: 'Already have an Account ?',
                    secondText: 'Sign in',
                    onPressed: () => Get.offNamed(AppRouter.loginScreen),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
