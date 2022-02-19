import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:sit_volleyball_app/Const/widget_size.dart';

import 'package:sit_volleyball_app/Pages/Auth/Mail/mail_login_page.dart';

class MailButton extends StatelessWidget {
  const MailButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: WidgetSize.signInButton.height,
      width: WidgetSize.signInButton.width,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.white,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.mail,
                color: Colors.black,
              ),
              Text(
                'メール',
                style: GoogleFonts.kosugiMaru(
                  textStyle: Theme.of(context).textTheme.headline4,
                  color: Colors.black,
                  fontSize: 18,
                ),
              ),
            ],
          ),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MailLoginPage())
            );
          }
      ),
    );
  }
}
