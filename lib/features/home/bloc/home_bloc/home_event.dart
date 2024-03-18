part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

class HomeInitEvent extends HomeEvent {}

class HomeScrollingReachedEndEvent extends HomeEvent {}

class HomeFloatingActionButtonClickedEvent extends HomeEvent {
  final Groups groups;

  HomeFloatingActionButtonClickedEvent({required this.groups});
}

class HomeSignOutEvent extends HomeEvent {}

class HomePostLoadingEvent extends HomeEvent {}

class HomePostTappedEvent extends HomeEvent {
  final String groupId;

  HomePostTappedEvent({required this.groupId});

}
