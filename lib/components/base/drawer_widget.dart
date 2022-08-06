import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:first_project/constants.dart';

class MenuDrawer extends StatelessWidget {
  final FirebaseAuth? auth;
  const MenuDrawer({
    super.key,
    required this.auth,
  });

  final style1 = const TextStyle(
    color: Colors.white70,
    fontSize: 26,
    fontFamily: 'Raleway',
    fontWeight: FontWeight.w900,
    letterSpacing: 3,
  );
  final style2 = const TextStyle(
    color: Colorss.gray01,
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );

  Widget userButtons(BuildContext context) {
    return (auth != null)
        ? Align(
            alignment: Alignment.center,
            child: ElevatedButton(
              onPressed: () async {
                await auth?.signOut().then((_) {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      "/home", ModalRoute.withName("/home"));
                });
              },
              child: const Text('Logout'),
            ),
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/login');
                },
                child: const Text('Log in'),
              ),
              const SizedBox(
                width: 10,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/login');
                },
                child: const Text('Sign in'),
              ),
            ],
          );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 220,
      child: Container(
        color: Colorss.gray04,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ListTile(
                title: Text(
                  'Home',
                  style: style2,
                ),
                onTap: () {
                  Navigator.pushNamed(context, '/home');
                },
              ),
              const Padding(
                padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
                child: Divider(
                  color: Colorss.gray02,
                  thickness: 2,
                ),
              ),
              ListTile(
                title: Text(
                  'Dashboard',
                  style: style2,
                ),
                onTap: () {
                  Navigator.pushNamed(context, '/dashboard');
                },
              ),
              const Padding(
                padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
                child: Divider(
                  color: Colorss.gray02,
                  thickness: 2,
                ),
              ),
              ListTile(
                title: Text(
                  'Contact',
                  style: style2,
                ),
                onTap: () {
                  Navigator.pushNamed(context, '/contact');
                },
              ),
              const Padding(
                padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
                child: Divider(
                  color: Colorss.gray02,
                  thickness: 2,
                ),
              ),
              ListTile(
                title: Text(
                  'About',
                  style: style2,
                ),
                onTap: () {
                  Navigator.pushNamed(context, '/about');
                },
              ),
              const Padding(
                padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
                child: Divider(
                  color: Colorss.gray02,
                  thickness: 2,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              userButtons(context),
              const Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    'Copyright© 2022 | piekny27',
                    style: TextStyle(
                      color: Colorss.gray01,
                      fontSize: 14,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
