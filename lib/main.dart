import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_store/main_layout/main_layout.dart';
import 'package:user_store/screens/phone_screen/cubit/phone_cubit.dart';
import 'package:user_store/screens/sign_in/cubit/sign_in_cubit.dart';
import 'package:user_store/screens/sign_in/sign_in_screen.dart';
import 'package:user_store/screens/splash_screen/splash_screen.dart';
import 'package:user_store/shared/cubit/bloc_observer.dart';
import 'package:user_store/shared/helper/constants.dart';
import 'package:user_store/shared/services/local/cache_helper.dart';
import 'package:user_store/shared/services/network/dio_helper.dart';
import 'package:user_store/shared/styles/styles.dart';


void main() {
  BlocOverrides.runZoned(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      await CachedHelper.init();
      await Firebase.initializeApp();
      DioHelper.init();
      runApp(MyApp());
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext) => PhoneCubit()),
        BlocProvider(create: (BuildContext) => SignInCubit()),

      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: ThemeMode.light,
        home:SplashScreen(),
      ),
    );
  }

}
