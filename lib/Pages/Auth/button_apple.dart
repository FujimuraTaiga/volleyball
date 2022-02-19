import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:sit_volleyball_app/Const/widget_size.dart';
import 'package:sit_volleyball_app/Entity/user.dart';

class AppleButton extends StatelessWidget {
  const AppleButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final userData = Provider.of<UserOperation>(context);

    return SizedBox(
      height: WidgetSize.signInButton.height,
      width: WidgetSize.signInButton.width,
      child: SignInWithAppleButton(
        text: 'Appleでサインイン',
        onPressed: () async {
          final appleCredential = await SignInWithApple.getAppleIDCredential(
            scopes: [
              AppleIDAuthorizationScopes.email,
              AppleIDAuthorizationScopes.fullName,
            ],
          );
          OAuthProvider oAuthProvider = OAuthProvider('apple.com');
          final credential = oAuthProvider.credential(
            idToken: appleCredential.identityToken,
            accessToken: appleCredential.authorizationCode,
          );

          final result = await FirebaseAuth.instance.signInWithCredential(credential);
          await userData.addUser(result.user!.uid,'UserName','');
        }
      ),
    );
  }
}
