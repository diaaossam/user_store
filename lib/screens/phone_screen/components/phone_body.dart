import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:user_store/screens/otp_screen/otp_screen.dart';
import 'package:user_store/screens/phone_screen/components/phone_content.dart';
import 'package:user_store/screens/phone_screen/cubit/phone_cubit.dart';
import 'package:user_store/shared/helper/methods.dart';
import '../../../models/phone_model.dart';
import '../../../shared/components/custom_button.dart';
import '../../../shared/helper/size_config.dart';
import '../../../shared/widgets/custom_widgets.dart';
import '../cubit/phone_state.dart';

class PhoneBody extends StatelessWidget {
  var phoneNumber = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PhoneCubit, PhoneState>(
      listener: (context, state) {

        if(state is Loading){
          showCustomProgressIndicator(context);
        }
        if (state is PhoneNumberSubmited) {
          Navigator.pop(context);
          navigateTo(context, OtpScreen(phoneNumber.text));

        }
        if (state is ErrorOccurred){
          Navigator.pop(context);

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
        PhoneCubit cubit = PhoneCubit.get(context);
        PhoneModel model = PhoneModel(
            image: 'assets/images/phone1.png',
            widget: IntlPhoneField(
              decoration: InputDecoration(
                labelText: 'Phone Number',
                border: OutlineInputBorder(
                  borderSide: BorderSide(),
                ),
              ),
              initialCountryCode: 'EG',
              onChanged: (value){
                phoneNumber.text = value.completeNumber;
              },
            ),
            text: 'Please enter your Phone Number .. !');
        return Padding(
          padding: EdgeInsets.all(getProportionateScreenHeight(18.0)),
          child: Column(
            children: [
              Expanded(
                child:PhoneContent(
                  phoneModel:model ,
                ),
              ),
              CustomButton(
                text: 'Send Pin Code ',
                press: () {
                  cubit.submitPhoneNumber(phoneNumber.text);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}


