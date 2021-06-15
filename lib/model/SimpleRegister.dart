import 'package:finance/utils/Constants.dart';

class SimpleRegister {

  int? key;

  String id;

  Map<String, dynamic> check;

  String name;

  double price;

  int installments;

  int createdAt;

  int lastInstallment;

  String? idCategory;

  String isIncome;

  int firstInstallment;

  SimpleRegister({
    required this.id,
    this.name = "",
    this.price = 0.0,
    this.installments = 1,
    this.createdAt = 0,
    this.lastInstallment = 0,
    this.idCategory = "",
    this.key,
    required this.isIncome,
    required this.firstInstallment,
    this.check = const {}
  });

  factory SimpleRegister.fromMapDb(Map<String, dynamic> data, int key){

    Map<String, dynamic> dataCheck = data['check'];

    return SimpleRegister(
      key: key,
      id: data["id"],
      name: data["name"],
      price: data["price"],
      installments: data["installments"],
      createdAt: data["createdAt"],
      lastInstallment: data["lastInstallment"],
      idCategory: data["idCategory"],
      isIncome: data["isIncome"] ?? Constants.INCOME,
      firstInstallment: data["firstInstallment"],
        check: dataCheck
    );
  }

  Map<String, dynamic> toMap(){
    return {
      "id": id,
      "name": name,
      "price": price,
      "installments": installments,
      "createdAt": createdAt,
      "lastInstallment": lastInstallment,
      "idCategory": idCategory,
      "isIncome": isIncome,
      "firstInstallment": firstInstallment,
      'check': check
    };
  }

  double get installment => price / double.parse(installments.toString());

  bool getCheckByMonth(key){
    return check[key] != null ? check[key] : false;
  }

}