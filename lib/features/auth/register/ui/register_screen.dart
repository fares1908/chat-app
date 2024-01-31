import 'package:chat_socket/core/class/handling_data_view.dart';
import 'package:chat_socket/core/routing/routes.dart';
import 'package:chat_socket/core/theming/colors.dart';
import 'package:chat_socket/core/theming/syles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/helpers/functions/valid_Input.dart';
import '../../widgets/textfild_auth.dart';
import '../logic/register_controller.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool isObscureText = true;
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
                        Center(
                          child: RichText(
                            text: TextSpan(
                              text: 'Talky',
                              style: TextStyles.font40BoldBlack,
                              children: const [
                                TextSpan(
                                  text: '.',
                                  style: TextStyle(
                                    color: ColorsManager.mainBlue,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 100.h,
                        ),
                        Padding(
                          padding: EdgeInsets.all(15.h),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: CustomTextField(
                                      controller: controller.firstname,
                                      text: 'First name',
                                      isNumber: false,
                                      valid: (val) {
                                        return validInput(
                                            val!, 3, 15, "First name");
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5.w,
                                  ),
                                  Expanded(
                                    child: CustomTextField(
                                      controller: controller.lastname,
                                      text: 'Last name',
                                      isNumber: false,
                                      valid: (val) {
                                        return validInput(
                                            val!, 3, 15, "Last name");
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 12.h,
                              ),
                              CustomTextField(
                                controller: controller.email,
                                text: 'Enter your email',
                                prefixIcon: Icons.email_outlined,
                                isNumber: false,
                                valid: (val) {
                                  return validInput(val!, 3, 115, "Email");
                                },
                              ),
                              SizedBox(
                                height: 12.h,
                              ),
                              CustomTextField(
                                controller: controller.password,
                                prefixIcon: Icons.lock_outline,
                                suffixIcon: isObscureText
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined,
                                text: 'Enter your password',
                                obscureText: isObscureText,
                                onTapIcon: () {
                                  setState(() {
                                    isObscureText = !isObscureText;
                                  });
                                },
                                isNumber: false,
                                valid: (val) {
                                  return validInput(
                                      val!, 5, 15, "Password");
                                },
                              ),
                              SizedBox(
                                height: 12.h,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: ColorsManager.mainBlue,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Center(
                                  child: MaterialButton(
                                    shape: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: ColorsManager.mainBlue,
                                      ),
                                      borderRadius:
                                      BorderRadius.circular(16),
                                    ),
                                    height: 45,
                                    minWidth: double.infinity,
                                    onPressed: () async {
                                      await controller.goToRegister();
                                    },
                                    child: const Text(
                                      'Sign Up',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already have an Account ?',
                          style: TextStyle(
                            fontSize: 20.sp,
                            color: Colors.grey,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Get.offNamed(AppRouter.loginScreen);
                          },
                          child: Text(
                            'Sign in',
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Poppins',
                              fontSize: 15.sp,
                            ),
                          ),
                        ),
                      ],
                    ),
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
