import 'package:flutter/material.dart';
import 'package:journal_app/models/journal.dart';

class Category {
  final int id;
  final String name;
  final Color color;
  final List<Journal> journals;

  Category(this.id, this.name, this.color, this.journals);
}
