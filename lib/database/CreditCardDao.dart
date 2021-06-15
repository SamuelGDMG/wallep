import 'package:finance/database/AppDatabase.dart';
import 'package:finance/model/CreditCard.dart';
import 'package:sembast/sembast.dart';

class CreditCardDao {

  static const String CREDIT_CARD_STORE_NAME = 'creditcard';

  final _creditCardStore = intMapStoreFactory.store(CREDIT_CARD_STORE_NAME);

  Future<Database> get _db async => await AppDatabase.instance.database;

  Future insert(CreditCard creditCard) async {
    await _creditCardStore.add(await _db, creditCard.toMap());
  }

  Future deleteCreditCard(CreditCard creditCard) async {
    final filter = Filter.equals('id', creditCard.id);

    final finder = Finder(filter: filter);

    await _creditCardStore.delete(await _db, finder: finder);
  }

  Future clearWholeStore() async {
    await _creditCardStore.delete(await _db);
  }

  Future update(CreditCard creditCard) async{
    final filter = Filter.byKey(creditCard.key);

    final finder = Finder(filter: filter);

    await _creditCardStore.update(await _db, creditCard.toMap(), finder: finder);
  }

  Future<List<CreditCard>> getAllSortedByName() async {
    final finder = Finder(sortOrders: [
      SortOrder("description")
    ]);

    final recordSnapshot = await _creditCardStore.find(await _db, finder: finder);

    return recordSnapshot.map((e) {

      return CreditCard.fromMapDb(e.value, e.key);
    }).toList();
  }


}