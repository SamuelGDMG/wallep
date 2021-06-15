import 'package:jiffy/jiffy.dart';

class MonthSalary {

  int? key;

  int dateMilli;

  double salary;

  MonthSalary({this.dateMilli = 0, required this.salary, this.key});

  factory MonthSalary.fromDb(Map<String, dynamic> data, int key){

    return MonthSalary(dateMilli: data["dateMilli"], salary: data["salary"], key: key);
  }

  void setDate(int date) {
    dateMilli = Jiffy(Jiffy.unix(date).yMMM, 'yMMM').dateTime.millisecondsSinceEpoch;
  }

  static int getDateByMonthAndYear({required int date, int day = 2}){
    final currentDate = DateTime.fromMillisecondsSinceEpoch(date);

    return DateTime.utc(currentDate.year, currentDate.month, day - 1, 3).millisecondsSinceEpoch;
  }

  Map<String, dynamic> toMap(){

    return {
      "dateMilli": dateMilli,
      "salary": salary
    };
  }

}