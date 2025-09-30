import 'package:drift/drift.dart';

import '../pos_database.dart';
import '../tables.dart';

part 'categories_dao.g.dart';

@DriftAccessor(tables: [CategoriesTable])
class CategoriesDao extends DatabaseAccessor<PosDatabase>
    with _$CategoriesDaoMixin {
  CategoriesDao(PosDatabase db) : super(db);

  Future<int> create(String name) {
    return into(
      categoriesTable,
    ).insert(CategoriesTableCompanion.insert(name: name));
  }

  Future<void> updateCategory(int id, String name) {
    return (update(categoriesTable)..where((tbl) => tbl.id.equals(id))).write(
      CategoriesTableCompanion(
        name: Value(name),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  Future<void> deleteCategory(int id) {
    return (delete(categoriesTable)..where((tbl) => tbl.id.equals(id))).go();
  }

  Stream<List<CategoriesTableData>> watchAll() {
    return (select(
      categoriesTable,
    )..orderBy([(tbl) => OrderingTerm(expression: tbl.name)])).watch();
  }

  Future<List<CategoriesTableData>> getAll() {
    return (select(
      categoriesTable,
    )..orderBy([(tbl) => OrderingTerm(expression: tbl.name)])).get();
  }
}
