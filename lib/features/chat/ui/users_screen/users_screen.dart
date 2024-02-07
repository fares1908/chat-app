import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../core/class/handling_data_view.dart';
import '../../../../core/constant/apiLink.dart';
import '../../../../core/theming/colors.dart';
import '../../../../core/theming/syles.dart';
import '../../logic/chat_controller.dart';

class UserScreen extends StatelessWidget {
  UserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ChatController());
    return Scaffold(
        appBar: AppBar(
          backgroundColor: ColorsManager.mainBlue,
          title: Text('Enter to call contacts',
              style:
                  TextStyles.font16semiBoldBlack.copyWith(color: Colors.white)),
        ),
        body: GetBuilder<ChatController>(
            builder: (controller) => HandlingDataView(
                  statusRequest: controller.statusRequest,
                  widget: ListView.separated(
                    itemBuilder: (context, index) => InkWell(
                      onTap: () {},
                      child: Container(
                        child: Row(
                          children: [
                            Expanded(
                              child: CircleAvatar(
                                radius: 25,
                                backgroundColor: Colors.black,
                                child: ClipOval(
                                  child: CachedNetworkImage(
                                    imageUrl:
                                        '${AppLink.server}/${controller.data[index].avatar}',
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
                            ),
                            Expanded(
                                flex: 2,
                                child: ListTile(
                                  title: Text(
                                    '${controller.data[index].firstName ?? ""} ${controller.data[index].lastName ?? ""}',
                                    style: TextStyles.font16semiBoldBlack,
                                  ),
                                  subtitle: Text(
                                    controller.data[index].email! ,
                                  ),
                                ))
                          ],
                        ),
                      ),
                    ),
                    separatorBuilder: (context, index) => Divider(
                      thickness: 2,
                    ),
                    itemCount: controller.data.length,
                  ),
                )));
  }
}
