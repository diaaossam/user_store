import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_store/screens/on_boarding/cubit/on_boarding_states.dart';
import 'package:user_store/screens/sign_in/sign_in_screen.dart';
import 'package:user_store/shared/helper/constants.dart';
import 'package:user_store/shared/helper/methods.dart';
import 'package:user_store/shared/services/local/cache_helper.dart';

import '../../../models/token_model.dart';

class OnBoardingCubit extends Cubit<OnBoardingStates> {
  bool isLast = false;

  OnBoardingCubit() : super(InitialStates());

  static OnBoardingCubit get(BuildContext context) => BlocProvider.of(context);

  void changePageViewState(bool from) {
    isLast = from;
    emit(LastPageView());
  }

}
