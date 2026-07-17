part of 'home_cubit.dart';

sealed class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeSuccess extends HomeState {
  List<Articles> articles;
  HomeSuccess(this.articles);
}
class HomeError extends HomeState {
  String messageError;

  HomeError(this.messageError);
}
