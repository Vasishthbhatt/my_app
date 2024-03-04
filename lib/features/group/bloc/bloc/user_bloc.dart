import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:my_app/features/group/model/user_model.dart';
import 'package:my_app/features/group/repos/users_repo.dart';
import 'package:my_app/features/group/ui/user.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepos _userRepos = UserRepos();

  UserBloc() : super(UserInitial()) {
    on<UserInitialEvent>(userInitialEvent);
    on<UserUpdateEvent>(userUpdateEvent);
    on<UserDisposeEvent>(userDisposeEvent);
  }

  FutureOr<void> userInitialEvent(
      UserInitialEvent event, Emitter<UserState> emit) {
    _userRepos.updateUser(true);
    emit(UserLoadingState());
    _userRepos.getUser().listen((event) {
      for (final user in event) {
        add(UserUpdateEvent(user: user));
      }
    });
    emit(UserLoadedState());
    print("Gathering USers");
  }

  FutureOr<void> userUpdateEvent(
      UserUpdateEvent event, Emitter<UserState> emit) {
    print("UserUpdateEventEmitted");
    emit(UserNewDataUpdateState(userModel: event.user));
  }

  FutureOr<void> userDisposeEvent(
      UserDisposeEvent event, Emitter<UserState> emit) {
    _userRepos.updateUser(false);
  }
}
