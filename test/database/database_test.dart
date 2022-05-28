import 'dart:math';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:journal_app/database/database.dart';
import 'package:test/test.dart';

void main() {
  late Database database;

  setUp(() {
    database = Database.withExecutor(NativeDatabase.memory());
  });

  tearDown(() async {
    await database.close();
  });

  test('Journals can be added', () async {
    List<int> addedJournalIds = [];

    for (int count = 0; count < 10; count++) {
      final String title = "Journal $count";
      final String content = "Hello, this some content for Journal $count. Here is some more text!";

      // Create a Journal object to insert
      final JournalsCompanion journal = JournalsCompanion.insert(title: title, content: content);

      // Insert Journal and store the returned id of the Journal
      final int rowId = await database.addJournal(journal);
      expect(addedJournalIds.contains(rowId), false, reason: "Journal rowId is not unique.");

      // Fetch the recently added Journal
      final Journal retrievedJournal = await database.journalById(rowId);
      expect(retrievedJournal.title == title, true,
          reason:
              "Title for Journal $count not matching. Expected: $title Actual: ${retrievedJournal.title}");
      expect(retrievedJournal.content == content, true,
          reason:
              "Content for Journal $count not matching. Expected: $content Actual: ${retrievedJournal.content}");

      addedJournalIds.add(rowId);
    }
  });

  test('Journals can be updated', () async {
    final randomInt = Random().nextInt(10000000);

    final String title = "Journal $randomInt";
    final String updatedTitle = "Updated Journal $randomInt";
    final String content =
        "Hello, this some content for Journal $randomInt. Here is some more text!";
    final String updatedContent =
        "Hello, this some updated content for updated Journal $randomInt. Here is some more updated text!";

    // Create a Journal object to insert
    final JournalsCompanion journal = JournalsCompanion.insert(title: title, content: content);
    // Insert Journal and store the returned id of the Journal
    final int rowId = await database.addJournal(journal);

    // Create new Journal object with the same id as the recently added Journal
    final JournalsCompanion updatedJournal = JournalsCompanion.insert(
        journalId: Value(rowId), title: updatedTitle, content: updatedContent);
    final bool successful = await database.updateJournal(updatedJournal);

    // Fetch the updated Journal
    final Journal retrievedJournal = await database.journalById(rowId);

    expect(successful, true, reason: "Update was unsuccessful");
    expect(retrievedJournal.title, updatedTitle, reason: "Updated title does not match expected");
    expect(retrievedJournal.content, updatedContent,
        reason: "Updated content does not match expected");
  });

  test('Categories can be added', () async {
    List<int> addedCategoryIds = [];

    for (int count = 0; count < 10; count++) {
      final String name = "Category $count";

      final CategoriesCompanion category = CategoriesCompanion.insert(name: name);

      final int rowId = await database.addCategory(category);
      expect(addedCategoryIds.contains(rowId), false, reason: "Category rowId is not unique.");

      final Category retrievedCategory = await database.categoryById(rowId);
      expect(retrievedCategory.name == name, true,
          reason:
              "Name for Category $count not matching. Expected: $name Actual: ${retrievedCategory.name}");

      addedCategoryIds.add(rowId);
    }

    expect(true, true);
  });

  test('Categories can be updated', () async {
    final randomInt = Random().nextInt(10000000);

    final String name = "Category $randomInt";
    final String updatedName = "Updated Category $randomInt";

    // Create a Category object to insert
    final CategoriesCompanion category = CategoriesCompanion.insert(name: name);
    // Insert Category and store the returned id of the Category
    final int rowId = await database.addCategory(category);

    // Create new Category object with the same id as the recently added Category
    final CategoriesCompanion updatedCategory =
        CategoriesCompanion.insert(categoryId: Value(rowId), name: updatedName);
    final bool successful = await database.updateCategory(updatedCategory);

    // Fetch the updated Journal
    final Category retrievedCategory = await database.categoryById(rowId);

    expect(successful, true, reason: "Update was unsuccessful");
    expect(retrievedCategory.name, updatedName, reason: "Updated name does not match expected");
  });
}
