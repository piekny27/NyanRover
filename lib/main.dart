import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:first_project/routes.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:firebase_core/firebase_core.dart';
import 'components/transitions/no_page_transition.dart';
import 'firebase_options.dart';

Future main() async {
  await dotenv.load(fileName: "assets/.env");
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nyan rover',
      initialRoute: '/',
      routes: routes,
      theme: ThemeData(
        pageTransitionsTheme: PageTransitionsTheme(
            builders: kIsWeb
                ? {
                    for (final platform in TargetPlatform.values)
                      platform: const NoTransitionsBuilder(),
                  }
                : const {
                    TargetPlatform.android: ZoomPageTransitionsBuilder(),
                    TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
                  }),
      ),
    );
  }
}
