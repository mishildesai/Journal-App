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

      final JournalsCompanion journal = JournalsCompanion.insert(title: title, content: content);

      final int rowId = await database.addJournal(journal);
      expect(addedJournalIds.contains(rowId), false, reason: "Journal rowId is not unique.");

      final Journal retrievedJournal = await database.journalById(rowId).first;
      expect(retrievedJournal.title == title, true,
          reason:
              "Title for Journal $count not matching. Expected: $title Actual: ${retrievedJournal.title}");
      expect(retrievedJournal.content == content, true,
          reason:
              "Content for Journal $count not matching. Expected: $content Actual: ${retrievedJournal.content}");

      addedJournalIds.add(rowId);
    }
  });

  test('Categories can be added', () async {
    List<int> addedCategoryIds = [];

    for (int count = 0; count < 10; count++) {
      final String name = "Category $count";

      final CategoriesCompanion category = CategoriesCompanion.insert(name: name);

      final int rowId = await database.addCategory(category);
      expect(addedCategoryIds.contains(rowId), false, reason: "Category rowId is not unique.");

      final Category retrievedCategory = await database.categoryById(rowId).first;
      expect(retrievedCategory.name == name, true,
          reason:
              "Name for Category $count not matching. Expected: $name Actual: ${retrievedCategory.name}");

      addedCategoryIds.add(rowId);
    }

    expect(true, true);
  });
}
