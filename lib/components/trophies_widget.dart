import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

//Trophies
class Trophies extends StatefulWidget {
  const Trophies({Key? key}) : super(key: key);

  @override
  State<Trophies> createState() => _TrophiesState();
}

class _TrophiesState extends State<Trophies> {
  int _counterpoints = 0;
  int _countertrophy = 0;
  int _countertrophiesleft = 100;
  String message1 = '100';

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
        message1 = 'Trofea zdobyte!';
      });
    }
  }

  void _addnewtrophiestoearn() {
    setState(() {
      _countertrophiesleft++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(242, 242, 242, 1),
        body: Column(
          children: [
            Container(
              //padding: EdgeInsets.all(10),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Column(children: [
                    Container(
                      padding: EdgeInsets.all(15),
                      child: const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Trofea',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 30,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(15),
                      child: const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Podsumowanie zdobytych trofeów:',
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(right: 20),
                                    child: SizedBox(
                                      child: IconButton(
                                          splashColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                          hoverColor: Colors.transparent,
                                          iconSize: 50,
                                          padding: EdgeInsets.all(0),
                                          onPressed: _incrementCounterTrophy,
                                          tooltip: 'Earn a trophy',
                                          icon: const Icon(
                                            FontAwesomeIcons.trophy,
                                            //size: 38,
                                            color:
                                            Color.fromRGBO(218, 165, 32, 1.0),
                                          )),
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('$_countertrophy',
                                          style: const TextStyle(
                                              fontSize: 30,
                                              color: Colors.blue,
                                              fontWeight: FontWeight.bold)),
                                      const SizedBox(height: 25),
                                      const Text('Trofea',
                                          style: TextStyle(
                                              color: Colors.blue,
                                              fontWeight: FontWeight.bold)),
                                      const Text('zdobyte',
                                          style: TextStyle(
                                              color: Colors.blue,
                                              fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(right: 20),
                                    child: IconButton(
                                        splashColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        hoverColor: Colors.transparent,
                                        iconSize: 50,
                                        padding: EdgeInsets.all(0),
                                        onPressed: _addnewtrophiestoearn,
                                        tooltip: 'Add trophies to earn',
                                        icon: const Icon(FontAwesomeIcons.trophy,
                                            color:
                                            Color.fromRGBO(218, 165, 32, 1.0))),
                                  ),
                                  Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(message1,
                                            style: const TextStyle(
                                                fontSize: 30,
                                                color: Colors.blue,
                                                fontWeight: FontWeight.bold)),
                                        const SizedBox(height: 25),
                                        const Text('Trofea do',
                                            style: TextStyle(
                                                color: Colors.blue,
                                                fontWeight: FontWeight.bold)),
                                        const Text('zdobycia',
                                            style: TextStyle(
                                                color: Colors.blue,
                                                fontWeight: FontWeight.bold)),
                                      ]),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(right: 10),
                                    child: IconButton(
                                        splashColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        hoverColor: Colors.transparent,
                                        iconSize: 50,
                                        padding: EdgeInsets.all(0),
                                        onPressed: () {
                                          _incrementCounterPoints();
                                        },
                                        tooltip: 'Earn a point',
                                        icon: const Icon(FontAwesomeIcons.database,
                                            color:
                                            Color.fromRGBO(218, 165, 32, 1.0))),
                                  ),
                                  Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('$_counterpoints',
                                            style: const TextStyle(
                                                fontSize: 30,
                                                color: Colors.blue,
                                                fontWeight: FontWeight.bold)),
                                        const SizedBox(height: 25),
                                        const Text('Zdobyte',
                                            style: TextStyle(
                                                color: Colors.blue,
                                                fontWeight: FontWeight.bold)),
                                        const Text('punkty',
                                            style: TextStyle(
                                                color: Colors.blue,
                                                fontWeight: FontWeight.bold)),
                                      ]),
                                ],
                              ),
                            ]))
                  ]),
                )),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 15, left: 15, top: 20),
                  child: Container(
                    height: 55,
                    color: Colors.white,
                    child: Column(children: [
                      Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(right: 20, top: 2),
                            child: SizedBox(
                              child: Image(
                                height: 50,
                                image: AssetImage('assets/images/44.png'),
                              ),
                            ),
                          ),
                          SizedBox(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text('Mistrz szkoleń',
                                      style: TextStyle(
                                          color: Colors.blue,
                                          fontWeight: FontWeight.bold)),
                                  Text('-',
                                      style: TextStyle(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold,
                                      ))
                                ],
                              )),
                          const Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(right: 20, top: 3),
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: SizedBox(
                                    child: Icon(FontAwesomeIcons.trophy,
                                        color: Color.fromRGBO(218, 165, 32, 1.0)),
                                  ),
                                ),
                              ))
                        ],
                      ),
                    ]),
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(right: 15, left: 15, top: 20),
                    child: Container(
                      height: 55,
                      color: Colors.white,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(right: 20, top: 3),
                                child: SizedBox(
                                  child: Image(
                                    height: 50,
                                    image: AssetImage('assets/images/32.png'),
                                    color: Color.fromRGBO(91, 91, 91, 1),
                                  ),
                                ),
                              ),
                              SizedBox(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: const [
                                      Text('Trofeum numer 2022',
                                          style: TextStyle(
                                              color: Colors.blue,
                                              fontWeight: FontWeight.bold)),
                                      Text('-',
                                          style: TextStyle(
                                              color: Colors.blue,
                                              fontWeight: FontWeight.bold))
                                    ],
                                  )),
                              const Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.only(right: 20),
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: SizedBox(

                                        //Icon if achievement is unlocked
                                        /*child: Icon(FontAwesomeIcons.trophy,
                                                   color: Color.fromRGBO(
                                                       218, 165, 32, 1.0)),*/

                                      ),
                                    ),
                                  ))
                            ],
                          ),
                        ],
                      ),
                    )),
                Padding(
                  padding: const EdgeInsets.only(right: 15, left: 15, top: 20),
                  child: Container(
                    height: 55,
                    child: Column(children: [
                      Row(
                        children: [
                          Padding(
                              padding: EdgeInsets.only( top: 3),
                              child: Material(
                                type: MaterialType.transparency,
                                child: Ink(
                                  decoration: const BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius: BorderRadius.all(Radius.circular(10))),
                                  child: InkWell(
                                    onTap: () {},
                                    child: const Padding(
                                      padding: EdgeInsets.all(10.0),
                                      child: Icon(
                                        FontAwesomeIcons.arrowLeft,
                                        size: 20.0,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                          ),
                          //SizedBox(
                          //  ),
                          Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(left: 10, top: 3),
                                child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Material(
                                      type: MaterialType.transparency,
                                      child: Ink(
                                        decoration: const BoxDecoration(
                                            color: Colors.grey,
                                            borderRadius: BorderRadius.all(Radius.circular(10))),
                                        child: InkWell(
                                          onTap: () {},
                                          child: const Padding(
                                            padding: EdgeInsets.all(10.0),
                                            child: Icon(
                                              FontAwesomeIcons.arrowRight,
                                              size: 20.0,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                ),
                              )),
                        ],
                      ),
                    ]),
                  ),
                ),
              ],
            ),
          ],
        ));
  }
}