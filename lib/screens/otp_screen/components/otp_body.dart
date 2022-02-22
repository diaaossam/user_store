import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:user_store/screens/complete_profile/complete_profile_screen.dart';
import 'package:user_store/shared/helper/methods.dart';
import 'package:user_store/shared/widgets/custom_widgets.dart';
import '../../../models/phone_model.dart';
import '../../../shared/components/custom_button.dart';
import '../../../shared/helper/size_config.dart';
import '../../../shared/styles/colors.dart';
import '../../phone_screen/components/phone_content.dart';
import '../../phone_screen/cubit/phone_cubit.dart';
import '../../phone_screen/cubit/phone_state.dart';


class OtpBody extends StatelessWidget {
  var pinCode = TextEditingController();
  String number;


  OtpBody(this.number);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PhoneCubit, PhoneState>(
      listener: (context, state) {
        if (state is Loading) {
          showCustomProgressIndicator(context);
        }

        if (state is PhoneOTPVerified) {
          Navigator.pop(context);
          navigateToAndFinish(context,CompleteProfileScreen());
        }
        if (state is ErrorOccurred) {
          String errorMsg = (state).errorMsg;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(errorMsg),
              backgroundColor: Colors.black,
              duration: Duration(seconds: 5),
            ),
          );
        }
      },
      builder: (context, state) {
       PhoneModel model1 =  PhoneModel(
            image: 'assets/images/phone2.png',
            widget: PinCodeTextField(
              controller: pinCode,
              appContext: context,
              autoFocus: true,
              cursorColor: Colors.black,
              keyboardType: TextInputType.number,
              length: 6,
              obscureText: false,
              animationType: AnimationType.scale,
              pinTheme: PinTheme(
                shape: PinCodeFieldShape.box,
                borderRadius: BorderRadius.circular(5),
                fieldHeight: 50,
                fieldWidth: 40,
                borderWidth: 1,
                activeColor: kPrimaryColor,
                inactiveColor: kPrimaryColor,
                inactiveFillColor: Colors.white,
                activeFillColor: kPrimaryLightColor,
                selectedColor: kPrimaryColor,
                selectedFillColor: Colors.white,
              ),
              animationDuration: Duration(milliseconds: 300),
              backgroundColor: Colors.white,
              enableActiveFill: true,
              onChanged: (String value) {},
            ),
            text: 'Enter your 6 digit code numbers sent to  .. $number !');
       PhoneCubit cubit = PhoneCubit.get(context);
        return Padding(
          padding: EdgeInsets.all(getProportionateScreenHeight(18.0)),
          child: Column(
            children: [
              Expanded(
                child: PhoneContent(phoneModel:model1 ,),
              ),
              CustomButton(
                text: 'Verfiy PinCode',
                press: () {
                  cubit.submitOTP(pinCode.text);
                },
              ),
            ],
          ),
        );
      },
    );
  }

}


