import 'package:flutter/material.dart';
import 'package:user_store/screens/phone_screen/phone_screen.dart';
import 'package:user_store/shared/components/social_card.dart';
import 'package:user_store/shared/helper/methods.dart';
import '../../../shared/components/no_account_text.dart';
import '../../../shared/helper/size_config.dart';
import 'sign_form.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: SizeConfig.bodyHeight * 0.04),
            Text(
              "Welcome Back",
              style: TextStyle(
                color: Colors.black,
                fontSize: getProportionateScreenWidth(28),
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "Sign in with your email and password  \nor continue with social media",
              textAlign: TextAlign.center,
            ),
            SizedBox(height: SizeConfig.bodyHeight * 0.08),
            SignForm(),
            SizedBox(height: SizeConfig.bodyHeight * 0.08),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SocialCard(
                  icon: "assets/icons/google-icon.svg",
                  press: () {},
                ),
                SocialCard(
                  icon: "assets/icons/facebook-2.svg",
                  press: () {
                  },
                ),
                SocialCard(
                  icon: "assets/icons/Phone.svg",
                  press: () {
                    navigateTo(context, PhoneVerifactionScreen());
                  },
                ),
              ],
            ),
            SizedBox(height: getProportionateScreenHeight(20)),
            NoAccountText(),
          ],
        ),
      ),
    );
  }
}
