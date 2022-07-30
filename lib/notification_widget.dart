import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'notification_json.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'notification_constants.dart';
import 'dart:html' as html;

//notifications

String _parseHtmlString(String htmlString) {
  var text = html.Element.span()..appendHtml(htmlString);
  return text.innerText;
}

class _MySearchDelegate extends SearchDelegate<String> {
  final List<Datum> notes;

  _MySearchDelegate(this.notes);

  @override
  Widget? buildLeading(BuildContext context) => IconButton(
        onPressed: () => close(context, 'aaa'),
        icon: const FaIcon(FontAwesomeIcons.arrowLeft),
      );

  @override
  List<Widget>? buildActions(BuildContext context) => [
        IconButton(
            onPressed: () {
              if (query.isEmpty) {
                close(context, 'aaa');
              } else {
                query = '';
              }
            },
            icon: const FaIcon(FontAwesomeIcons.xmark))
      ];

  @override
  Widget buildResults(BuildContext context) => Container();

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = notes.where((note) {
      final noteTitle = note.messageTitle.text.toLowerCase();
      final input = query.toLowerCase();
      return noteTitle.contains(input);
    }).toList();

    return ListView.builder(
        padding: const EdgeInsets.all(10.0),
        itemCount: suggestions.length,
        itemBuilder: (context, i) {
          final note = notes[i];
          return Card(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: ListTile(
                title: Row(
                  children: [
                    const FaIcon(
                      FontAwesomeIcons.bell,
                      size: 30,
                    ),
                    Text('   ${note.messageTitle.text}'),
                  ],
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
                    Text.rich(
                      TextSpan(
                        children: <TextSpan>[
                          const TextSpan(text: 'Login: '),
                          TextSpan(text: note.userLogin),
                        ],
                      ),
                    ),
                    Text.rich(
                      TextSpan(
                        children: <TextSpan>[
                          const TextSpan(text: 'Username: '),
                          TextSpan(text: note.userName),
                        ],
                      ),
                    ),
                    Text.rich(
                      TextSpan(
                        children: <TextSpan>[
                          const TextSpan(text: 'Surname: '),
                          TextSpan(text: note.userSurname),
                        ],
                      ),
                    ),
                    Text.rich(
                      TextSpan(
                        children: <TextSpan>[
                          const TextSpan(text: 'IsRead: '),
                          TextSpan(text: note.isRead.text),
                        ],
                      ),
                    ),
                    Text.rich(
                      TextSpan(
                        children: <TextSpan>[
                          const TextSpan(text: 'Send: '),
                          TextSpan(text: note.sendtimestamp.value),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}

class _NotificationsState extends State<Notifications> {
  List<Datum> notes = [];

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      String s = await rootBundle.loadString(notesJSON);
      var o = NotificationData.fromJson(json.decode(s));
      notes.addAll(o.items.data);
      setState(() {});
    });
    super.initState();
  }

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
                  delegate: _MySearchDelegate(notes),
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
        body: (notes.isEmpty)
            ? const Center(
                child: Text(
                  'You have no new notifications ;)',
                ),
              )
            : ListView.builder(
                padding: const EdgeInsets.all(10.0),
                itemCount: notes.length,
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemBuilder: (context, i) {
                  final note = notes[i];
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                      child: ListTile(
                        title: Row(
                          children: [
                            FaIcon(
                              (note.isRead.value == 0)
                                  ? FontAwesomeIcons.solidBell
                                  : FontAwesomeIcons.bell,
                              size: 30,
                            ),
                            Expanded(
                              child: Text(
                                "     ${note.messageTitle.text}",
                                overflow: TextOverflow.ellipsis,
                                style: h1,
                              ),
                            ),
                          ],
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 15,
                            ),
                            Text.rich(
                              TextSpan(
                                children: <TextSpan>[
                                  const TextSpan(
                                    text: 'Login: ',
                                    style: h2,
                                  ),
                                  TextSpan(
                                    text: note.userLogin,
                                    style: h3,
                                  ),
                                ],
                              ),
                            ),
                            Text.rich(
                              TextSpan(
                                children: <TextSpan>[
                                  const TextSpan(
                                    text: 'Username: ',
                                    style: h2,
                                  ),
                                  TextSpan(
                                    text: note.userName,
                                    style: h3,
                                  ),
                                ],
                              ),
                            ),
                            Text.rich(
                              TextSpan(
                                children: <TextSpan>[
                                  const TextSpan(
                                    text: 'Surname: ',
                                    style: h2,
                                  ),
                                  TextSpan(
                                    text: note.userSurname,
                                    style: h3,
                                  ),
                                ],
                              ),
                            ),
                            Text.rich(
                              TextSpan(
                                children: <TextSpan>[
                                  const TextSpan(
                                    text: 'IsRead: ',
                                    style: h2,
                                  ),
                                  TextSpan(
                                    text: note.isRead.text,
                                    style: h3,
                                  ),
                                ],
                              ),
                            ),
                            Text.rich(
                              TextSpan(
                                children: <TextSpan>[
                                  const TextSpan(
                                    text: 'Send: ',
                                    style: h2,
                                  ),
                                  TextSpan(
                                    text: note.sendtimestamp.value,
                                    style: h3,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        trailing: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const FaIcon(
                                      FontAwesomeIcons.envelopeOpen),
                                  onPressed: () {
                                    setState(() {
                                      note.isRead.text = 'read';
                                      note.isRead.value = 1;
                                    });
                                  },
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                IconButton(
                                    icon:
                                        const FaIcon(FontAwesomeIcons.trashCan),
                                    onPressed: () {
                                      setState(() {
                                        notes.remove(note);
                                      });
                                    }),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
      ),
    );
  }
}

class Notifications extends StatefulWidget {
  const Notifications({super.key});

  @override
  State<Notifications> createState() => _NotificationsState();
}
