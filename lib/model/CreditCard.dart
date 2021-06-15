class CreditCard {

  String id;

  int? key;

  String description;

  double creditLimit;

  String company;

  CreditCard({
    required this.id,
    required this.creditLimit,
    required this.description,
    this.key,
    this.company = ''
  });

  factory CreditCard.fromMapDb(Map<String, dynamic> data, int key){
    return CreditCard(
        creditLimit: data['creditLimit'],
        description: data["description"],
        id: data["id"],
        key: key,
        company: data['company']
    );
  }

  Map<String, dynamic> toMap(){

    return {
      "creditLimit": creditLimit,
      "id": id,
      "description": description,
      "company": company
    };
  }

}