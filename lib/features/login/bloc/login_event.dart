part of 'login_bloc.dart';

@immutable
sealed class LoginEvent {}

class LoginInitEvent extends LoginEvent {}

class LoginButtonClickedEvent extends LoginEvent {
  final String email;
  final String password;

  LoginButtonClickedEvent(this.email,this.password);
}

class LoginSignUpTextButtonClickedEvent extends LoginEvent {}

class LoginForgotPasswordTextButtonClickedEvent extends LoginEvent {}

class LoginValidationSuccessEvent extends LoginEvent {}
