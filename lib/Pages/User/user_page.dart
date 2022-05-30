import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sit_volleyball_app/Entity/User/user_provider.dart';

import 'package:sit_volleyball_app/Pages/User/user_name.dart';
import 'package:sit_volleyball_app/Pages/User/user_id.dart';
import 'package:sit_volleyball_app/Pages/User/user_image.dart';
import 'package:sit_volleyball_app/Pages/User/user_profile_form.dart';

class UserPage extends StatelessWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    user.read();
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                icon: const Icon(Icons.settings),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => UserProfileForm()));
                },
              ),
            ],
          ),
          const UserImage(),
          const SizedBox(height: 20.0),
          UserName(user.data.name),
          const SizedBox(height: 20.0),
          CopyableID(user.data.id),
        ],
      ),
    );
  }
}
