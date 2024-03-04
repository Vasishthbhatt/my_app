import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  bool isValidating = false;

  LoginBloc() : super(LoginInitial()) {
    on<LoginSignUpTextButtonClickedEvent>(signUpTextButtonClicked);
    on<LoginButtonClickedEvent>(loginButtonClicked);
    on<LoginInitEvent>((event, emit) async{
      emit(LoginInitial());
      if (await FirebaseAuth.instance.currentUser != null) {
        emit(LoginNavigateToHomePage());
      }
      emit(LoginLoadedSuccessState());
    });
    on<LoginValidationSuccessEvent>((event, emit) {
      emit(LoginNavigateToHomePage());
    });
  }

  FutureOr<void> signUpTextButtonClicked(
      LoginSignUpTextButtonClickedEvent event, Emitter<LoginState> emit) {
    emit(LoginNavigateToSignUpPage());
  }

  FutureOr<void> loginButtonClicked(
      LoginButtonClickedEvent event, Emitter<LoginState> emit) async {
    String email = event.email;
    String password = event.password;
    isValidating = true;
    print(isValidating.toString());
    UserCredential? usercredential;

    try {
      usercredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) {
        // Navigator.pushReplacement(
        //     context, MaterialPageRoute(builder: (context) => const Home()));
        emit(LoginNavigateToHomePage());
        return null;
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-credential~') {}
      Future.delayed(const Duration(seconds: 5));
      isValidating = false;
      emit(LoginFormValidationFailureState());
    } finally {
      isValidating = false;
    }
  }
}
