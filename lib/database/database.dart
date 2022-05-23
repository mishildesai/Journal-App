import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

import 'connection/connection.dart' as impl;
import 'tables.dart';

part 'database.g.dart';

@DriftDatabase(tables: [Journals, Categories])
class Database extends _$Database {
  Database() : super(impl.connect().executor);

  Database.withExecutor(QueryExecutor e) : super(e);

  int get schemaVersion => 1;

  Future<List<Journal>> get allJournals => select(journals).get();

  Future<List<Journal>> allJournalsWithCategory(int categoryId) {
    return (select(journals)..where((journal) => journal.categoryId.equals(categoryId))).get();
  }

  Future<void> updateJournal(JournalsCompanion journal) {
    return update(journals).replace(journal);
  }

  Future<int> addJournal(JournalsCompanion journal) {
    return into(journals).insert(journal);
  }

  Stream<Journal> journalById(int journalId) {
    return (select(journals)..where((journal) => journal.journalId.equals(journalId)))
        .watchSingle();
  }

  Future<List<Category>> get allCategories => select(categories).get();

  Future<void> updateCategory(CategoriesCompanion category) {
    return update(categories).replace(category);
  }

  Future<int> addCategory(CategoriesCompanion category) {
    return into(categories).insert(category);
  }

  Stream<Category> categoryById(int categoryId) {
    return (select(categories)..where((category) => category.categoryId.equals(categoryId)))
        .watchSingle();
  }
}
