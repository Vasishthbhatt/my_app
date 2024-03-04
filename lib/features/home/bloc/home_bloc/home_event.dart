part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

class HomeInitEvent extends HomeEvent {}

class HomeScrollingReachedEndEvent extends HomeEvent {}

class HomeFloatingActionButtonClickedEvent extends HomeEvent {}

class HomeSignOutEvent extends HomeEvent {}
