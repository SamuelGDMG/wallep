import 'dart:async';
import 'package:finance/state/StateSystem.dart';
import 'package:finance/utils/Constants.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:path/path.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

class AppDatabase {

  static final AppDatabase _singleton = AppDatabase._();

  static AppDatabase get instance => _singleton;

  Completer<Database>? _dbOpenCompleter;

  AppDatabase._();

  Future<dynamic> get database async {

      if(_dbOpenCompleter == null){

        _dbOpenCompleter = Completer();

        _openDatabase();
      }

      return _dbOpenCompleter?.future;
  }

  Future reloadDataBase() async {
    var dataBase = await AppDatabase.instance.database;
    await dataBase.close();
    _dbOpenCompleter = Completer();

    await _openDatabase();

    StateSystem _stateSystem = Get.find();

    _stateSystem.loadInitialData();
  }

  Future _openDatabase() async {

    final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();

    final dbPath = join(appDocumentDir.path, '${Constants.DIR_DRIVE}.db');

    final database = await databaseFactoryIo.openDatabase(dbPath);

    _dbOpenCompleter?.complete(database);
    await _dbOpenCompleter?.future;

  }

}