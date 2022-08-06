import 'package:first_project/components/dashboard_widget.dart';
import 'package:first_project/components/home_widget.dart';
import 'package:first_project/screens/base_screen.dart';
import 'package:first_project/components/login_widget.dart';
import 'package:flutter/material.dart';
import 'package:first_project/components/cool_counter_widget.dart';
import 'package:first_project/components/random_words_widget.dart';
import 'package:first_project/components/notification_widget.dart';
import 'package:first_project/components/rating_widget.dart';
import 'package:first_project/components/trophies_widget.dart';


Map<String, Widget Function(dynamic)> routes = {
  '/': (context) => const HomeWidget(),
  '/home': (context) => const BaseScreen(body: HomeWidget(),),
  '/login': (context) => const BaseScreen(body: LoginScreen(),),
  '/dashboard': (context) => const BaseScreen(body: DashboardWidget(),),
  '/demo1': (context) => const CoolCounter(),
  '/demo2': (context) => const RandomWords(),
  '/notifications': (context) => const Notifications(),
  '/rating': (context) => const FormAndOpinions(),
  '/trophies': (context) => const Trophies(),
};