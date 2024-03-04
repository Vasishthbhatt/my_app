part of 'user_bloc.dart';

@immutable
sealed class UserEvent {}

class UserInitialEvent extends UserEvent {}

class UserUpdateEvent extends UserEvent {
  final UserModel user;
  UserUpdateEvent({required this.user});
}

class UserDisposeEvent extends UserEvent {}
