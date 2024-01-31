
import 'package:chat_socket/core/routing/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


import 'my_services.dart';


class MyMiddleWare extends GetMiddleware {
  @override
  int? get priority => 0;
  MyServices  myServices=Get.find();
  @override
  RouteSettings ?redirect(String ? route)
  {
    // if(myServices.sharedPreferences.getString("step")=="2"){
    //   return const RouteSettings(name: AppRouter.home );
    // }
    // if (myServices.sharedPreferences.getString("step")=="1"){
    //   return const RouteSettings(name: AppRouter.login);
    // }
  }

}
