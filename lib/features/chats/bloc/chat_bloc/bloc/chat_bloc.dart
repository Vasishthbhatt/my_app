import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:my_app/features/chats/model/chat_message_model.dart';
import 'package:my_app/features/chats/repos/chat_repo.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final ChatRepo _chatRepo = ChatRepo();

  ChatBloc() : super(ChatInitialState()) {
    on<ChatInitialEvent>(chatInitalEvent);
    on<ChatLoadingMessagesEvent>((event, emit) => emit.forEach(
          _chatRepo.getMessages(),
          onData: (data) {
            return ChatLoadingState(messages: data);
          },
        ));

    on<ChatGenerateNewMessageEvent>(chatGenerateNewMessageEvent);
  }

  FutureOr<void> chatInitalEvent(
      ChatInitialEvent event, Emitter<ChatState> emit) async {
    _chatRepo.receiverId = event.receiverId;
    emit(ChatInitialState());
    add(ChatLoadingMessagesEvent());
    emit(ChatLoadedState());
  }

  FutureOr<void> chatGenerateNewMessageEvent(
      ChatGenerateNewMessageEvent event, Emitter<ChatState> emit) {
    _chatRepo.addMessage(event.message);
    emit(ChatGenerateNewMessageState());
  }
}
