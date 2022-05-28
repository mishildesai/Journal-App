import 'package:drift/drift.dart';

import 'connection/connection.dart' as impl;
import 'tables.dart';

part 'database.g.dart';

@DriftDatabase(tables: [Journals, Categories])
class Database extends _$Database {
  /// Instantiate a new [Database] if the platform is supported.
  /// See [connection.dart] for supported platforms.
  Database() : super(impl.connect().executor);

  /// Instantiate a new [Database] using a custom [QueryExecutor].
  /// This is very useful for testing because in-memory databases can be created.
  Database.withExecutor(QueryExecutor e) : super(e);

  /// Useful for migrations. If the database schema is updated, then this value
  /// must also be increased.
  @override
  int get schemaVersion => 1;

  /// Get all the [Journal]s from this database.
  Future<List<Journal>> get allJournals => select(journals).get();

  /// Get all the [Journals]s that belong to a [Category] with [categoryId]
  Future<List<Journal>> allJournalsWithCategory(int categoryId) {
    return (select(journals)..where((journal) => journal.categoryId.equals(categoryId))).get();
  }

  /// Update the specified [JournalsCompanion] in the database.
  /// Returns true if the update was successful, false if not.
  Future<bool> updateJournal(JournalsCompanion journal) {
    return update(journals).replace(journal);
  }

  /// Insert the specified [JournalsCompanion] into the database.
  /// Returns the [journalId] of the inserted row if insertion was successful.
  /// Returns -1 if the insertion was unsuccessful.
  Future<int> addJournal(JournalsCompanion journal) {
    return into(journals).insert(journal);
  }

  /// Get the [Journal] with [journalId]. Since this is the primary key, only one
  /// journal will be returned.
  Future<Journal> journalById(int journalId) {
    return (select(journals)..where((journal) => journal.journalId.equals(journalId)))
        .watchSingle()
        .first;
  }

  /// Get all the [Category] rows in this database.
  Future<List<Category>> get allCategories => select(categories).get();

  /// Update the specified [CategoriesCompanion] in the database.
  /// Returns true if the update was successful, false if not.
  Future<bool> updateCategory(CategoriesCompanion category) {
    return update(categories).replace(category);
  }

  /// Insert the specified [CategoriesCompanion] into the database.
  /// Returns the [categoryId] of the inserted row if insertion was successful.
  /// Returns -1 if the insertion was unsuccessful.
  Future<int> addCategory(CategoriesCompanion category) {
    return into(categories).insert(category);
  }

  /// Get the [Category] with [categoryId]. Since this is the primary key, only one
  /// category will be returned.
  Future<Category> categoryById(int categoryId) {
    return (select(categories)..where((category) => category.categoryId.equals(categoryId)))
        .watchSingle()
        .first;
  }
}
