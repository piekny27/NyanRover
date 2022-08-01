import 'package:flutter/material.dart';

class _CoolCounterState extends State<CoolCounter> {
  int _counter = 0;
  int _selectedIndex = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _decrementCounter() {
    setState(() {
      _counter--;
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
        //child: _widgetOptions.elementAt(_selectedIndex),
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Container(
          color: Colors.black12,
          height: 200,
          width: 300,
          padding: const EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              Text(
                '$_counter',
                style: Theme.of(context).textTheme.headline4,
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Increase or decrease this counter bellow',
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  FloatingActionButton(
                    onPressed: _incrementCounter,
                    tooltip: 'Increment',
                    backgroundColor: Colors.deepOrange,
                    child: const Icon(Icons.add),
                  ),
                  FloatingActionButton(
                    onPressed: _decrementCounter,
                    tooltip: 'Decrement',
                    backgroundColor: Colors.deepOrange,
                    child: const Icon(Icons.remove),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
class CoolCounter extends StatefulWidget {
  const CoolCounter({super.key});

  @override
  State<CoolCounter> createState() => _CoolCounterState();
}
