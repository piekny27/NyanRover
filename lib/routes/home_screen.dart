import 'package:first_project/constants.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(background1),
              fit: BoxFit.cover,
          ),
        ),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
                'Hello GroMar!',
                style: Theme.of(context).textTheme.displayMedium?.copyWith(color: Colors.white)
            ),
            const SizedBox(height: 40,),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/dashboard');
              },
              style: Theme.of(context).elevatedButtonTheme.style,
              child: const Text('Enter'),
            ),
          ],
        ),
      ),
    );
  }
}
