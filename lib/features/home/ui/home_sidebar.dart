import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class HomeSideBar extends StatefulWidget {
  const HomeSideBar({super.key});

  @override
  State<HomeSideBar> createState() => _HomeSideBarState();
}

class _HomeSideBarState extends State<HomeSideBar> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Color.fromARGB(255, 218, 243, 255),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text('Name'),
            accountEmail: Text('Email'),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.network(
                    'https://oflutter.com/wp-content/uploads/2021/02/girl-profile.png',
                    width: 90,
                    height: 90,
                    fit: BoxFit.cover),
              ),
            ),
            decoration: BoxDecoration(
                color: Colors.lightBlueAccent,
                image: DecorationImage(
                    image: NetworkImage(
                        'https://oflutter.com/wp-content/uploads/2021/02/profile-bg3.jpg'),
                    fit: BoxFit.cover)),
          )
        ],
      ),
    );
  }
}
