import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:my_app/features/chats/model/chat_message_model.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc() : super(ChatInitialState()) {
    on<ChatInitialEvent>(chatInitalEvent);
    on<ChatGenerateNewMessageEvent>(chatGenerateNewMessageEvent);
  }

  FutureOr<void> chatInitalEvent(
      ChatInitialEvent event, Emitter<ChatState> emit) {
    emit(ChatInitialState());
    emit(ChatLoadedState());
  }

  FutureOr<void> chatGenerateNewMessageEvent(
      ChatGenerateNewMessageEvent event, Emitter<ChatState> emit) {
    emit(ChatGenerateNewMessageState());
  }
}
