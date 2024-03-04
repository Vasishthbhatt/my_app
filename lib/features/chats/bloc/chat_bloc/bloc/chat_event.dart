part of 'chat_bloc.dart';

@immutable
sealed class ChatEvent {}

class ChatInitialEvent extends ChatEvent {}

class ChatGenerateNewMessageEvent extends ChatEvent {
  final Message message;
  ChatGenerateNewMessageEvent({required this.message});
}
