import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:my_app/features/home/bloc/api_bloc/bloc/api_bloc.dart';
import 'package:my_app/features/home/bloc/home_bloc/home_bloc.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:my_app/features/home/models/home_data_ui_model.dart';
import 'package:my_app/shared/global.dart';
import 'package:my_app/shared/loading.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  ScrollController _scrollController = ScrollController();
  final HomeBloc _homeBloc = HomeBloc();
  final ApiBloc _apiBloc = ApiBloc();
  List<Post> myPosts = [];
  bool isLoading = false;

  @override
  void initState() {
    _homeBloc.add(HomeInitEvent());
    if (_scrollController.hasClients) {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent) {
        debugPrint("More Data Loaded");
        _apiBloc.add(ApiLoadMoreDataEvent());
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
        bloc: _homeBloc,
        listenWhen: (previous, current) => current is HomeActionState,
        buildWhen: (previous, current) => current is! HomeActionState,
        listener: (context, state) {
          if (state is HomeNavigatingToChatState) {
            context.push(userPath);
            debugPrint("Going To Chats");
          } else if (state is HomeSignOutState) {
            context.pushReplacement(loginPath);
          }
        },
        builder: (context, state) {
          debugPrint(state.runtimeType.toString());
          switch (state.runtimeType) {
            case HomeLoadingState:
              {
                return LoadingWidget();
              }
            case HomeLoadingCompleteState:
              {
                final succesState = state as HomeLoadingCompleteState;
                myPosts.addAll(succesState.posts);
                return Scaffold(
                    floatingActionButton: FloatingActionButton(
                      child: Icon(Icons.chat),
                      backgroundColor: Colors.lightBlue[100],
                      onPressed: () {
                        _homeBloc.add(HomeFloatingActionButtonClickedEvent());
                      },
                    ),
                    appBar: AppBar(
                      title: const Text("Vb App"),
                      backgroundColor: Colors.blueAccent,
                      actions: [
                        IconButton(
                            onPressed: () {
                              _homeBloc.add(HomeSignOutEvent());
                            },
                            icon: Icon(Icons.logout_outlined))
                      ],
                    ),
                    body: SingleChildScrollView(
                      controller: _scrollController,
                      physics: const BouncingScrollPhysics(
                          decelerationRate: ScrollDecelerationRate.fast),
                      child: Animate(
                        effects: [],
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ...myPosts.asMap().entries.map((e) {
                              int index = e.key;
                              var item = e.value;

                              return BlocConsumer<ApiBloc, ApiState>(
                                bloc: _apiBloc,
                                listener: (context, state) {
                                  if (state is ApiLoadMoreDataState) {
                                    final loadedData =
                                        state as ApiLoadMoreDataState;
                                    myPosts.addAll(loadedData.posts);
                                  }
                                },
                                builder: (context, state) {
                                  if (index < myPosts.length - 1 ||
                                      state is ApiMoreDataLoadedState) {
                                    isLoading = false;
                                    return Container(
                                      alignment: Alignment.bottomLeft,
                                      width: MediaQuery.of(context).size.width,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 10),
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 10),
                                      decoration: BoxDecoration(
                                          border: Border.all(width: 3),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(20))),
                                      child: Animate(
                                        effects: [FadeEffect()],
                                        child: Column(
                                          children: [
                                            Text(
                                              item.title,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  decoration:
                                                      TextDecoration.underline),
                                            ),
                                            Text(item.body)
                                          ],
                                        ),
                                      ),
                                    );
                                  } else {
                                    isLoading = false;
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }
                                },
                              );
                            })
                          ],
                        ),
                      ),
                    )).animate(effects: [const FadeEffect()]);
              }
            default:
              return const Scaffold(
                body: Center(
                  child: Text("Error"),
                ),
              );
          }
        });
  }
}
