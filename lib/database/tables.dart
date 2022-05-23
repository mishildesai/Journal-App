import 'dart:ui';

import 'package:drift/drift.dart';

@DataClassName('Journal')
class Journals extends Table {
  IntColumn get journalId => integer().autoIncrement()();
  TextColumn get title => text().withLength(min: 1, max: 32)();
  TextColumn get content => text().withLength(min: 0, max: 1000)();
  IntColumn get categoryId => integer().references(Categories, #categoryId).nullable()();
}

@DataClassName('Category')
class Categories extends Table {
  IntColumn get categoryId => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 32)();
}

class ColorConverter extends NullAwareTypeConverter<Color, int> {
  const ColorConverter();

  /// Converts [int] [value] to [Color] value
  @override
  requireMapToDart(int fromDb) => Color(fromDb);

  /// Converts [Color] [value] to [int] value
  @override
  int requireMapToSql(Color value) => value.value;
}
