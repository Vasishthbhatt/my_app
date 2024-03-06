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
    // _userRepos.getUser().listen((event) async {
    //   for (final user in event) {
    //     // add(UserUpdateEvent(user: user));
    //     emit.onEach(
    //       stream,
    //       onData: (data) {
    //         UserNewDataUpdateState(userModel: user);
    //       },
    //     );
    //   }
    // });
    add(UserUpdateEvent());

    emit(UserLoadedState());
    print("Gathering USers");
  }

  FutureOr<void> userDisposeEvent(
      UserDisposeEvent event, Emitter<UserState> emit) {
    _userRepos.updateUser(false);
  }

  FutureOr<void> userUpdateEvent(
          UserUpdateEvent event, Emitter<UserState> emit) =>
      emit.forEach(
        _userRepos.getUser(),
        onData: (data) {
          return UserNewDataUpdateState(userModel: data);
        },
      );
}
