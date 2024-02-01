import 'package:chat_socket/core/theming/colors.dart';
import 'package:chat_socket/core/theming/font_weight_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextStyles {
  static TextStyle font40BoldBlack=TextStyle(
    fontSize: 50.sp,
    color: Colors.black,
    fontWeight: FontWeightHelper.bold

  );
  static TextStyle font16semiBoldBlack=TextStyle(
      fontSize:18.sp,
      color: Colors.black,
      fontWeight: FontWeightHelper.semiBold

  );
  static TextStyle font12mediumGray=TextStyle(
      fontSize:12.sp,
      color: ColorsManager.semiGray,
      fontWeight: FontWeightHelper.medium

  );
}