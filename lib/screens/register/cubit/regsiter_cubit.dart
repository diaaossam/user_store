import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_store/screens/register/cubit/register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

  static RegisterCubit get(context) => BlocProvider.of(context);

  final List<String?> errors = [];

  void setErrors(String error) {
    errors.add(error);
    emit(SetErrors());
  }

  void removeErrors(String error) {
    errors.remove(error);
    emit(RemoveErrors());
  }

  void regiterNewUser({required String email, required String password}) async {
    emit(RegisterLoadingState());
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) {
        emit(RegisterSuccessState());
      });
    } catch (e) {
      emit(RegisterFailuerState(e.toString()));
    }
  }
}
