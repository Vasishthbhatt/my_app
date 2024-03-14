import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:my_app/features/home/bloc/home_bloc/home_bloc.dart';
import 'package:my_app/features/home/models/home_data_ui_model.dart';
import 'package:my_app/shared/UIHelper.dart';
import 'package:my_app/shared/global.dart';
import 'package:my_app/shared/loading.dart';
import 'package:path/path.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  ScrollController _scrollController = ScrollController();
  final HomeBloc _homeBloc = HomeBloc();
  List<Groups> _myPosts = [];
  bool isLoading = false;

  // final _textFieldController = TextEditingController();

  @override
  void initState() {
    _homeBloc.add(HomeInitEvent());
    if (_scrollController.hasClients) {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent) {
        debugPrint("More Data Loaded");
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
        bloc: _homeBloc,
        listenWhen: (previous, current) => current is HomeActionState,
        buildWhen: (previous, current) =>
            current is! HomeActionState && current is! HomePostState,
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
                return Scaffold(
                  body: Container(
                    height: double.maxFinite,
                    width: double.maxFinite,
                    decoration: UIHelper.customContainerDecoration(),
                    child: LoadingAnimationWidget.threeRotatingDots(
                        color: Colors.blue, size: 120),
                  ),
                );
              }
            case HomeLoadingCompleteState:
              {
                return Scaffold(
                    appBar: AppBar(
                      title: Text("Groups"),
                      backgroundColor: Colors.lightBlueAccent,
                      actions: [
                        IconButton(
                            onPressed: () => _showTextInputDialog(context),
                            icon: Icon(Icons.logout))
                      ],
                    ),
                    floatingActionButton: FloatingActionButton(
                        child: Icon(Icons.add),
                        onPressed: () async {
                          _homeBloc.add(HomeFloatingActionButtonClickedEvent(
                              groups: Groups(
                                  groupId: "groupId",
                                  title: "title",
                                  body: "body",
                                  admins: [],
                                  users: [])));
                          // var result = await _showTextInputDialog(context);
                          // print(result.toString());
                        }),
                    body: Container(
                      height: MediaQuery.of(context).size.height,
                      decoration: UIHelper.customContainerDecoration(),
                      child: BlocBuilder<HomeBloc, HomeState>(
                        bloc: _homeBloc,
                        buildWhen: (previous, current) =>
                            current is HomePostState,
                        builder: (context, state) {
                          print(state.runtimeType.toString());
                          if (state is HomeUpdatePostState) {
                            _myPosts.clear();
                            _myPosts.addAll(state.groups);
                          }
                          return ListView.separated(
                            separatorBuilder: (context, index) =>
                                const SizedBox(
                              height: 10,
                            ),
                            shrinkWrap: true,
                            itemCount: _myPosts.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                  onTap: () =>
                                      _homeBloc.add(HomePostTappedEvent()),
                                  child: UIHelper.customPostBox(
                                      _myPosts[index], context));
                            },
                          );
                        },
                      ),
                    ));
              }
            default:
              {
                return const Scaffold(
                  body: Center(
                    child: Text("Error"),
                  ),
                );
              }
          }
        });
  }

  Future<String?> _showTextInputDialog(BuildContext context) async {
    // print("Logoout Button Clicked");
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shadowColor: Colors.amber,
            backgroundColor: Color.fromARGB(255, 180, 249, 255),
            title: const Text(
              'Do you want to SignOut?',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            actions: <Widget>[
              ElevatedButton(
                child: const Text("Cancel"),
                onPressed: () => Navigator.pop(context),
              ),
              ElevatedButton(
                child: const Text('OK'),
                onPressed: () => _homeBloc.add(HomeSignOutEvent()),
              ),
            ],
          );
        });
  }
}
