import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/theming/syles.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 18.h, ),
      child: Column(
        children: [
          Expanded(
            child: ListView.separated(
              itemBuilder: (context, index) => ListTile(
                subtitle: const Text('fares'),
                leading: const CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.black,
                ),
                trailing: GestureDetector(
                  child: const Icon(
                    Icons.arrow_forward_ios,
                    size: 15,
                  ),
                ),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Item $index',
                      style: TextStyles.font16semiBoldBlack,
                    ),
                    Text(
                      '2min ago',
                      style: TextStyles.font12mediumGray,
                    ),
                  ],
                ),
              ),
              separatorBuilder: (context, index) => const Divider(),
              itemCount: 12,
            ),
          ),
        ],
      ),
    );
  }
}
