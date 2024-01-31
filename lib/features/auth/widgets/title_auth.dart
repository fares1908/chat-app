import 'package:flutter/material.dart';

import '../../../core/theming/colors.dart';
import '../../../core/theming/syles.dart';

class TitleAuth extends StatelessWidget {
  const TitleAuth({super.key});

  @override
  Widget build(BuildContext context) {
    return     Center(
      child: RichText(
        text: TextSpan(
          text: 'Talky',
          style: TextStyles.font40BoldBlack,
          children: const [
            TextSpan(
              text: '.',
              style: TextStyle(
                color: ColorsManager.mainBlue,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
