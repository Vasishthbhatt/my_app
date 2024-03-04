import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:my_app/features/login/bloc/login_bloc.dart';
import 'package:my_app/shared/UIHelper.dart';
import 'package:my_app/shared/global.dart';
import 'package:my_app/shared/myTextHelper.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final LoginBloc _loginBloc = LoginBloc();

  @override
  void initState() {
    // TODO: implement initState

    _loginBloc.add(LoginInitEvent());
    super.initState();
  }

  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(
      bloc: _loginBloc,
      listenWhen: (previous, current) => current is LoginActionState,
      buildWhen: (previous, current) => current is! LoginActionState,
      listener: (context, state) {
        print("LoginState:$state");
        switch (state.runtimeType) {
          case LoginNavigateToSignUpPage:
            {
              context.go(signUpPath);
              debugPrint("Going To SignUp Page");
            }
          case LoginNavigateToHomePage:
            {
              debugPrint("Going to Chat page");
              context.pushReplacement(homePath);
            }
          case LoginFormValidationFailureState:
            {
              UIHelper.customAlertBox(context, "Enter Valid Credentials");
            }
        }
      },
      builder: (context, state) {
        print("LoginState:$state");
        switch (state.runtimeType) {
          case LoginLoadingState:
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          case LoginLoadedSuccessState:
            return Scaffold(
                // appBar: AppBar(
                //   title: Text("Login"),
                // ),
                body: Container(
              decoration: UIHelper.customContainerDecoration(),
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
              alignment: Alignment.center,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MyTextHelper.loginSignUpHeadinText("Login"),
                      const SizedBox(
                        height: 80,
                      ),
                      UIHelper.customTextField(_email, "Enter Your Email",
                          Icons.email, false, TextInputType.emailAddress, (p0) {
                        if (emailRegex.hasMatch(p0!)) {
                          return "Enter Valid Email";
                        }
                      }),
                      UIHelper.customTextField(
                          _password,
                          "Enter Your Password",
                          Icons.password_sharp,
                          true,
                          TextInputType.visiblePassword,
                          (p0) => null),
                      const SizedBox(
                        height: 30,
                      ),
                      !_loginBloc.isValidating
                          ? UIHelper.customButton(() {
                              _loginBloc.add(LoginButtonClickedEvent(
                                  _email.text.toString(),
                                  _password.text.toString()));
                            }, "Login")
                          : const CircularProgressIndicator(),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Don't Have Account?"),
                          TextButton(
                              onPressed: () {
                                _loginBloc
                                    .add(LoginSignUpTextButtonClickedEvent());
                              },
                              child: MyTextHelper.myTextButtonText("Sign Up"))
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ));
          case LoginLoadErrorState:
            return const Scaffold(
              body: Center(
                child: Text("Error"),
              ),
            );
          default:
            return const Scaffold(
              body: Text("DO nothing Login"),
            );
        }
      },
    );
  }
}
