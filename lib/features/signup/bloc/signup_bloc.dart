import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:my_app/features/group/model/user_model.dart';
import 'package:my_app/features/signup/repo/signup_repo.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  final SignUpRepo _signUpRepo = SignUpRepo();

  SignupBloc() : super(SignupInitial()) {
    on<SignUpInitialEvent>(signUpInitialEvent);
    on<SignUpLoginTextButtonClickedEvent>(
      (event, emit) {
        emit(SignUpNavigateToLoginState());
      },
    );
    on<SignUpButtonClickedEvent>(signUpButtonClickedEvent);
  }

  FutureOr<void> signUpInitialEvent(
      SignUpInitialEvent event, Emitter<SignupState> emit) {
    emit(SignUpLoadingState());
    emit(SignUpLoadingSuccessState());
  }

  FutureOr<void> signUpButtonClickedEvent(
      SignUpButtonClickedEvent event, Emitter<SignupState> emit) {
    print("Signing Up");
    emit(SignUpUserRegistrationStartedState());
    _signUpRepo
        .registerUser(event.email, event.name, event.password)
        .onError((error, stackTrace) {
      emit(SignUpUserRegistrationFailedState());
    });
    emit(SignUpUserRegistrationCompleteState());
  }
}
