import 'package:flutter/material.dart';
import 'package:first_project/utils/screen_size.dart';
import 'package:first_project/constants.dart';
import 'package:first_project/components/base/topBar_widget.dart';

class AppBarMain extends StatelessWidget {
  const AppBarMain({super.key});

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return ScreenSize.isSmallScreen(context)
        ? AppBar(
            iconTheme: const IconThemeData(color: Colors.white70),
            backgroundColor: Colorss.gray02,
            centerTitle: true,
            title: const Text('Nyan Rover'),
          )
        : PreferredSize(
            preferredSize: Size(screenSize.width, 70),
            child: const TopBar(),
          );
  }
}
