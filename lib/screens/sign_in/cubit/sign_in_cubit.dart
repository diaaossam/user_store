import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:user_store/screens/sign_in/cubit/sign_in_state.dart';

import '../../../models/token_model.dart';
import '../../../shared/helper/constants.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit() : super(SignInInitial());

  static SignInCubit get(context) => BlocProvider.of(context);

  bool isPasswordVisible = false;

  void changePasswordVisibaltySignIn() {
    isPasswordVisible = !isPasswordVisible;
    emit(ChangePasswordVisibilty());
  }

  final List<String?> errors = [];

  void setErrors(String error) {
    errors.add(error);
    emit(SetErrors());
  }

  void removeErrors(String error) {
    errors.remove(error);
    emit(RemoveErrors());
  }

  void signInWithGoogle() async {
    emit(SignInLoadingState());
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    await FirebaseAuth.instance.signInWithCredential(credential).then((value) {
      genrateToken(value.user!.uid);
      emit(SignInSuccessState());
    }).catchError((error) {
      emit(SignInFailuerState(error.toString()));
    });
  }





  Future signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    emit(SignInLoadingState());
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      genrateToken(value.user!.uid);
      emit(SignInSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SignInFailuerState(error.toString()));
    });
  }

  void genrateToken(String uid) {
    FirebaseMessaging.instance.getToken().then((token) {
      TokenModel tokenModel = TokenModel(uid: uid, token: token, isAdmin: false);
      FirebaseDatabase.instance.ref(TOKENS).child(uid).set(tokenModel.toMap());
    });
  }
}
