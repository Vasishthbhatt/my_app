import 'dart:async';
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:my_app/features/home/models/home_model.dart';
import 'package:my_app/features/home/repos/home_repo.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GroupsRepos _groupsRepos = GroupsRepos();

  HomeBloc() : super(HomeInitial()) {
    on<HomePostTappedEvent>((event, emit) => emit(HomeNavigatingToChatState(groupId: event.groupId)));
    on<HomeInitEvent>(homeInitEvent);
    on<HomeScrollingReachedEndEvent>(homeScrollingReachedEndEvent);
    on<HomeFloatingActionButtonClickedEvent>(
        homeFloatingActionButtonClickedEvent);

    on<HomeSignOutEvent>(
      (event, emit) async {
        await FirebaseAuth.instance.signOut();
        emit(HomeSignOutState());
      },
    );

    on<HomePostLoadingEvent>((event, emit) => emit.onEach(
        _groupsRepos.getGroups(),
        onData: (data) => emit(HomeUpdatePostState(groups: data))));
  }

  FutureOr<void> homeInitEvent(
      HomeInitEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoadingState());
    add(HomePostLoadingEvent());
    // await Future.delayed(Duration(seconds: 5));
    emit(HomeLoadingCompleteState());
  }

  FutureOr<void> homeScrollingReachedEndEvent(
      HomeScrollingReachedEndEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoadMoreDataState());
  }

  FutureOr<void> homeFloatingActionButtonClickedEvent(
      HomeFloatingActionButtonClickedEvent event, Emitter<HomeState> emit) {
    _groupsRepos.addGroup(event.groups);
    // int i = 101;
    // print("Posted");
    // var client = http.Client();
    // try {
    //   var response = await client
    //       .post(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
    // } catch (e) {
    //   print(e.toString());
    // } finally {
    //   client.close();
    // }

    // emit(HomeNavigatingToChatState());
  }
}
