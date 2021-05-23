import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/layout/cubit/states.dart';
import 'package:news/modules/business/business_screen.dart';
import 'package:news/modules/sciences/sciences_screen.dart';
import 'package:news/modules/sports/sports_screen.dart';
import 'package:news/shared/components/constants.dart';
import 'package:news/shared/newtwork/local/cache_helper.dart';
import 'package:news/shared/newtwork/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialStates());

  static NewsCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List <BottomNavigationBarItem> bottomItems  = [
    BottomNavigationBarItem(
      icon: Icon(Icons.business),
      label: 'business',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.sports),
      label: 'sports',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.science),
      label: 'science',
    ),
  ];

  List<String> titles = [
    'Business',
    'Sports',
    'Sciences',
  ];

  List<Widget> screens = [
    BusinessScreen(),
    SportsScreen(),
    SciencesScreen(),
  ];

  void changeNavBar(int index){
    currentIndex = index;
    emit(NewsChangeNavBar());
  }

  //
  //Business Cubit
  //

  List<dynamic> business = [];

  void getBusiness() {
    NewsGetBusinessLoadingState();
    DioHelper.getData(url: url, query: {
      'country': 'eg',
      'category': 'business',
      'apiKey': '7c03327d3f8f400ab9f217febf03f604',
    }).then((value) {
      business = value.data['articles'];
      emit(NewsGetBusinessSuccessState());
      print(business[0]['title']);
    }).catchError((e) {
      emit(NewsGetBusinessErrorState(e.toString()));
      print(e.toString());
    });
  }

  //
  //Sports Cubit
  //

  List<dynamic> sports = [];

  void getSports() {
    NewsGetSportsLoadingState();
    DioHelper.getData(url: url, query: {
      'country': 'eg',
      'category': 'sports',
      'apiKey': '7c03327d3f8f400ab9f217febf03f604',
    }).then((value) {
      sports = value.data['articles'];
      emit(NewsGetSportsSuccessState());
      print(sports[0]['title']);
    }).catchError((e) {
      emit(NewsGetSportsErrorState(e.toString()));
      print(e.toString());
    });
  }

  //
  //Sciences Cubit
  //

  List<dynamic> sciences = [];

  void getSciences() {
    NewsGetSciencesLoadingState();
    DioHelper.getData(url: url, query: {
      'country': 'eg',
      'category': 'science',
      'apiKey': '7c03327d3f8f400ab9f217febf03f604',
    }).then((value) {
      sciences = value.data['articles'];
      emit(NewsGetSciencesSuccessState());
      print(sciences[0]['title']);
    }).catchError((e) {
      emit(NewsGetSciencesErrorState(e.toString()));
      print(e.toString());
    });
  }


  List<dynamic> search = [];

  void getSearch(String value) {

    NewsGetSearchLoadingState();

    DioHelper.getData(url: baseSearchUrl, query: {
      'q': '$value',
      'apiKey': '7c03327d3f8f400ab9f217febf03f604',
    }).then((value) {
      search = value.data['articles'];
      emit(NewsGetSearchSuccessState());
      print(search[0]['title']);
    }).catchError((e) {
      emit(NewsGetSearchErrorState(e.toString()));
      print(e.toString());
    });
  }


//
//mode
//

  bool isDark = false;

  void changeMode({bool fromShared}){

    if(fromShared == null){
      isDark = !isDark;
      CacheHelper.putData(key: 'isDark', value: isDark).then((value) {
        emit(AppModeState());
      });

    } else{
      isDark = fromShared;
      emit(AppModeState());
    }


  }
}
