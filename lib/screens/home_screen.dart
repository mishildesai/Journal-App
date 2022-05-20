import 'package:flutter/material.dart';
import 'package:journal_app/main.dart';
import 'package:journal_app/models/category.dart';

import '../models/journal.dart';

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
      _journals
          .add(Journal(count, 1, "Journal $count", "Hello, this is some text for Journal $count."));
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
        appBar: AppBar(title: const Text(JournalApp.appName)),
        body: Column(
          children: [
            ListView.builder(
                shrinkWrap: true,
                padding: const EdgeInsets.all(8),
                itemCount: _categories.length,
                itemBuilder: (BuildContext context, int index) {
                  return ExpansionTile(
                      title: Text(_categories[index].name), children: journalTiles);
                }),
          ],
        ));
  }
}
