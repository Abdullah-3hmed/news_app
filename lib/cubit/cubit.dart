import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/cubit/states.dart';
import 'package:news_app/network/local/cache_helper.dart';

import '../modules/business_screen.dart';
import '../modules/science_screen.dart';
import '../modules/sports_screen.dart';
import '../network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  List<Widget> screens = [
    const BusinessScreen(),
    const SportsScreen(),
    const ScienceScreen(),
  ];
  List<BottomNavigationBarItem> bottomNavBarItems = [
    const BottomNavigationBarItem(
        icon: Icon(
          Icons.business,
        ),
        label: 'business'),
    const BottomNavigationBarItem(
        icon: Icon(
          Icons.sports,
        ),
        label: 'sports'),
    const BottomNavigationBarItem(
        icon: Icon(
          Icons.science,
        ),
        label: 'science'),
  ];

  void changeBottomNavBar(int index) {
    currentIndex = index;
    emit(NewsBottomNavState());
  }

  List<dynamic> business = [];

  void getBusiness() {
    emit(NewsGetBusinessLoadingState());
    DioHelper.getData(
      url: 'v2/top-headlines',
      query: {
        'country': 'eg',
        'category': 'business',
        'apiKey': '31cbb381e6d4493493209e395fc52a36',
      },
    ).then((value) {
      business = value!.data['articles'];
      emit(NewsBusinessSuccessState());
    }).catchError((error) {
      //print(error.toString());
      emit(NewsBusinessErrorState(error.toString()));
    });
  }

  List<dynamic> sports = [];

  void getSports() {
    emit(NewsGetSportsLoadingState());
      DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country': 'eg',
          'category': 'Sports',
          'apiKey': '31cbb381e6d4493493209e395fc52a36'
        },
      ).then((value) {
        sports = value!.data['articles'];
        emit(NewsSportsSuccessState());
      }).catchError((error) {
        //print(error.toString());
        emit(NewsSportsErrorState(error.toString()));
      });
  }

  List<dynamic> science = [];

  void getScience() {
    emit(NewsGetScienceLoadingState());
      DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country': 'eg',
          'category': 'Science',
          'apiKey': '31cbb381e6d4493493209e395fc52a36'
        },
      ).then((value) {
        science = value!.data['articles'];
        emit(NewsScienceSuccessState());
      }).catchError((error) {
        //print(error.toString());
        emit(NewsScienceErrorState(error.toString()));
      });
  }

  bool isDark = false;

  void changeAppMode({bool? fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
      emit(ChangeAppThemeModeState());
    } else {
      isDark = !isDark;
      CacheHelper.putBool(key: 'isDark', value: isDark).then((value) {
        emit(ChangeAppThemeModeState());
      });
    }
  }

  List<dynamic> search = [];
  var searchController = TextEditingController();
  var fromKey = GlobalKey<FormState>();

  void getSearch(String value) {
    emit(NewsGetSearchLoadingState());
    DioHelper.getData(
      url: 'v2/everything',
      query: {
        'q': value,
        'apiKey': '31cbb381e6d4493493209e395fc52a36',
      },
    ).then((value) {
      search = value!.data['articles'];
      emit(NewsGetSearchSuccessState());
    }).catchError((error) {
      //print(error.toString());
      emit(NewsGetSearchErrorState(error.toString()));
    });
  }
}
