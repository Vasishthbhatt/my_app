part of 'user_bloc.dart';

@immutable
sealed class UserState {}

final class UserInitial extends UserState {}

sealed class UserActionState extends UserState {}

class UserLoadingState extends UserState {}

class UserLoadedState extends UserState {}

class UserNewDataUpdateState extends UserActionState {
  final List<UserModel> userModel;
  UserNewDataUpdateState({required this.userModel});
}
