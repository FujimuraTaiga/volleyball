import 'package:flutter/material.dart';
import 'package:sit_volleyball_app/Const/widget_size.dart';

class UserImage extends StatelessWidget {
  const UserImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: WidgetSize.userImageInMyPage.width,
      height: WidgetSize.userImageInMyPage.height,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          fit: BoxFit.fill,
          image: AssetImage('assets/images/volleyball.png'),
        ),
      ),
    );
  }
}
