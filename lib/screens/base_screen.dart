import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_project/utils/screen_size.dart';
import 'package:flutter/material.dart';
import 'package:first_project/constants.dart';
import 'package:first_project/components/base/topBar_widget.dart';

import '../components/base/drawer_widget.dart';

class BaseScreen extends StatefulWidget {
  final Widget body;

  const BaseScreen({super.key, required this.body});

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  User? _user;
  FirebaseAuth? _auth;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        setState(() {
          _auth = FirebaseAuth.instance;
          _user = FirebaseAuth.instance.currentUser!;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      primary: true,
      appBar: ScreenSize.isSmallScreen(context)
          ? AppBar(
              elevation: 0.7,
              leading: IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () {
                  bool? a = _scaffoldKey.currentState?.isDrawerOpen;
                  if (a == false) {
                    _scaffoldKey.currentState?.openDrawer();
                  } else {
                    _scaffoldKey.currentState?.closeDrawer();
                  }
                },
              ),
              iconTheme: const IconThemeData(color: Colors.white70),
              backgroundColor: Colorss.gray02,
              centerTitle: true,
              title: const Text('Nyan Rover'),
              automaticallyImplyLeading: false,
            )
          : PreferredSize(
              preferredSize: Size(screenSize.width, 70),
              child: const TopBar(),
            ),
      body: Scaffold(
        key: _scaffoldKey,
        drawer: MenuDrawer(
          auth: _auth,
        ),
        body: widget.body,
      ),
    );
  }

  /*@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: _user != null
            ? Text('Welcome ${_user?.displayName}')
            : const Text('Welcome'),
      ),
      body: const Center(
        child: Text('New application incoming....'),
      ),
    );
  }*/
}
