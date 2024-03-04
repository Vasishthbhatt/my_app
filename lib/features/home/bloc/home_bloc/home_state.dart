part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

@immutable
sealed class HomeActionState extends HomeState {}

class HomeInitial extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeLoadingCompleteState extends HomeState {
  final List<Post> posts;
  HomeLoadingCompleteState({required this.posts});
}

class HomeLoadMoreDataState extends HomeState {}

class HomeMoreDataLoadedState extends HomeActionState {
  final List<Post> posts;
  HomeMoreDataLoadedState({required this.posts});
}

class HomeNavigatingToChatState extends HomeActionState {}

class HomeSignOutState extends HomeActionState {}