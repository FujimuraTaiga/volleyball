import 'package:flutter/material.dart';

import 'package:sit_volleyball_app/Pages/Setting/Widgets/delete_account_button.dart';
import 'package:sit_volleyball_app/Pages/Setting/Widgets/log_out_button.dart';

class DrawerMenu extends StatelessWidget{

  const DrawerMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          LogOutButton(),
          DeleteAccountButton(),
        ],
      ),
    );
  }

}
