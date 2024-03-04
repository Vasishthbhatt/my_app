import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:my_app/features/chats/bloc/chat_bloc/bloc/chat_bloc.dart';
import 'package:my_app/features/chats/model/chat_message_model.dart';
import 'package:my_app/shared/UIHelper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/features/group/model/user_model.dart';
import 'package:my_app/shared/global.dart';

class Chat extends StatefulWidget {
  const Chat({super.key, required this.userModel});
  final UserModel userModel;

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  ChatBloc _chatBloc = ChatBloc();
  List<Message> messages = [];
  final TextEditingController _textEditingController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final user = FirebaseAuth.instance.currentUser;
  @override
  void initState() {
    _chatBloc.add(ChatInitialEvent());
    super.initState();
  }

  final String senderId = "me";
  final String receiverId = "you";

  AppBar _buildAppBar() => AppBar(
        elevation: 0,
        titleSpacing: 0,
        foregroundColor: Colors.black,
        backgroundColor: Colors.transparent,
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundImage:
                  NetworkImage(widget.userModel.image ?? anonymousUserIconLink),
              radius: 24,
            ),
            const SizedBox(
              width: 14,
            ),
            Column(children: [
              Text(
                widget.userModel.name,
                style: const TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                widget.userModel.isOnline ? 'Online' : 'Offline',
                style: TextStyle(
                    color:
                        widget.userModel.isOnline ? Colors.green : Colors.grey,
                    fontSize: 14),
              )
            ])
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatBloc, ChatState>(
      bloc: _chatBloc,
      listenWhen: (previous, current) {
        if (current is ChatActionState) {
          return true;
        }
        return false;
      },
      buildWhen: (previous, current) {
        if (current is ChatInitialState || current is ChatLoadedState) {
          return true;
        }
        return false;
      },
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        debugPrint(state.runtimeType.toString());

        switch (state.runtimeType) {
          case ChatInitialState:
            return const Scaffold(
                body: Center(child: CircularProgressIndicator()));

          case ChatLoadedState:
            {
              return Scaffold(
                  appBar: _buildAppBar(),
                  body: Container(
                    decoration: UIHelper.customContainerDecoration(),
                    child: Column(children: [
                      Expanded(
                        child: BlocConsumer<ChatBloc, ChatState>(
                          bloc: _chatBloc,
                          listener: (context, state) {
                            if (state is ChatGenerateNewMessageState) {
                              messages.add(Message(
                                  senderId: senderId,
                                  receiverId: receiverId,
                                  content:
                                      _textEditingController.text.toString(),
                                  sentTime: DateTime.now(),
                                  messageType: MessageType.text));
                              _textEditingController.clear();
                              _scrollController.animateTo(
                                  _scrollController.position.extentTotal,
                                  duration: Duration(seconds: 1),
                                  curve: Curves.easeInOutCubicEmphasized);
                            }
                          },
                          builder: (context, state) {
                            return ListView.builder(
                                controller: _scrollController,
                                shrinkWrap: true,
                                itemCount: messages.length,
                                itemBuilder: (context, index) {
                                  return UIHelper.customChat(
                                      (user ==
                                          FirebaseAuth.instance.currentUser),
                                      messages[index].sentTime,
                                      messages[index].content,
                                      context);
                                });
                            // return Center(
                            //   child: Text("hello"),
                            // );
                          },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                  controller: _textEditingController,
                                  decoration: InputDecoration(
                                      fillColor: Colors.white,
                                      filled: true,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 15),
                                      floatingLabelStyle:
                                          const TextStyle(fontSize: 20),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          borderSide: const BorderSide(
                                              width: 0.5,
                                              style: BorderStyle.none)),
                                      focusColor: Colors.blueAccent,
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          borderSide: const BorderSide(
                                              width: 0.5,
                                              style: BorderStyle.none)))),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            InkWell(
                              onTap: () {
                                if (_textEditingController.text.isNotEmpty) {
                                  _chatBloc.add(ChatGenerateNewMessageEvent(
                                      message: Message(
                                          senderId: senderId,
                                          receiverId: receiverId,
                                          content: _textEditingController.text
                                              .toString(),
                                          sentTime: DateTime.now(),
                                          messageType: MessageType.text)));
                                }
                              },
                              child: CircleAvatar(
                                  radius: 26,
                                  backgroundColor:
                                      Color.fromARGB(255, 0, 198, 102),
                                  child: Center(
                                      child: Icon(Icons.send,
                                          color: Colors.white))),
                            )
                          ],
                        ),
                      ),
                    ]),
                  ));
            }
          default:
            {
              return Scaffold(
                  body: Center(child: Text("Something Went Wrong")));
            }
        }
      },
    );
  }
}
