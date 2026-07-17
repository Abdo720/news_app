import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:news_app/home/data/api/api_manager.dart';
import 'package:news_app/home/data/api_result.dart';
import 'package:news_app/home/data/models/news_model.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());


  void fetchNews() async
  {
    emit(HomeLoading());
    var result = await Api.getData();
    switch (result) {
      case Success<NewsModel>():
        emit(HomeSuccess(result.data?.articles ?? []));
      case Error<NewsModel>():
        emit(HomeError(result.messageError));
    }
  }
}