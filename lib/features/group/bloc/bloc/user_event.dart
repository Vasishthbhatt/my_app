part of 'user_bloc.dart';

@immutable
sealed class UserEvent {}

class UserInitialEvent extends UserEvent {}

class UserUpdateEvent extends UserEvent {}

class UserDisposeEvent extends UserEvent {}

class UserAddCurrentUserTOCurrentGroupEvent extends UserEvent {}
