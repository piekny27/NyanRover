import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AwesomeTabs(),
      theme: ThemeData(
        textTheme: GoogleFonts.latoTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
    );
  }
// #enddocregion build
}

//common part

class _RandomWordsState extends State<RandomWords> {
  final _saved = <WordPair>{};
  final _suggestions = <WordPair>[];
  final _biggerFont = const TextStyle(fontSize: 18);

  void _pushSaved() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (context) {
          final tiles = _saved.map(
                (pair) {
              return ListTile(
                title: Text(
                  pair.asPascalCase,
                  style: _biggerFont,
                ),
              );
            },
          );
          final divided = tiles.isNotEmpty
              ? ListTile.divideTiles(
            context: context,
            tiles: tiles,
          ).toList()
              : <Widget>[];

          return Scaffold(
            appBar: AppBar(
              title: const Text('Saved Suggestions'),
            ),
            body: ListView(children: divided),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Startup Name Generator'),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite_sharp),
            onPressed: _pushSaved,
            tooltip: 'Saved Suggestions',
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(20.0),
        itemBuilder: (context, i) {
          if (i.isOdd) return const Divider();

          final index = i ~/ 2;
          if (index >= _suggestions.length) {
            _suggestions.addAll(generateWordPairs().take(10));
          }
          final alreadySaved = _saved.contains(_suggestions[index]);
          return ListTile(
            title: Text(
              _suggestions[index].asPascalCase,
              style: _biggerFont,
            ),
            trailing: Icon(
              alreadySaved ? Icons.favorite : Icons.favorite_border,
              color: alreadySaved ? Colors.red : null,
              semanticLabel: alreadySaved ? 'Remove from saved' : 'Save',
            ),
            onTap: () {
              setState(() {
                if (alreadySaved) {
                  _saved.remove(_suggestions[index]);
                } else {
                  _saved.add(_suggestions[index]);
                }
              });
            },
          );
        },
      ),
    );
  }
}
class RandomWords extends StatefulWidget {
  const RandomWords({Key? key}) : super(key: key);

  @override
  State<RandomWords> createState() => _RandomWordsState();
}

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

class _AwesomeTabs extends State<AwesomeTabs> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    Center(
      child: Text(
        'Hello GroMar!',
        style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
      ),
    ),
    CoolCounter(),
    RandomWords(),
    Notifications(),
    FormAndOpinions(),
    Trophies(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.countertops),
            label: 'Demo1:Counter',
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.view_list),
            label: 'Demo2:Favorites',
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Task1:Notifications',
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Task2:Form and Opinions',
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Task3:Trophies',
            backgroundColor: Colors.blue,
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        onTap: _onItemTapped,
      ),
    );
  }
}
class AwesomeTabs extends StatefulWidget{
  const AwesomeTabs({Key? key}) : super(key: key);

  @override
  State<AwesomeTabs> createState() => _AwesomeTabs();
}

//notifications

class Note {
  final String leading;
  final String title;
  final String subtitle;
  final String trailing;
  final String status;

  final String login;

  const Note({
    required this.leading,
    required this.title,
    required this.subtitle,
    required this.trailing,
    required this.status,
    required this.login,
  });
}

const allNotes =[
  Note(
    login: '',
    leading: 'bell',
    title: 'Ostatnio ukończyłeś "ankieta normalna".',
    subtitle: 'Wysłane 17 minut temu',
    trailing: 'food_bank',
    status: 'Brak',
  ),
  Note(
    login: 'admin Administrator Globalny',
    leading: 'bell',
    title: 'Ostatnio ukończyłeś "ankieta test 04.05.22".',
    subtitle: 'Wysłane 3 dni temu',
    trailing: 'food_bank',
    status: 'Przeczytano',
  ),
  Note(
    login: 'admin Administrator Globalny',
    leading: 'bell',
    title: 'Ostatnio ukończyłeś "BHP AB.mp4"',
    subtitle: '3 miesiące temu',
    trailing: 'food_bank',
    status: 'Brak',
  ),
  Note(
    login: 'admin Administrator Globalny',
    leading: 'bell',
    title: 'Ostatnio ukończyłeś "Oferta ELF19 Sponsor_Wystawca.pdf"',
    subtitle: '3 miesiące temu',
    trailing: 'food_bank',
    status: 'Brak',
  ),
];

class MySearchDelegate extends SearchDelegate{
  List<Note> notes = allNotes;

  final enabledStyle = const TextStyle(
      color: Colors.black
  );
  final disabledStyle = const TextStyle(
      color: Colors.grey
  );

  @override
  Widget? buildLeading(BuildContext context) => IconButton(
    onPressed: () => close(context, null),
    icon: const FaIcon(FontAwesomeIcons.arrowLeft),
  );

  @override
  List<Widget>? buildActions(BuildContext context) => [
    IconButton(
        onPressed: () {
          if(query.isEmpty){
            close(context,null);
          }else {
            query = '';
          }
        },
        icon: const FaIcon(FontAwesomeIcons.xmark))
  ];

  @override
  Widget buildResults(BuildContext context) => Container();

  @override
  Widget buildSuggestions(BuildContext context) {

    final suggestions = notes.where((note){
      final noteTitle = note.title.toLowerCase();
      final input = query.toLowerCase();
      return noteTitle.contains(input);
    }).toList();

    return ListView.separated(
      padding: const EdgeInsets.all(20.0),
      itemCount: suggestions.length,
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemBuilder: (context, i) {
        final note = suggestions[i];
        var style = enabledStyle;
        if(note.status.contains('Przeczytano')){
          style = disabledStyle;
        }
        return ListTile(
          leading: const FaIcon(FontAwesomeIcons.bell),
          title: Text(note.title,style: style,),
          subtitle: Text(note.subtitle),
          //trailing: const Icon(Icons.circle_outlined),
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NotePage(note: note),
            ),
          ),
        );
      },
      separatorBuilder: (context, i) => const Divider(),
    );
  }
}
class NotePage extends StatelessWidget {
  final Note note;
  const NotePage({ Key? key, required this.note,}) : super(key: key);
  final tStyle = const TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 20,
  );
  final tStyle2 = const TextStyle(
    fontSize: 20,
  );

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text('Notification'),
    ),
    body: Container(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text.rich(
            TextSpan(
              children: <TextSpan>[
                TextSpan(text: 'Title: ', style: tStyle,),
                TextSpan(text: note.title, style: tStyle2,),
              ],
            ),
          ),
          Text.rich(
            TextSpan(
              children: <TextSpan>[
                TextSpan(text: 'Login: ', style: tStyle,),
                TextSpan(text: note.login, style: tStyle2,),
              ],
            ),
          ),
          Text.rich(
            TextSpan(
              children: <TextSpan>[
                TextSpan(text: 'Status: ', style: tStyle,),
                TextSpan(text: note.status, style: tStyle2,),
              ],
            ),
          ),
          Text.rich(
            TextSpan(
              children: <TextSpan>[
                TextSpan(text: 'Date: ', style: tStyle,),
                TextSpan(text: note.subtitle, style: tStyle2,),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

class _NotificationsState extends State<Notifications> {
  List<Note> notes = allNotes;

  final enabledStyle = const TextStyle(
      color: Colors.black
  );
  final disabledStyle = const TextStyle(
      color: Colors.grey
  );

  @override
  Widget build(BuildContext context) {
    const title = 'Notifications';
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text(title),
          actions: <Widget>[
            IconButton(
              icon: const FaIcon(FontAwesomeIcons.magnifyingGlass),
              tooltip: 'Search',
              iconSize: 20,
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: MySearchDelegate(),
                );
              },
            ),
            const SizedBox(
              width: 30,
            ),
          ],
          leading: SizedBox(
            width: double.infinity,
            child: IconButton(
              icon: const FaIcon(FontAwesomeIcons.arrowLeft),
              onPressed: () {/*todo*/},
            ),
          ),
        ),
        body: ListView.separated(
          padding: const EdgeInsets.all(20.0),
          itemCount: notes.length,
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemBuilder: (context, i) {
            final note = notes[i];
            var style = enabledStyle;
            if(note.status.contains('Przeczytano')){
              style = disabledStyle;
            }
            return ListTile(
              leading: const FaIcon(FontAwesomeIcons.bell),
              title: Text(note.title,style: style,),
              subtitle: Text(note.subtitle),
              //trailing: const Icon(Icons.circle_outlined),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NotePage(note: note),
                ),
              ),
            );
          },
          separatorBuilder: (context, i) => const Divider(),
        ),
      ),
    );
  }
}
class Notifications extends StatefulWidget {
  const Notifications({super.key});

  @override
  State<Notifications> createState() => _NotificationsState();
}
//Trophies
class Trophies extends StatefulWidget {
  const Trophies({Key? key }) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".


  @override
  State<Trophies> createState() => _TrophiesState();

}


class _TrophiesState extends State<Trophies> {
  int _counterpoints = 0;
  int _countertrophy = 0;
  int _countertrophiesleft = 100;
  String message1='100';

  void _incrementCounterPoints() {
    setState(() {

      _counterpoints++;
    });
  }
  void _incrementCounterTrophy() {
    if (_countertrophiesleft > 0) {
      setState(() {
        _countertrophy++;
        _countertrophiesleft--;
        message1 = _countertrophiesleft.toString();
      });
    }
    if (_countertrophiesleft == 0) {
      setState(() {
        message1 = 'There are no trophies left!';
      }
      );
    }
  }
  void _addnewtrophiestoearn() {
    setState(() {

      _countertrophiesleft++;
    });
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
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(25, 25, 25, 1.0),

          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: const Text('Trophies'),
          titleSpacing: 00.0,
          centerTitle: true,
          toolbarHeight: 60.2,
          toolbarOpacity: 0.8,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
                bottomRight: Radius.circular(25),
                bottomLeft: Radius.circular(25)),
          ),
          leading: SizedBox(
            width: double.infinity,
            child: IconButton(
              icon: const FaIcon(FontAwesomeIcons.arrowLeft, color: Color.fromRGBO(218, 165, 32, 1.0)),
              onPressed: (){/*ToDo*/},
            ),
          ),

        ),
        body:Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,

              children:  <Widget> [
                const Padding(padding: EdgeInsets.all(20)),
                const Text('All Trophies', style: TextStyle(
                    color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),),
                const SizedBox(height: 20,),
                Expanded(
                    child: GridView(
                      shrinkWrap: true,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                      ),
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            IconButton(onPressed: _incrementCounterTrophy, tooltip: 'Earn a trophy', icon: const Icon(FontAwesomeIcons.trophy, color: Color.fromRGBO(218, 165, 32, 1.0))),
                            const SizedBox(height: 10),
                            Text('Trophies earned: $_countertrophy', style: const TextStyle(color: Colors.white)),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children:  [
                            IconButton(onPressed: _addnewtrophiestoearn, tooltip: 'Add trophies to earn', icon: const Icon(FontAwesomeIcons.trophy, color: Color.fromRGBO(218, 165, 32, 1.0))),
                            const SizedBox(height: 10),
                            Text('Trophies to earn: $message1', style: const TextStyle(color: Colors.white)),
                          ],
                        ),

                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            //Icon(FontAwesomeIcons.database,color: Color.fromRGBO(218, 165, 32, 1.0)),
                            IconButton(onPressed: (){
                              _incrementCounterPoints();
                            }, tooltip: 'Earn a point', icon: const Icon(FontAwesomeIcons.database, color: Color.fromRGBO(218, 165, 32, 1.0))),
                            const SizedBox(height: 10),
                            Text('Points earned: $_counterpoints', style: const TextStyle(color: Colors.white)),

                          ],
                        ),
                      ],
                    )
                )
              ],
            )
        )
    );
  }
}

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

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
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
            SizedBox(height: 10),
            Text(
              'Oceń obiekt wiedzy',
              style: TextStyle(color: Colors.blue, fontSize: 22)
              ,
            ),
            Text(
              'Tutaj możesz ocenić obiekt wiedzy',
              style: TextStyle(color: Colors.grey, fontSize: 15),
            ),
            SizedBox(height: 10),
            Row (mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Icon(Icons.star_outline, size: 40,),
                  const Icon(Icons.star_outline, size: 40,),
                  const Icon(Icons.star_outline, size: 40,),
                  const Icon(Icons.star_outline, size: 40,),
                  const Icon(Icons.star_outline, size: 40,),
                ]),

            SizedBox(height: 10),
            SizedBox(width: 400,
              height: 200,


              child: TextField(
                decoration: InputDecoration(
                  icon: new Icon(Icons.person),

                  labelText: 'Komentarz...',
                  border: OutlineInputBorder(),
                ),
                textAlign: TextAlign.start,
                keyboardType: TextInputType.multiline,
                maxLines: 5,
              ),
            ),



        Row (mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            Padding(
              padding: const EdgeInsets.all(10.0),
              child:  ElevatedButton(
                onPressed: () {
                  // Respond to button press
                },

                child: Text('POTWIERDŹ'),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(10.0),
              child:  ElevatedButton(
                onPressed: () {
                  // Respond to button press
                },

                child: Text('ANULUJ'),
              ),
            ),
          ]
        )],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}