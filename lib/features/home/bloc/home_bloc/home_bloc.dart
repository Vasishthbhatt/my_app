import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:my_app/features/home/models/home_data_ui_model.dart';
import 'package:my_app/features/home/repos/posts_repo.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeInitEvent>(homeInitEvent);
    on<HomeScrollingReachedEndEvent>(homeScrollingReachedEndEvent);
    on<HomeFloatingActionButtonClickedEvent>(
        homeFloatingActionButtonClickedEvent);
    on<HomeSignOutEvent> (
      (event, emit) async{
        await FirebaseAuth.instance.signOut();
        emit(HomeSignOutState());
      },
    );
  }

  FutureOr<void> homeInitEvent(
      HomeInitEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoadingState());
    List<Post> posts = await PostRepos.fetchPosts();
    emit(HomeLoadingCompleteState(posts: posts));
  }

  FutureOr<void> homeScrollingReachedEndEvent(
      HomeScrollingReachedEndEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoadMoreDataState());
    
    var client = http.Client();
    List<Post> posts = [];
  }

  FutureOr<void> homeFloatingActionButtonClickedEvent(
      HomeFloatingActionButtonClickedEvent event,
      Emitter<HomeState> emit) async {
    int i = 101;
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

    emit(HomeNavigatingToChatState());
  }
}
