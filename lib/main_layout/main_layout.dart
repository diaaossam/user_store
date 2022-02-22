import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_store/main_layout/cubit/main_layout_cubit.dart';

import 'cubit/main_layout_state.dart';

class MainLayout extends StatelessWidget {
  const MainLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MainLayoutCubit(),
      child: BlocConsumer<MainLayoutCubit, MainLayoutState>(
        listener: (context, state) {},
        builder: (context, state) {
          MainLayoutCubit cubit = MainLayoutCubit.get(context);

          return Scaffold(
            body: cubit.screens[cubit.index],
            bottomNavigationBar: BottomNavigationBar(
              items: cubit.navListItems,
              currentIndex: cubit.index,
              onTap: (index){
                cubit.changeBottomNavIndex(index);
              },
            ),
          );
        },
      ),
    );
  }
}
