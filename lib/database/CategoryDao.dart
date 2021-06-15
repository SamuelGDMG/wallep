import 'package:finance/database/AppDatabase.dart';
import 'package:finance/model/Category.dart';
import 'package:sembast/sembast.dart';

class CategoryDao {

  static const String CATEGORY_STORE_NAME = 'category';

  final _categoryStore = intMapStoreFactory.store(CATEGORY_STORE_NAME);

  Future<Database> get _db async => await AppDatabase.instance.database;

  Future insert(Category category) async {
    await _categoryStore.add(await _db, category.toMap());
  }

  Future clearWholeStore() async {
    await _categoryStore.delete(await _db);
  }

  Future update(Category category) async{

  }

  Future<List<Category>> getAllSortedByName() async {
    final finder = Finder(sortOrders: [
      SortOrder("createdAt")
    ]);

    final recordSnapshot = await _categoryStore.find(await _db, finder: finder);

    return recordSnapshot.map((e) {

      return Category.fromMapDb(e.value, e.key);
    }).toList();
  }


}