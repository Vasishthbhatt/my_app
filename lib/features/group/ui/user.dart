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

class _UserState extends State<User> {
  final UserBloc _userBloc = UserBloc();
  List<UserModel> _users = [];
  // final UserRepos _userRepos = UserRepos();

  @override
  void initState() {
    _users.clear();
    _userBloc.add(UserInitialEvent());
    super.initState();
  }

  @override
  void dispose() {
    _userBloc.add(UserDisposeEvent());
    super.dispose();
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
                appBar: AppBar(title: Text("Users")),
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
                        int index = _users.indexWhere(
                            (element) => element.uid == state.userModel.uid);

                        if (index != -1) {
                          _users[index] =
                              state.userModel; // Update existing element
                        } else {
                          _users.add(state.userModel); // Add new element
                        }
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
                          return InkWell(
                            focusColor: Colors.grey,
                            onLongPress: () {
                              context.push(chatPath, extra: _users[index]);
                            },
                            child: ListTile(
                              contentPadding: EdgeInsets.zero,
                              leading: Stack(
                                alignment: Alignment.bottomRight,
                                children: [
                                  CircleAvatar(
                                    radius: 30,
                                    backgroundImage: NetworkImage(
                                        _users[index].image ??
                                            anonymousUserIconLink),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 10),
                                    child: CircleAvatar(
                                      radius: 5,
                                      backgroundColor: _users[index].isOnline
                                          ? Colors.green
                                          : Colors.grey,
                                    ),
                                  )
                                ],
                              ),
                              title: Text(_users[index].name,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)),
                              subtitle: Text(
                                'Last Active: ${timeago.format(_users[index].lastActive)}',
                                style: const TextStyle(
                                    color: Colors.blueGrey, fontSize: 14),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          );
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
