import 'package:flutter/material.dart';
import 'package:first_project/components/tasks_list_widget.dart';
import 'package:first_project/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';


class DashboardWidget extends StatefulWidget {
  const DashboardWidget({super.key});

  @override
  State<DashboardWidget> createState() => _DashboardWidgetState();
}

class _DashboardWidgetState extends State<DashboardWidget> {
  User? _user;

  @override
  void initState() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        setState(() {
          _user = FirebaseAuth.instance.currentUser!;
        });
      }
      else {
        Navigator.pushNamed(context, '/login');
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(background2),
          fit: BoxFit.cover,
        ),
      ),
      alignment: Alignment.topCenter,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Card(
          elevation: 4.0,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5),
                      topRight: Radius.circular(5)),
                ),
                tileColor: Theme
                    .of(context)
                    .primaryColor,
                title: Text('Tasks:',
                    style: Theme
                        .of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(color: Colors.white)),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 10, bottom: 10),
                child: SizedBox(
                  height: 280.0,
                  child: TasksList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
