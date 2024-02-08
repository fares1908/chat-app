import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:untitled9/features/chat/data/models/user_model.dart';
import '../../../core/constant/apiLink.dart';
import '../../../core/theming/colors.dart';
import '../../../core/theming/syles.dart';
import '../logic/individualpage_controller.dart';

class IndividualPage extends StatelessWidget {
  final IndividualPageController controller =
      Get.put(IndividualPageController());

  IndividualPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(controller.userModel),
      body: buildBody(context),
    );
  }

  AppBar buildAppBar(UserModel userModel) {
    return AppBar(
      backgroundColor: Colors.white,
      leadingWidth: 100,
      elevation: 0,
      leading: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
        child: Row(
          children: [
            GestureDetector(
              child: CircleAvatar(
                radius: 13,
                backgroundColor: const Color(0xFFE5F1FF),
                child: SvgPicture.asset('assets/svgs/Icon.svg'),
              ),
              onTap: () {
                Get.back();
              },
            ),
            SizedBox(width: 7.w),
            const Text(
              'Back',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: ColorsManager.mainBlue,
              ),
            )
          ],
        ),
      ),
      title: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          '${userModel.firstName} ${userModel.lastName}',
          style: TextStyles.font40BoldBlack.copyWith(fontSize: 16.sp),
        ),
      ),
      centerTitle: true,
      actions: [
        Padding(
          padding: EdgeInsets.all(8.0),
          child: CircleAvatar(
            radius: 25,
            backgroundColor: Colors.black,
            child: ClipOval(
              child: CachedNetworkImage(
                width: 40,
                height: 40,
                fit: BoxFit.cover,
                imageUrl: '${AppLink.server}/uploads/${userModel.avatar}',
                progressIndicatorBuilder: (context, url, progress) => Center(
                  child: CircularProgressIndicator(
                    value: progress.progress,
                  ),
                ),
                errorWidget: (context, url, error) => Icon(Icons.error_outline),
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget buildBody(BuildContext context) {
    return GetBuilder<IndividualPageController>(
      builder: (controller) => SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height - 220.h,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: controller.chatMessages.length,
                itemBuilder: (context, index) {
                  var currentItem = controller.chatMessages[index];
                  var isOwnMessage = currentItem.sendByMe ==
                      controller.myServices.sharedPreferences.getString('id');

                  return MessageWidget(
                    message: currentItem.message ?? '',
                    time: currentItem.time ?? '',
                    isOwnMessage: isOwnMessage,
                  );
                },
              ),
            ),
            buildMessageInput(),
          ],
        ),
      ),
    );
  }

  Widget buildMessageInput() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              child: Container(
                width: Get.width - 60,
                margin: const EdgeInsets.all(10),
                child: Card(
                  borderOnForeground: false,
                  shape: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(13),
                  ),
                  child: TextFormField(
                    controller: controller.msgController,
                    textAlignVertical: TextAlignVertical.center,
                    keyboardType: TextInputType.multiline,
                    maxLines: 5,
                    minLines: 1,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(13),
                        borderSide: const BorderSide(
                          color: Colors.white,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(13),
                        borderSide: const BorderSide(
                          color: Colors.white,
                        ),
                      ),
                      hintText: 'Message',
                      prefixIcon: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.emoji_emotions_outlined),
                      ),
                      suffixIcon: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () {
                              showBottomMenu();
                            },
                            icon: const Icon(Icons.camera_alt_outlined),
                          ),
                          IconButton(
                            onPressed: () {
                              controller.sendMessage(
                                  controller.msgController.text,
                                  controller.userModel.id!);
                              controller.msgController.clear();
                            },
                            icon: const Icon(Icons.send),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            buildMicButton(),
          ],
        ),
      ),
    );
  }

  Widget buildMicButton() {
    return const CircleAvatar(
      backgroundColor: ColorsManager.mainBlue,
      radius: 20,
      child: Icon(
        Icons.mic_none_rounded,
        color: Colors.white,
      ),
    );
  }

  Future<void> showBottomMenu() async {
    Get.bottomSheet(
      shape: const OutlineInputBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12), topRight: Radius.circular(12)),
          borderSide: BorderSide.none),
      Directionality(
        textDirection: TextDirection.ltr,
        child: Container(
          padding: const EdgeInsets.all(10),
          height: 180.h, // Adjust the height as needed
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                onTap: () async {
                  await controller.openCamera();
                  Get.back();
                },
                leading: const Icon(
                  Icons.camera_alt,
                  size: 40,
                ),
                title: Text(
                  'Take photo',
                  style: TextStyles.font16semiBoldBlack,
                ),
              ),
              ListTile(
                onTap: () async {
                  await controller.openGallery();
                  Get.back();
                },
                leading: const Icon(
                  Icons.image,
                  size: 40,
                ),
                title: Text(
                  'Choose photo from gallery',
                  style: TextStyles.font16semiBoldBlack,
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}

class MessageWidget extends StatelessWidget {
  final String message;
  final String time;
  final bool
      isOwnMessage; // Flag to indicate if the message is sent by the user

  const MessageWidget({
    required this.message,
    required this.time,
    required this.isOwnMessage,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 4.0,
      ),
      child: Align(
        alignment: isOwnMessage ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: isOwnMessage ? Colors.blue : Colors.grey,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                message,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                ),
              ),
              SizedBox(height: 4.0),
              Text(
                time,
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 12.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
