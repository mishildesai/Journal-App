import 'package:flutter/material.dart';
import 'package:journal_app/main.dart';
import 'package:journal_app/models/category.dart';
import 'package:journal_app/screens/settings_screen.dart';

import '../models/journal.dart';
import 'add_journal_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  final List<Category> _categories = [];
  final List<Journal> _journals = [];
  List<Widget> journalTiles = [];

  @override
  void initState() {
    for (int count = 0; count < 5; count++) {
      _journals.add(Journal(count, 1, "Journal $count",
          "Hello, this is some text for Journal $count."));
    }

    _categories.add(Category(1, "Fitness", Colors.red, _journals));
    _categories.add(Category(2, "Friends", Colors.blue, _journals));
    _categories.add(Category(3, "Family", Colors.green, _journals));

    journalTiles = _buildJournalsList(_journals);

    super.initState();
  }

  List<Widget> _buildJournalsList(List<Journal> journals) {
    return journals
        .map((journal) => ListTile(
              title: Text(journal.title),
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Container(
                height: 50,
                child: TextField(
                    decoration: InputDecoration(
                        hintText: 'Search',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        filled: true,
                        fillColor: Colors.white,
                        prefixIcon: Icon(
                            Icons.search)))), //const Text(JournalApp.appName),
            actions: ([
              IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AddJournalScreen()));
                },
                icon: Icon(Icons.add_box_outlined, color: Colors.white),
              ),
              IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SettingsScreen()));
                  },
                  icon: Icon(Icons.settings, color: Colors.white)),
              //TextField(
              //decoration: InputDecoration(
              //hintText: 'Search', prefixIcon: Icon(Icons.search)))
            ])),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                  clipBehavior: Clip.hardEdge,
                  padding: const EdgeInsets.all(8),
                  itemCount: _categories.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ExpansionTile(
                        title: Text(_categories[index].name),
                        children: journalTiles);
                  }),
            )
          ],
        ));
  }
}
