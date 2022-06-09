import 'package:flutter/material.dart';

class AddJournalScreen extends StatefulWidget {
  const AddJournalScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => AddJournalScreenState();
}

class AddJournalScreenState extends State<AddJournalScreen> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(appBar: AppBar(title: Text('Add journal page')));
  }
}
