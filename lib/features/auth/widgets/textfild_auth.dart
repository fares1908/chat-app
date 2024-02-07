

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {super.key,
        this.titleText,
        this.controller,
        this.suffixIcon,
        this.onTapIcon,
        this.obscureText = false,
        required this.valid,
        required this.isNumber, this.text, this.readOnly=false, this.prefixIcon});
  final String? titleText;
  final TextEditingController? controller;
  final IconData? suffixIcon;
  final IconData? prefixIcon;
  final void Function()? onTapIcon;
  final bool? obscureText;
  final String ?text;
  final String? Function(String?) valid;
  final bool isNumber;
  final bool ? readOnly;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(

          keyboardType: isNumber == true
              ? const TextInputType.numberWithOptions(decimal: true)
              : TextInputType.text,
          validator: valid,
          obscureText: obscureText ?? false,
          controller: controller,

          style: TextStyle(

            fontSize: 12.sp,
            color: const Color(0xFFAAB0B7)
          ),
          cursorColor: const Color(0xFFAAB0B7),
          decoration: InputDecoration(
            prefixIcon:  Icon(prefixIcon),
            hintText: text,
            hintStyle: TextStyle(
              color:  const Color(0xFFAAB0B7)
            ),
            suffixIcon: InkWell(
              onTap: onTapIcon,
              child: Icon(suffixIcon),
            ),
            focusColor: Colors.grey,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide.none,
            ),
            filled: true,
            fillColor: Colors.grey.withOpacity(.14),
          ),
          readOnly: readOnly ?? false,
        ),
      ],
    );
  }
}
