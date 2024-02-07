
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../core/helpers/functions/valid_Input.dart';
import '../../../../../core/theming/colors.dart';
import '../../../widgets/textfild_auth.dart';
import '../../logic/login_controller.dart';

class TextFieldLogin extends StatefulWidget {
  const TextFieldLogin({Key? key}) : super(key: key);

  @override
  State<TextFieldLogin> createState() => _TextFieldLoginState();
}

class _TextFieldLoginState extends State<TextFieldLogin> {
  bool isObscureText = true;
  final LoginControllerImpl controller = Get.put(LoginControllerImpl());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
              return validInput(val!, 5, 15, "Password");
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
                  borderRadius: BorderRadius.circular(16),
                ),
                height: 45,
                minWidth: double.infinity,
                onPressed: () async {
                  await controller.goToLogin();
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
    );
  }
}
