class Category {

  String id;

  int? key;

  String name;

  Category({
    required this.id,
    this.name = "",
    this.key
  });

  factory Category.fromMapDb(Map<String, dynamic> data, int key){
    return Category(
      name: data["name"],
      id: data["id"],
      key: key
    );
  }

  Map<String, dynamic> toMap(){

    return {
      "id": id,
      "name": name
    };
  }

}