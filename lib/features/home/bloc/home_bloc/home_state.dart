part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

@immutable
sealed class HomeActionState extends HomeState {}

sealed class HomePostState extends HomeState {}

class HomeInitial extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeLoadingCompleteState extends HomeState {}

class HomeLoadMoreDataState extends HomeState {}

class HomeMoreDataLoadedState extends HomeActionState {
  final List<Groups> posts;
  HomeMoreDataLoadedState({required this.posts});
}

class HomeNavigatingToChatState extends HomeActionState {}

class HomeSignOutState extends HomeActionState {}

class HomeUpdatePostState extends HomePostState {
  final List<Groups> groups;

  HomeUpdatePostState({required this.groups});
}

// class HomeAddPostState extends HomePostState {
//   final Groups groups;

//   HomeAddPostState({required this.groups});
// }
