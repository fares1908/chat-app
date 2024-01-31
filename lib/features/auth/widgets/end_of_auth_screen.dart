import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EndOfAuthScreens extends StatelessWidget {
  const EndOfAuthScreens({super.key, this.onPressed, required this.firstText, required this.secondText});
  final void Function()? onPressed;
  final String firstText;
  final String secondText;
  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            firstText,
            style: TextStyle(
              fontSize: 20.sp,
              color: Colors.grey,
            ),
          ),
          TextButton(
            onPressed: onPressed,
            child: Text(
             secondText,
              style: TextStyle(
                color: Colors.black,
                fontSize: 15.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
