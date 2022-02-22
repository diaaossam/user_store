import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:user_store/models/Product.dart';
import 'package:user_store/screens/chat/chat_screen.dart';
import 'package:user_store/screens/fav_screen/fav_screen.dart';
import 'package:user_store/screens/home_screen/home_screen.dart';
import 'package:user_store/screens/search/search_screen.dart';
import 'package:user_store/screens/settings/settings_screen.dart';
import 'package:user_store/shared/styles/icon_broken.dart';
import '../../shared/helper/constants.dart';
import 'main_layout_state.dart';

class MainLayoutCubit extends Cubit<MainLayoutState> {
  MainLayoutCubit() : super(MainLayoutInitial());

  static MainLayoutCubit get(context) => BlocProvider.of(context);

  List<Widget> screens = [
    HomeScreen(),
    SearchScreen(),
    FavouriteScreen(),
    ChatScreen(),
    SettingsScreen(),
  ];

  List<BottomNavigationBarItem> navListItems = [
    BottomNavigationBarItem(icon: Icon(IconBroken.Home), label: 'Home'),
    BottomNavigationBarItem(icon: Icon(IconBroken.Search), label: 'Search'),
    BottomNavigationBarItem(icon: Icon(IconBroken.Heart), label: 'Favourite'),
    BottomNavigationBarItem(icon: Icon(IconBroken.Chat), label: 'Chat'),
    BottomNavigationBarItem(icon: Icon(IconBroken.Setting), label: 'Settings'),
  ];

  int index = 0 ;

  void changeBottomNavIndex(int indexFrom){
    this.index = indexFrom;
    emit(ChangeBottomNavIndex());
  }
/////////////////////////////////////////////////////////////////////////
/*  late Database database;

  void createDatabase() {
    openDatabase(
      '$DB_Name',
      version: 1,
      onCreate: (database, version) {
        print('Database is Created');
        database
            .execute(
            'CREATE TABLE $TableName ($ID INTEGER PRIMARY KEY, $TITLE TEXT, $DESCRIPTION TEXT, $IMAGES TEXT, $COLOR INTEGER, $RATING REAL, $PRICE REAL, $isFavourite TEXT, $isPopular TEXT)')
            .then((value) => print('Table is Created'));
      },
      onOpen: (database) {
        getAllTasks(database);
        print('Database Is Opened');
      },
    ).then((value) {
      this.database = value;
      emit(AppCreateDatabaseState());
    });
  }

  void getAllTasks(Database database) {
    emit(AppLoadingIndicatorState());
    database.rawQuery('SELECT * FROM $TableName').then((value) {
      print('rows: ${value.length} $value');

      // value.forEach((element) {
      //   if (element['status'] == 'new')
      //     newTasks.add(element);
      //   else if (element['status'] == 'done')
      //     doneTasks.add(element);
      //   else
      //     archivedTasks.add(element);
      // });
      emit(AppGetDatabaseState());
    });
  }

  insertDatabase(
      {required Product product}) async {
    await database.transaction((txn) async {
      await txn
          .rawInsert(
          'INSERT INTO $TableName ($TITLE,$DESCRIPTION,$IMAGES,$COLOR,$RATING,$PRICE,$isFavourite,$isPopular) VALUES ("${product.title}", "${product.description}" ,"${product.images}", "${product.colors}", "${product.rating}", "${product.price}", "${product.isFavourite}")')
          .then((value) {
        print("$value inserted successfully");
        emit(AppInsertDatabaseState());
        getAllTasks(database);
      }).catchError((error) {
        print('error ? $error');
      });
    });
  }*/

}
