import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../utils/utils_timeAgo.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import '../constants.dart';

//notifications
String _formatHtmlString(String string) {
  return string
      .replaceAll("&quot;", "\"")
      .replaceAll("&apos;", "'")
      .replaceAll("&lt;", ">")
      .replaceAll("&gt;", "<")
      .trim();
}

class _MySearchDelegate extends SearchDelegate<List<Datum>> {
  final List<Datum> notes;
  List<Datum> suggestions = [];

  _MySearchDelegate(this.notes);

  @override
  Widget? buildLeading(BuildContext context) => IconButton(
        onPressed: () => close(context, notes),
        icon: const FaIcon(FontAwesomeIcons.arrowLeft),
      );

  @override
  List<Widget>? buildActions(BuildContext context) => [
        IconButton(
            onPressed: () {
              if (query.isEmpty) {
                close(context, notes);
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
    suggestions = notes.where((note) {
      final noteTitle = note.messageTitle.text.toLowerCase();
      final input = query.toLowerCase();
      return noteTitle.contains(input);
    }).toList();

    return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
      return ListView.builder(
          padding: const EdgeInsets.all(10.0),
          itemCount: suggestions.length,
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemBuilder: (context, i) {
            final note = suggestions[i];
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
                          "     ${_formatHtmlString(note.messageTitle.text)}",
                          overflow: TextOverflow.ellipsis,
                          style: TextStyles.h1,
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
                              style: TextStyles.h2,
                            ),
                            TextSpan(
                              text: note.userLogin,
                              style: TextStyles.h3,
                            ),
                          ],
                        ),
                      ),
                      Text.rich(
                        TextSpan(
                          children: <TextSpan>[
                            const TextSpan(
                              text: 'Username: ',
                              style: TextStyles.h2,
                            ),
                            TextSpan(
                              text: note.userName,
                              style: TextStyles.h3,
                            ),
                          ],
                        ),
                      ),
                      Text.rich(
                        TextSpan(
                          children: <TextSpan>[
                            const TextSpan(
                              text: 'Surname: ',
                              style: TextStyles.h2,
                            ),
                            TextSpan(
                              text: note.userSurname,
                              style: TextStyles.h3,
                            ),
                          ],
                        ),
                      ),
                      Text.rich(
                        TextSpan(
                          children: <TextSpan>[
                            const TextSpan(
                              text: 'IsRead: ',
                              style: TextStyles.h2,
                            ),
                            TextSpan(
                              text: note.isRead.text,
                              style: TextStyles.h3,
                            ),
                          ],
                        ),
                      ),
                      Text.rich(
                        TextSpan(
                          children: <TextSpan>[
                            const TextSpan(
                              text: 'Send: ',
                              style: TextStyles.h2,
                            ),
                            TextSpan(
                              text: timeAgo(note.sendtimestamp.value),
                              style: TextStyles.h3,
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
                            icon: const FaIcon(FontAwesomeIcons.envelopeOpen),
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
                              icon: const FaIcon(FontAwesomeIcons.trashCan),
                              onPressed: () {
                                setState(() {
                                  notes.remove(note);
                                  suggestions.remove(note);
                                });
                              }),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          });
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
    return Scaffold(
      appBar: AppBar(
        title: const Text(title),
        actions: <Widget>[
          IconButton(
            icon: const FaIcon(FontAwesomeIcons.magnifyingGlass),
            tooltip: 'Search',
            iconSize: 20,
            onPressed: () async {
              await showSearch(
                context: context,
                delegate: _MySearchDelegate(notes),
              );
              setState(() {});
            },
          ),
          const SizedBox(
            width: 30,
          ),
        ],
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
                              "     ${_formatHtmlString(note.messageTitle.text)}",
                              overflow: TextOverflow.ellipsis,
                              style: TextStyles.h1,
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
                                  style: TextStyles.h2,
                                ),
                                TextSpan(
                                  text: note.userLogin,
                                  style: TextStyles.h3,
                                ),
                              ],
                            ),
                          ),
                          Text.rich(
                            TextSpan(
                              children: <TextSpan>[
                                const TextSpan(
                                  text: 'Username: ',
                                  style: TextStyles.h2,
                                ),
                                TextSpan(
                                  text: note.userName,
                                  style: TextStyles.h3,
                                ),
                              ],
                            ),
                          ),
                          Text.rich(
                            TextSpan(
                              children: <TextSpan>[
                                const TextSpan(
                                  text: 'Surname: ',
                                  style: TextStyles.h2,
                                ),
                                TextSpan(
                                  text: note.userSurname,
                                  style: TextStyles.h3,
                                ),
                              ],
                            ),
                          ),
                          Text.rich(
                            TextSpan(
                              children: <TextSpan>[
                                const TextSpan(
                                  text: 'IsRead: ',
                                  style: TextStyles.h2,
                                ),
                                TextSpan(
                                  text: note.isRead.text,
                                  style: TextStyles.h3,
                                ),
                              ],
                            ),
                          ),
                          Text.rich(
                            TextSpan(
                              children: <TextSpan>[
                                const TextSpan(
                                  text: 'Send: ',
                                  style: TextStyles.h2,
                                ),
                                TextSpan(
                                  text: timeAgo(note.sendtimestamp.value),
                                  style: TextStyles.h3,
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
                                icon:
                                    const FaIcon(FontAwesomeIcons.envelopeOpen),
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
                                  icon: const FaIcon(FontAwesomeIcons.trashCan),
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
    );
  }
}

class Notifications extends StatefulWidget {
  const Notifications({super.key});

  @override
  State<Notifications> createState() => _NotificationsState();
}


class NotificationData {
  NotificationData({
    required this.items,
  });

  Items items;

  factory NotificationData.fromJson(Map<String, dynamic> json) => NotificationData(
    items: Items.fromJson(json["items"]),
  );

  Map<String, dynamic> toJson() => {
    "items": items.toJson(),
  };
}
class Items {
  Items({
    required this.columns,
    required this.data,
    required this.info,
  });

  Columns columns;
  List<Datum> data;
  Info info;

  factory Items.fromJson(Map<String, dynamic> json) => Items(
    columns: Columns.fromJson(json["columns"]),
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    info: Info.fromJson(json["info"]),
  );

  Map<String, dynamic> toJson() => {
    "columns": columns.toJson(),
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "info": info.toJson(),
  };
}
class Columns {
  Columns({
    required this.messageTitle,
    required this.userLogin,
    required this.userName,
    required this.userSurname,
    required this.readtimestamp,
    required this.sendtimestamp,
    required this.isRead,
  });

  IsRead messageTitle;
  IsRead userLogin;
  IsRead userName;
  IsRead userSurname;
  IsRead readtimestamp;
  IsRead sendtimestamp;
  IsRead isRead;

  factory Columns.fromJson(Map<String, dynamic> json) => Columns(
    messageTitle: IsRead.fromJson(json["Message.Title"]),
    userLogin: IsRead.fromJson(json["User.Login"]),
    userName: IsRead.fromJson(json["User.Name"]),
    userSurname: IsRead.fromJson(json["User.Surname"]),
    readtimestamp: IsRead.fromJson(json["readtimestamp"]),
    sendtimestamp: IsRead.fromJson(json["sendtimestamp"]),
    isRead: IsRead.fromJson(json["IsRead"]),
  );

  Map<String, dynamic> toJson() => {
    "Message.Title": messageTitle.toJson(),
    "User.Login": userLogin.toJson(),
    "User.Name": userName.toJson(),
    "User.Surname": userSurname.toJson(),
    "readtimestamp": readtimestamp.toJson(),
    "sendtimestamp": sendtimestamp.toJson(),
    "IsRead": isRead.toJson(),
  };
}
class IsRead {
  IsRead({
    required this.name,
    required this.type,
    required this.parsers,
    required this.sortable,
    required this.show,
    required this.index,
  });

  String name;
  String type;
  List<String> parsers;
  bool sortable;
  bool show;
  int index;

  factory IsRead.fromJson(Map<String, dynamic> json) => IsRead(
    name: json["name"],
    type: json["type"],
    parsers: List<String>.from(json["parsers"].map((x) => x)),
    sortable: json["sortable"],
    show: json["show"],
    index: json["index"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "type": type,
    "parsers": List<dynamic>.from(parsers.map((x) => x)),
    "sortable": sortable,
    "show": show,
    "index": index,
  };
}
class Datum {
  Datum({
    required this.messageTitle,
    required this.userLogin,
    required this.userName,
    required this.userSurname,
    required this.readtimestamp,
    required this.sendtimestamp,
    required this.isRead,
  });

  MessageTitle messageTitle;
  String userLogin;
  String userName;
  String userSurname;
  Dtimestamp readtimestamp;
  Dtimestamp sendtimestamp;
  DatumIsRead isRead;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    messageTitle: MessageTitle.fromJson(json["Message.Title"]),
    userLogin: json["User.Login"],
    userName: json["User.Name"],
    userSurname: json["User.Surname"],
    readtimestamp: Dtimestamp.fromJson(json["readtimestamp"]),
    sendtimestamp: Dtimestamp.fromJson(json["sendtimestamp"]),
    isRead: DatumIsRead.fromJson(json["IsRead"]),
  );

  Map<String, dynamic> toJson() => {
    "Message.Title": messageTitle.toJson(),
    "User.Login": userLogin,
    "User.Name": userName,
    "User.Surname": userSurname,
    "readtimestamp": readtimestamp.toJson(),
    "sendtimestamp": sendtimestamp.toJson(),
    "IsRead": isRead.toJson(),
  };
}
class DatumIsRead {
  DatumIsRead({
    required this.text,
    required this.value,
  });

  String text;
  int value;

  factory DatumIsRead.fromJson(Map<String, dynamic> json) => DatumIsRead(
    text: json["text"],
    value: json["value"],
  );

  Map<String, dynamic> toJson() => {
    "text": text,
    "value": value,
  };
}
class MessageTitle {
  MessageTitle({
    required this.text,
    required this.href,
  });

  String text;
  String href;

  factory MessageTitle.fromJson(Map<String, dynamic> json) => MessageTitle(
    text: json["text"],
    href: json["href"],
  );

  Map<String, dynamic> toJson() => {
    "text": text,
    "href": href,
  };
}
class Dtimestamp {
  Dtimestamp({
    required this.value,
    required this.showDifference,
    required this.showOriginDate,
    required this.showOnlyDate,
    required this.emptyText,
  });

  String value;
  bool showDifference;
  bool showOriginDate;
  bool showOnlyDate;
  String emptyText;

  factory Dtimestamp.fromJson(Map<String, dynamic> json) => Dtimestamp(
    value: json["value"],
    showDifference: json["show_difference"],
    showOriginDate: json["show_origin_date"],
    showOnlyDate: json["show_only_date"],
    emptyText: json["empty_text"],
  );

  Map<String, dynamic> toJson() => {
    "value": value,
    "show_difference": showDifference,
    "show_origin_date": showOriginDate,
    "show_only_date": showOnlyDate,
    "empty_text": emptyText,
  };
}
class Info {
  Info({
    required this.countAll,
    required this.countFiltered,
  });

  int countAll;
  int countFiltered;

  factory Info.fromJson(Map<String, dynamic> json) => Info(
    countAll: json["count_all"],
    countFiltered: json["count_filtered"],
  );

  Map<String, dynamic> toJson() => {
    "count_all": countAll,
    "count_filtered": countFiltered,
  };
}
