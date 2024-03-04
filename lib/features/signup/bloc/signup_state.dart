part of 'signup_bloc.dart';

@immutable
sealed class SignupState {}

sealed class SignupActionState extends SignupState {}

final class SignupInitial extends SignupState {}

class SignUpLoadingState extends SignupState {}

class SignUpLoadingSuccessState extends SignupState {}

class SignUpNavigateToLoginState extends SignupActionState {}

class SignUpUserRegistrationStartedState extends SignupActionState {}

class SignUpUserRegistrationFailedState extends SignupActionState {}

class SignUpUserRegistrationCompleteState extends SignupActionState {}