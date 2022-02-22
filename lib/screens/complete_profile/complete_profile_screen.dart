import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_store/screens/complete_profile/cubit/complete_profile_cubit.dart';
import 'components/body.dart';

class CompleteProfileScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CompleteProfileCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Register'),
        ),
        body: Body(),
      ),
    );
  }
}
