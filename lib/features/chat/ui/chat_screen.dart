import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:untitled9/core/class/handling_data_view.dart';
import 'package:untitled9/features/chat/data/models/user_model.dart';

import '../../../core/constant/apiLink.dart';
import '../../../core/routing/routes.dart';
import '../../../core/theming/colors.dart';
import '../../../core/theming/syles.dart';

import '../data/models/chat_model.dart';
import '../logic/chat_controller.dart';

class ChatScreen extends StatelessWidget {
  final ChatController chatController = Get.put(ChatController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<ChatController>(
        builder:(controller) =>  HandlingDataView(
          statusRequest: controller.statusRequest,
          widget:ListView.separated(
            itemBuilder: (context, index) =>
                buildChatTile(context, chatController.data[index]),
            separatorBuilder: (context, index) => const Divider(),
            itemCount: chatController.data.length,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: ColorsManager.mainBlue,
        onPressed: () {
          Get.toNamed(AppRouter.userScreen);
          // Handle FloatingActionButton tap
        },
        child: const Icon(Icons.message_outlined),
      ),
    );
  }

  Widget buildChatTile(BuildContext context, UserModel userModel) {
    return InkWell(
      onTap: () {
        // Pass userModel to the individualPage
        Get.toNamed(AppRouter.individualPage, arguments: {"userModel":userModel});
      },
      child: ListTile(
        subtitle: Row(
          children: [
            Icon(
              Icons.done_all,
              size: 17,
            ),
            SizedBox(
              width: 5.w,
            ),
            Text('fares'),
          ],
        ),
        leading: CircleAvatar(
          radius: 25,
          backgroundColor: Colors.black,
          child: ClipOval(
            child: CachedNetworkImage(
              width: 50,
              height: 50,
              fit: BoxFit.cover,
              imageUrl:
              '${AppLink.server}/uploads/${userModel.avatar}',
              progressIndicatorBuilder:
                  (context, url, progress) => Center(
                child: CircularProgressIndicator(
                  value: progress.progress,
                ),
              ),
              errorWidget: (context, url, error) => Icon(
                  Icons.error_outline
              ),
            ),
          ),
        ),
        trailing: GestureDetector(
          child: const Icon(
            Icons.arrow_forward_ios,
            size: 15,
          ),
        ),
        title: Padding(
          padding: EdgeInsets.only(bottom: 15.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${userModel.firstName} ${userModel.lastName}',
                style: TextStyles.font16semiBoldBlack,
              ),
              Text(
                '12.0',
                style: TextStyles.font12mediumGray,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

