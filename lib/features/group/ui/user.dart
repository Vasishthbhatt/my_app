import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_app/features/group/bloc/bloc/user_bloc.dart';
import 'package:my_app/features/group/model/user_model.dart';
import 'package:my_app/features/group/repos/users_repo.dart';
import 'package:my_app/shared/UIHelper.dart';
import 'package:my_app/shared/global.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:flutter_bloc/flutter_bloc.dart';

class User extends StatefulWidget {
  const User({super.key});

  @override
  State<User> createState() => _UserState();
}

class _UserState extends State<User> with WidgetsBindingObserver {
  final UserBloc _userBloc = UserBloc();
  List<UserModel> _users = [];
  // final UserRepos _userRepos = UserRepos();

  @override
  void initState() {
    _users.clear();
    _userBloc.add(UserInitialEvent());
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    _userBloc.add(UserDisposeEvent());
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void deactivate() {
    _userBloc.add(UserDisposeEvent());
    super.deactivate();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print(state.toString());
    switch (state) {
      case AppLifecycleState.inactive:
        _userBloc.add(UserDisposeEvent());
        break;
      case AppLifecycleState.resumed:
        _userBloc.add(UserInitialEvent());
        break;
      case AppLifecycleState.paused:
        _userBloc.add(UserDisposeEvent());
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserBloc, UserState>(
      bloc: _userBloc,
      buildWhen: (previous, current) => current is! UserActionState,
      listenWhen: (previous, current) => current is! UserActionState,
      listener: (context, state) {},
      builder: (context, state) {
        switch (state.runtimeType) {
          case UserLoadingState:
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );

          case UserLoadedState:
            {
              return Scaffold(
                appBar: AppBar(
                  title: Text("Users"),
                  backgroundColor: Colors.lightBlueAccent,
                ),
                floatingActionButton: FloatingActionButton(
                  onPressed: () {
                    _userBloc.add(UserAddCurrentUserTOCurrentGroupEvent());
                  },
                  child: Icon(Icons.add),
                ),
                body: Container(
                  decoration: UIHelper.customContainerDecoration(),
                  child: BlocBuilder<UserBloc, UserState>(
                    bloc: _userBloc,
                    buildWhen: (previous, current) =>
                        current is UserActionState,
                    builder: (context, state) {
                      print(state.runtimeType.toString());
                      if (state is UserNewDataUpdateState) {
                        final users = state as UserNewDataUpdateState;
                        _users.clear();
                        _users.addAll(users.userModel);
                      }

                      print("UsersListLength:" + _users.length.toString());
                      print("Building:" + state.runtimeType.toString());
                      return ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        itemCount: _users.length,
                        separatorBuilder: (context, index) => const SizedBox(
                          height: 10,
                        ),
                        itemBuilder: (context, index) {
                          return UIHelper.customUserListWidgetView(
                              _users, context, index);
                        },
                      );
                    },
                  ),
                ),
              );
            }
          default:
            {
              return Scaffold(body: Center(child: Text("Someting WentWrong")));
            }
        }
      },
    );
  }
}
