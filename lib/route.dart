import 'package:flutter/material.dart';
import 'package:first_project/components/cool_counter_widget.dart';
import 'package:first_project/components/random_words_widget.dart';
import 'package:first_project/routes/dashboard_screen.dart';
import 'package:first_project/routes/home_screen.dart';

MaterialApp mainRoute = MaterialApp(
  title: 'Awesome first app',
  initialRoute: '/',
  routes: {
    '/': (context) => const HomeScreen(),
    '/dashboard': (context) => const DashboardScreen(),
    '/demo1': (context) => const CoolCounter(),
    '/demo2': (context) => const RandomWords(),
  },
);
