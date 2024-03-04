import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_app/features/group/model/user_model.dart';
import 'package:my_app/features/signup/bloc/signup_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/shared/UIHelper.dart';
import 'package:my_app/shared/global.dart';
import 'package:my_app/shared/loading.dart';
import 'package:my_app/shared/myTextHelper.dart';
import 'package:string_validator/string_validator.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final SignupBloc _signupBloc = SignupBloc();
  final TextEditingController _pass = TextEditingController();
  final TextEditingController _confirm_pass = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _name = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initStatesuper.initState();
    _signupBloc.add(SignUpInitialEvent());
    debugPrint("Sigup Page Initialized");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignupBloc, SignupState>(
      bloc: _signupBloc,
      listenWhen: (previous, current) => current is SignupActionState,
      buildWhen: (previous, current) => current is! SignupActionState,
      listener: (context, state) {
        switch (state.runtimeType) {
          case SignUpNavigateToLoginState:
            {
              debugPrint("Going To Login Page");
              context.go(loginPath);
            }
        }
      },
      builder: (context, state) {
        print(state.runtimeType.toString());
        switch (state.runtimeType) {
          case SignUpLoadingState:
            {
              return LoadingWidget();
            }

          case SignUpLoadingSuccessState:
            {
              return Scaffold(
                  body: Container(
                decoration: UIHelper.customContainerDecoration(),
                alignment: Alignment.center,
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MyTextHelper.loginSignUpHeadinText("Sign Up"),
                        const SizedBox(
                          height: 30,
                        ),
                        UIHelper.customTextField(_name, "Enter Your Name",
                            Icons.face, false, TextInputType.name, (p0) {
                          if (!isAlpha(p0!)) {
                            return "Enter Valid Name";
                          }
                        }),
                        UIHelper.customTextField(
                            _email,
                            "Enter Your Email",
                            Icons.email,
                            false,
                            TextInputType.emailAddress, (p0) {
                          if (!emailRegex.hasMatch(p0!)) {
                            return "Enter Valid Email";
                          }
                        }),
                        UIHelper.customTextField(
                            _pass,
                            "Enter Your Password",
                            Icons.password_rounded,
                            true,
                            TextInputType.visiblePassword,
                            (p0) => null),
                        UIHelper.customTextField(
                            null,
                            "Confirm Your Password",
                            Icons.password_rounded,
                            true,
                            TextInputType.visiblePassword, (p0) {
                          if (p0 != _pass.text.toString()) {
                            return "Confirm Password Doesn't Match With Password";
                          }
                        }),
                        const SizedBox(
                          height: 30,
                        ),
                        UIHelper.customButton(() {
                          if (_formKey.currentState!.validate()) {
                            _signupBloc.add(SignUpButtonClickedEvent(
                                name: _name.text.toString(),
                                password: _pass.text.toString(),
                                email: _email.text.toString()));
                          }
                        }, "Sign Up"),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Don't Have Account?"),
                            TextButton(
                                onPressed: () {
                                  _signupBloc
                                      .add(SignUpLoginTextButtonClickedEvent());
                                },
                                child: MyTextHelper.myTextButtonText("Login"))
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ));
            }
          default:
            return const Scaffold(
              body: Text("Do Nothing"),
            );
        }
      },
    );
  }
}

extension MyClass on StatefulWidget {
  void myMethod() {
    print("My Method Is Called");
  }
}
