import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:user_store/screens/phone_screen/cubit/phone_state.dart';
import '../../../shared/helper/constants.dart';
import '../../../shared/services/local/cache_helper.dart';
import '../../../shared/styles/colors.dart';
import '../components/phone_body.dart';

class PhoneCubit extends Cubit<PhoneState> {

  PhoneCubit() : super(PhoneInitial());

  static PhoneCubit get(context) => BlocProvider.of(context);

  late String verificationId;

  Future<void> submitPhoneNumber(String phone) async {
    emit(Loading());
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '${phone} ',
        timeout: const Duration(seconds: 14),
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
      );
  }

  void verificationCompleted(PhoneAuthCredential credential) async {
    print('verificationCompleted');
    await signIn(credential);
  }

  void verificationFailed(FirebaseAuthException error) {
    print('verificationFailed : ${error.toString()}');
    emit(ErrorOccurred(errorMsg: error.toString()));
  }

  void codeSent(String verificationId, int? resendToken) {
    this.verificationId = verificationId;
    emit(PhoneNumberSubmited());
  }

  void codeAutoRetrievalTimeout(String verificationId) {
    print('codeAutoRetrievalTimeout');
  }

  Future<void> submitOTP(String otpCode) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: this.verificationId, smsCode: otpCode);
    await signIn(credential);
  }

  Future<void> signIn(PhoneAuthCredential credential) async {
    try {
      await FirebaseAuth.instance.signInWithCredential(credential).then((value){
        emit(PhoneOTPVerified());
      });
    } catch (error) {
      emit(ErrorOccurred(errorMsg: error.toString()));
    }
  }

}
