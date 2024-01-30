import 'package:chat_socket/core/routing/app_router.dart';
import 'package:chat_socket/features/auth/login/ui/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'core/routing/routes.dart';
import 'core/theming/colors.dart';

void main() {
  runApp(MyApp(
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      builder: (BuildContext c, child) => GetMaterialApp(
        title: 'Flutter Demo',
        getPages: routes,
        theme: ThemeData(
            primaryColor: ColorsManager.mainBlue,
            scaffoldBackgroundColor: Colors.white),
        debugShowCheckedModeBanner: false,

      ),
    );
  }
}
