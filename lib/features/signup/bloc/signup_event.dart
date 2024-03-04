part of 'signup_bloc.dart';

@immutable
sealed class SignupEvent {}

class SignUpInitialEvent extends SignupEvent {}

class SignUpNetworkErrorEvent extends SignupEvent {}

class SignUpLoginTextButtonClickedEvent extends SignupEvent {}

class SignUpButtonClickedEvent extends SignupEvent {
  final String name;
  final String email;
  final String password;
  SignUpButtonClickedEvent({required this.name, required this.email, required this.password});

}
