import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:my_app/features/home/models/home_data_ui_model.dart';
import 'package:my_app/features/home/repos/posts_repo.dart';

part 'api_event.dart';
part 'api_state.dart';

class ApiBloc extends Bloc<ApiEvent, ApiState> {
  ApiBloc() : super(ApiInitial()) {
    on<ApiEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<ApiLoadMoreDataEvent>(apiLoadMoreDataState);
  }

  FutureOr<void> apiLoadMoreDataState(
      ApiLoadMoreDataEvent event, Emitter<ApiState> emit) async {
    List<Post> posts = await PostRepos.fetchPosts();
    emit(ApiLoadMoreDataState(posts: posts));
    emit(ApiMoreDataLoadedState());
  }
}
