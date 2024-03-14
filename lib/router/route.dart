import 'package:go_router/go_router.dart';
import 'package:my_app/features/chats/ui/chats.dart';
import 'package:my_app/features/group/model/user_model.dart';
import 'package:my_app/features/group/ui/user.dart';
import 'package:my_app/features/home/ui/home.dart';
import 'package:my_app/features/login/ui/login.dart';
import 'package:my_app/features/signup/ui/signup.dart';
import 'package:my_app/shared/global.dart';
import 'package:my_app/shared/loading.dart';

class MyAppRouter {
  final router = GoRouter(routes: <GoRoute>[
    GoRoute(
        name: "Home",
        path: homePath,
        builder: (context, state) => const Home()),
    GoRoute(
      name: "Login",
      path: loginPath,
      builder: (context, state) {
        return const Login();
      },
    ),
    GoRoute(
      name: "Loading",
      path: loadingWidgetPath,
      builder: (context, state) {
        return const LoadingWidget();
      },
    ),
    GoRoute(
      name: "SignUp",
      path: signUpPath,
      builder: (context, state) {
        return const SignUp();
      },
    ),
    GoRoute(
      name: "Chat",
      path: chatPath,
      builder: (context, state) {
        UserModel _userModel = state.extra as UserModel;
        return Chat(userModel: _userModel);
      },
    ),
    GoRoute(
      name: "User",
      path: userPath,
      builder: (context, state) {
        return const User();
      },
    )
  ]);
}
