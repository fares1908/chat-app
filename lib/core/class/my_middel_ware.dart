import 'package:chat_socket/features/auth/login/ui/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import '../routing/routes.dart';
import 'my_services.dart';

class MyMiddleWare extends GetMiddleware {
  @override
  int get priority => 0;

  MyServices myServices = Get.find();

  @override
  RouteSettings? redirect(String? route) {
    final token = myServices.sharedPreferences.getString('token');
    if (route == AppRouter.loginScreen) {
      return null;
    }
    if (token != null && !JwtDecoder.isExpired(token)) {
      return const RouteSettings(name: AppRouter.homeScreen);

    } else {
      // No token or expired token, redirect to login screen
      return const RouteSettings(name: AppRouter.loginScreen);
    }
  }



}
