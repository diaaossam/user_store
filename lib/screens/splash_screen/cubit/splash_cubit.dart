import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:user_store/main_layout/cubit/main_layout_cubit.dart';

import '../../../main_layout/main_layout.dart';
import '../../../models/token_model.dart';
import '../../../shared/helper/constants.dart';
import '../../../shared/helper/methods.dart';
import '../../../shared/services/local/cache_helper.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashInitial());

  static SplashCubit get(context) => BlocProvider.of(context);

  void checkUserState() {
    Future.delayed(
      Duration(seconds: 3),
      () {
        bool onBoarding = CachedHelper.getBooleon(key: ON_BOARDING) ?? false;
        if (onBoarding) {
          FirebaseAuth.instance.authStateChanges().listen((user) {
            if (user != null) {
              genrateToken(user.uid);
              FirebaseDatabase.instance.ref(USERS).child(user.uid).get().then((value) {
                if (value.exists) {
                  emit(SplashMainLayout());
                } else {
                  emit(SplashCompleteProfile());
                }
              });
            } else {
              emit(SplashSignIn());
            }
          });
        } else {
          emit(SplashOnBoarding());
        }
      },
    );
  }

  void genrateToken(String uid) {
    FirebaseMessaging.instance.getToken().then((token) {
      TokenModel tokenModel = TokenModel(uid: uid, token: token, isAdmin: false);
      FirebaseDatabase.instance.ref(TOKENS).child(uid).set(tokenModel.toMap());
    });
  }
}
