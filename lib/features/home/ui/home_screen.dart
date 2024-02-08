import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constant/apiLink.dart';
import '../../../core/routing/routes.dart';
import '../../../core/theming/colors.dart';
import '../logic/home_controller.dart';
import '../../chat/ui/chat_screen.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(HomeController());
    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                child: CircleAvatar(
                  radius: 25,
                  // backgroundColor: Colors.black,
                  child: ClipOval(
                    child: CachedNetworkImage(
                      fit: BoxFit.cover,
                      width: 50,
                      height: 50,
                      imageUrl:
                      '${AppLink.server}/uploads/${controller.services.sharedPreferences.getString('userImage')}',
                      progressIndicatorBuilder: (context, url, progress) => Center(
                        child: CircularProgressIndicator(
                          value: progress.progress,
                        ),
                      ),
                    ),
                  ),
                ),
                onTap: () {
                  controller.services.sharedPreferences.remove("token");
                  Get.offAllNamed(AppRouter.loginScreen);

                },
              ),
              InkWell(
                onTap: () {
                  // Handle search icon tap
                },
                child: const Icon(
                  Icons.search,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            Container(
              height: 45,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: TabBar(
                controller: controller.tabController,
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  color: ColorsManager.mainBlue,
                ),
                labelColor: Colors.white,
                unselectedLabelColor: Colors.black,
                tabs: const [
                  Tab(text: 'Chat'),
                  Tab(text: 'Call'),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: controller.tabController,
                children:  [
                  ChatScreen(),
                  Center(
                    child: Text(
                      'Buy Now',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
