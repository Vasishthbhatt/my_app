part of 'chat_bloc.dart';

@immutable
sealed class ChatState {}

final class ChatInitialState extends ChatState {}

abstract class ChatActionState extends ChatState {}

abstract class ChatMessageState extends ChatState {}

class ChatLoadedState extends ChatState {}

class ChatGenerateNewMessageState extends ChatMessageState {}

class ChatUserScollDownState extends ChatActionState {}

class ChatNewMessageSentState extends ChatActionState {
  final Message message;
  ChatNewMessageSentState({required this.message});
}
