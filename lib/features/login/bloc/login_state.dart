part of 'login_bloc.dart';

@immutable
sealed class LoginState {}

@immutable
sealed class LoginActionState extends LoginState {}

final class LoginInitial extends LoginState {}

class LoginLoadingState extends LoginState {}

class LoginLoadedSuccessState extends LoginState {}

class LoginLoadErrorState extends LoginState {}

class LoginFormValidationState extends LoginActionState {}

class LoginFormValidationSuccessState extends LoginActionState {}

class LoginFormValidationFailureState extends LoginActionState {}

class LoginNavigateToSignUpPage extends LoginActionState {}

class LoginNavigateToHomePage extends LoginActionState {}

class LoginNavigateToForgotPasswordState extends LoginActionState {}

