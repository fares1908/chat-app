// import 'package:chat_socket/core/routing/routes.dart';
// import 'package:chat_socket/features/auth/register/ui/register_screen.dart';
// import 'package:flutter/material.dart';
//
// import '../../features/auth/login/ui/login_screen.dart';
//
// class AppRouter {
//   Route generateRoute(RouteSettings settings) {
//     switch (settings.name) {
//       case Routes.registerScreen:
//         return MaterialPageRoute(
//           builder: (context) => RegisterScreen(),
//         );
//
//       case Routes.loginScreen:
//         return MaterialPageRoute(
//           builder: (context) => LoginScreen(),
//         );
//
//       default:
//         return MaterialPageRoute(
//           builder: (context) => Scaffold(
//             body: Center(
//               child: Text('No route defined for ${settings.name}'),
//             ),
//           ),
//         );
//     }
//   }
// }

import 'package:get/get.dart';

import '../../features/auth/login/ui/login_screen.dart';
import '../../features/auth/register/ui/register_screen.dart';
import '../../features/chat/ui/users_screen/users_screen.dart';
import '../../features/home/ui/home_screen.dart';
import '../../features/individual_page/ui/individual_page.dart';
import '../class/my_middel_ware.dart';
import 'routes.dart';

List<GetPage<dynamic>> ?routes=[
  GetPage(name: '/' , page:() =>const LoginScreen(),middlewares: [
    MyMiddleWare()
  ]),
  GetPage(name: AppRouter.registerScreen, page:() =>  const RegisterScreen()),
  GetPage(name: AppRouter.homeScreen, page:() =>  HomeScreen()),
  GetPage(name: AppRouter.individualPage, page:() =>  IndividualPage()),
  GetPage(name: AppRouter.userScreen, page:() =>  UserScreen())
];