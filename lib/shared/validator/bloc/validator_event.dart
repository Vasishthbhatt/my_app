part of 'validator_bloc.dart';

@immutable
sealed class ValidatorEvent {}

class ValidatorTypingEvent extends ValidatorEvent {
}
