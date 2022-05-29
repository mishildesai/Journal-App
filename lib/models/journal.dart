@Deprecated("Use [Journal] or [JournalsCompanion] from [Database] instead")
class Journal {
  final int id;
  final int categoryId;
  final String title;
  final String content;

  Journal(this.id, this.categoryId, this.title, this.content);
}
