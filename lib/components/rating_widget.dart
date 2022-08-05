import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';

// opinion form

class FormAndOpinions extends StatefulWidget {
  const FormAndOpinions({Key? key}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  State<FormAndOpinions> createState() => _FormAndOpinionsState();
}

class _FormAndOpinionsState extends State<FormAndOpinions> {
  int _rating = 0;

  void rate(int rating) {
    //Other actions based on rating such as api calls.
    setState(() {
      _rating = rating;
    });
  }
  final _text = TextEditingController();
  bool _validate = false;

  @override
  void dispose() {
    _text.dispose();
    super.dispose();
  }

  void clearText() {
    _text.clear();
  }

  void checkStar ()
  {

  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.

    return Scaffold(
      backgroundColor: const Color.fromRGBO(242, 242, 242, 1),
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: const Text('Your Opinions'),
      ),
      body: SingleChildScrollView(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).

          mainAxisAlignment: MainAxisAlignment.start,

          children: <Widget>[

            const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  'Oceń obiekt wiedzy',
                  style: TextStyle(color: Colors.blueGrey, fontSize: 22),
                  textAlign: TextAlign.left,
                )
            ),



            const Align ( alignment: Alignment.centerLeft,
              child:
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                  child: Text(
                    'Tutaj możesz ocenić obiekt wiedzy',
                    style: TextStyle(color: Colors.grey, fontSize: 15),
                    textAlign: TextAlign.left,
                  )
              ),
            ),

            Row (mainAxisAlignment: MainAxisAlignment.start,

              children: <Widget>[

                IconButton(
                    icon: _rating >= 1
                        ? const Icon(FontAwesomeIcons.solidStar, size: 30, )
                        : const Icon(
                      FontAwesomeIcons.star,
                      size: 30,

                    ),
                    onPressed: () {
                      setState(() {
                        // Here we changing the icon.
                        rate(1);
                      });
                    }),

                IconButton(
                    icon: _rating >= 2
                        ? const Icon(FontAwesomeIcons.solidStar, size: 30, )
                        : const Icon(
                      FontAwesomeIcons.star,
                      size: 30,
                    ),
                    onPressed: () {
                      setState(() {
                        // Here we changing the icon.
                        rate(2);
                      });
                    }),
                IconButton(
                    icon: _rating >= 3
                        ? const Icon(FontAwesomeIcons.solidStar, size: 30, )
                        : const Icon(
                      FontAwesomeIcons.star,
                      size: 30,
                    ),
                    onPressed: () {
                      setState(() {
                        // Here we changing the icon.
                        rate(3);
                      });
                    }),
                IconButton(
                    icon: _rating >= 4
                        ? const Icon(FontAwesomeIcons.solidStar, size: 30, )
                        : const Icon(
                      FontAwesomeIcons.star,
                      size: 30,
                    ),
                    onPressed: () {
                      setState(() {
                        // Here we changing the icon.
                        rate(4);
                      });
                    }),
                IconButton(
                    icon: _rating >= 5
                        ? const Icon(FontAwesomeIcons.solidStar, size: 30, )
                        : const Icon(
                      FontAwesomeIcons.star,
                      size: 30,
                    ),
                    onPressed: () {
                      setState(() {
                        // Here we changing the icon.
                        rate(5);
                      });
                    }),
              ],
            ),

            const SizedBox(height: 10),
            Row (mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[Image.asset('assets/images/default_avatar.png'),
                  SizedBox(width: 320,
                    height: 100,
                    child :TextField(
                      controller: _text,
                      expands: true,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        labelText: 'Komentarz...',
                        errorText: _validate ? 'Pole nie może być puste lub nie zaznaczono gwiazdek' : null,
                        border: const OutlineInputBorder(),

                      ),
                      textAlign: TextAlign.start,
                      keyboardType: TextInputType.multiline,
                      minLines: null,
                      maxLines: null,
                    ),

                  ),
                ]
            ),

            Row (mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child:  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _text.text.isEmpty ? _validate = true : _validate = false ||
                              _rating==0 ? _validate = true : _validate = false;
                        }
                        );
                      },
                      child: const Text('POTWIERDŹ'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child:  ElevatedButton(
                      onPressed: () {
                        _text.clear();
                        _rating=0;// Respond to button press
                      },

                      child: const Text('ANULUJ'),
                    ),
                  ),
                ]
            )
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}