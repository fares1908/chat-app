import 'package:chat_socket/core/routing/routes.dart';
import 'package:chat_socket/core/theming/colors.dart';
import 'package:chat_socket/core/theming/syles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../widgets/textfild_auth.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isObscureText = true;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(top: 80.h, left: 10.w, right: 10.w),
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
                          CustomTextField(
                            text: 'Enter your email',
                            prefixIcon: Icons.email_outlined,
                            isNumber: false,
                            valid: (p0) {},
                          ),
                          SizedBox(
                            height: 12.h,
                          ),
                          CustomTextField(
                            prefixIcon: Icons.lock_outline,
                            suffixIcon: isObscureText?Icons.visibility_off_outlined:Icons.visibility_outlined,
                            text: 'Enter your password',
                            obscureText: isObscureText,
                            onTapIcon: () {
                              setState(() {
                                isObscureText=!isObscureText;
                              });
                            },
                            isNumber: false,
                            valid: (p0) {},
                          ),
                          SizedBox(
                            height: 12.h,
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: InkWell(
                              onTap: () {},
                              child: Text(
                                'Recovery Password',
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  fontSize: 14.sp,
                                  color: Colors.black,
                                ),
                              ),
                            ),
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
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                height: 45,
                                minWidth: double.infinity,
                                onPressed: () {},
                                child: const Text(
                                  'Sign In',
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
                      'New User ?',
                      style: TextStyle(
                        fontSize: 20.sp,
                        color: Colors.grey,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Get.offNamed(AppRouter.registerScreen);
                      },
                      child: Text(
                        'Create Account',
                        style: TextStyle(
                          color: Colors.black,
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
    );
  }
}
