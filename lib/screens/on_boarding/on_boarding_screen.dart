import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_store/main_layout/main_layout.dart';
import 'package:user_store/screens/complete_profile/complete_profile_screen.dart';
import 'package:user_store/screens/on_boarding/cubit/on_boarding_cubit.dart';
import 'package:user_store/screens/on_boarding/cubit/on_boarding_states.dart';
import '../../shared/helper/methods.dart';
import '../../shared/helper/size_config.dart';
import '../sign_in/sign_in_screen.dart';
import 'components/body.dart';

class OnBoardingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return BlocProvider(
        create: (context) => OnBoardingCubit(),
        child: BlocConsumer<OnBoardingCubit, OnBoardingStates>(
          listener: (context, state) {
            if (state is GoToSignIn) {
              navigateToAndFinish(context, SignInScreen());
            } else if (state is GoToHome) {
             navigateToAndFinish(context, MainLayout());
            } else if (state is GoToCompleteProfile) {
              navigateToAndFinish(context, CompleteProfileScreen());
            }
          },
          builder: (context, state) {
            return Scaffold(
              body: Body(),
              appBar: AppBar(
                actions: [
                  TextButton(
                    onPressed: () {
                      OnBoardingCubit.get(context).checkNavigation();
                    },
                    child: Padding(
                      padding: const EdgeInsetsDirectional.only(end: 20.0),
                      child: Text(
                        'Skip',
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ));
  }
}
