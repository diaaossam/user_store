import 'package:flutter/material.dart';
import 'package:user_store/shared/styles/colors.dart';

import '../helper/size_config.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Function press;
  final double? height;
  final double? width;

  CustomButton(
      {required this.text, required this.press, this.height, this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: kPrimaryColor,
        borderRadius: BorderRadius.circular(getProportionateScreenHeight(15)),
      ),
      height: height == null ? getProportionateScreenHeight(60.0) : height,
      width: width == null ? double.infinity : width,
      child: MaterialButton(
        child: Text(
          text,
          style: TextStyle(
            fontSize: getProportionateScreenHeight(18.0),
            color: Colors.white
          ),
        ),
        onPressed: press as void Function()?,
      ),
    );
  }
}
