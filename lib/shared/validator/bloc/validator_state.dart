part of 'validator_bloc.dart';

@immutable
sealed class ValidatorState {}

class ValidatorActionState extends ValidatorState {}

class ValidatorTypingState extends ValidatorState {
   final String value="";
}

class ValidatorInitial extends ValidatorState {}

class ValidatorCorrectState extends ValidatorState {}

class ValidatorWrongState extends ValidatorState {}
