import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:my_app/features/group/model/user_model.dart';
import 'package:my_app/shared/global.dart';
import 'package:timeago/timeago.dart' as timeago;

class UIHelper {
  static customTextField(
      TextEditingController? controller,
      String text,
      IconData iconData,
      bool toHide,
      TextInputType textInputType,
      Function(String?)? validate) {
    return IntrinsicWidth(
      stepWidth: 400,
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
          child: TextFormField(
            controller: controller,
            obscureText: toHide,
            decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                floatingLabelStyle: const TextStyle(fontSize: 20),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide:
                        const BorderSide(width: 0.5, style: BorderStyle.none)),
                focusColor: Colors.blueAccent,
                suffixIcon: Icon(iconData),
                labelText: text),
            keyboardType: textInputType,
            validator: ((value) {
              if (value == null) {
                return null;
              } else {
                return value.isEmpty
                    ? "Above Field Cannot be Empty"
                    : validate!(value);
              }
            }),
          )),
    );
  }

  static customButton(VoidCallback voidCallback, String text) {
    return SizedBox(
      height: 50,
      width: 250,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 55, 85, 255)),
          child: Text(
            text,
            style: const TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () {
            voidCallback();
          }),
    );
  }

  static customAlertBox(BuildContext context, String text) {
    showDialog(
        context: context,
        builder: (BuildContext) {
          return AlertDialog(
            title: Text(
              text,
              textScaler: const TextScaler.linear(0.5),
            ),
          );
        });
  }

  static customContainerDecoration() {
    return const BoxDecoration(
        // gradient: LinearGradient(
        //     begin: Alignment.topCenter,
        //     end: Alignment.bottomCenter,
        //     colors: [
        //   Color.fromARGB(255, 213, 231, 255),
        //   Color.fromARGB(255, 219, 234, 251),
        //   Color.fromARGB(255, 222, 237, 255),
        //   Color.fromARGB(255, 179, 214, 255),
        // ],a
        //     stops: [
        //   0.1,
        //   0.4,
        //   0.7,
        //   0.9
        // ])
        image: DecorationImage(
            opacity: 0.4,
            fit: BoxFit.fill,
            image: AssetImage("res/Flutter.jpeg")));
  }

  static createTransition(
      BuildContext context, GoRouterState state, StatefulWidget child) {
    return CustomTransitionPage(
      key: state.pageKey,
      child: child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) =>
          FadeTransition(opacity: animation, child: child),
    );
  }

  // static customChat(bool isUser, String message, BuildContext context) {
  //   return UnconstrainedBox(
  //     child: Container(
  //       constraints: BoxConstraints(
  //                   maxWidth: MediaQuery.of(context).size.width * 0.7,
  //                 ),
  //         decoration: BoxDecoration(
  //             color: isUser ? Colors.lightGreenAccent : Colors.orange,
  //             borderRadius: isUser
  //                 ? const BorderRadius.only(
  //                     topRight: Radius.circular(20),
  //                     topLeft: Radius.circular(20),
  //                     bottomRight: Radius.circular(20))
  //                 : const BorderRadius.only(
  //                     topRight: Radius.circular(20),
  //                     topLeft: Radius.circular(20),
  //                     bottomLeft: Radius.circular(20))),
  //         margin: isUser
  //             ? const EdgeInsets.only(left: 1.0, top: 10)
  //             : const EdgeInsets.only(right: 1.0, top: 10),
  //         padding: const EdgeInsets.all(12),
  //         child: Text(
  //           message,
  //           style: TextStyle(fontSize: 22),
  //         )),
  //   );

  static customUserListWidgetView(
      List<UserModel> _user, BuildContext context, int index) {
    return InkWell(
      focusColor: Colors.grey,
      onLongPress: () {
        context.push(chatPath, extra: _user[index]);
      },
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: Stack(
          alignment: Alignment.bottomRight,
          children: [
            CircleAvatar(
              radius: 30,
              backgroundImage:
                  NetworkImage(_user[index].image ?? anonymousUserIconLink),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: CircleAvatar(
                radius: 5,
                backgroundColor:
                    _user[index].isOnline ? Colors.green : Colors.grey,
              ),
            )
          ],
        ),
        title: Text(_user[index].name,
            style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold)),
        subtitle: !_user[index].isOnline
            ? Text(
                'Last Active: ${timeago.format(_user[index].lastActive)}',
                style: const TextStyle(color: Colors.blueGrey, fontSize: 14),
                overflow: TextOverflow.ellipsis,
              )
            : Text(
                'Online',
                style: TextStyle(color: Colors.green, fontSize: 14),
              ),
      ),
    );
  }

  static customChat(
      bool isUser, DateTime dateTime, String messages, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Flex(
        direction: Axis.horizontal,
        mainAxisAlignment:
            isUser ? MainAxisAlignment.start : MainAxisAlignment.end,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(10.0),
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.7,
            ),
            decoration: isUser
                ? BoxDecoration(
                    border: Border.all(
                      color: Colors.lightGreen,
                    ),
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                        bottomRight: Radius.circular(20)),
                  )
                : const BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                        bottomLeft: Radius.circular(20)),
                  ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(messages,
                    textScaler: MediaQuery.textScalerOf(context)
                        .clamp(minScaleFactor: 1.5, maxScaleFactor: 3),
                    style: TextStyle(
                      color: Colors.black,
                    )),
                Text(
                  DateFormat("HH:mm a").format(dateTime),
                  style: const TextStyle(color: Colors.black, fontSize: 10),
                )
              ],
            ),
            // Align(
            //     alignment: Alignment.bottomLeft,
            //     child: Text(
            //       DateFormat("hh:mm a").format(DateTime.now()),
            //       style: const TextStyle(fontSize: 20.0),
            //     ))
          ),
        ],
      ),
    );
  }
}




// return Container(
//         decoration: BoxDecoration(
//             color: isUser ? Colors.lightGreenAccent : Colors.orange,
//             borderRadius: isUser
//                 ? const BorderRadius.only(
//                     topRight: Radius.circular(20),
//                     topLeft: Radius.circular(20),
//                     bottomRight: Radius.circular(20))
//                 : const BorderRadius.only(
//                     topRight: Radius.circular(20),
//                     topLeft: Radius.circular(20),
//                     bottomLeft: Radius.circular(20))),
//         margin: isUser
//             ? const EdgeInsets.only(left: 1.0, top: 10)
//             : const EdgeInsets.only(right: 1.0, top: 10),
//         padding: const EdgeInsets.all(12),
//         alignment: Alignment.bottomRight,
//         child: Text(
//           message,
//           style: TextStyle(fontSize: 22),
//         ));
