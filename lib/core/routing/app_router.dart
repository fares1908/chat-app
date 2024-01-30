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
import 'routes.dart';

List<GetPage<dynamic>> ?routes=[
  GetPage(name: '/' , page:() =>LoginScreen()),
  GetPage(name: AppRouter.registerScreen, page:() =>  RegisterScreen()),
];