part of 'chat_bloc.dart';

@immutable
sealed class ChatEvent {}

class ChatInitialEvent extends ChatEvent {
  final String receiverId;
  ChatInitialEvent({required this.receiverId});
}

class ChatLoadingMessagesEvent extends ChatEvent {}

class ChatGenerateNewMessageEvent extends ChatEvent {
  final Message message;
  ChatGenerateNewMessageEvent({required this.message});
}
