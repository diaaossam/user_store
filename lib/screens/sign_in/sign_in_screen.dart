import 'package:flutter/material.dart';
import 'package:user_store/shared/helper/size_config.dart';
import 'components/body.dart';

class SignInScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Sign In"),),
      body: Body(),
    );
  }
}
