import 'package:finance/utils/Constants.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:core';

class HelpFunctions {

  static String replaceMaskPrice(price){
    return price.replaceAll(RegExp('[^0-9]'), "");
  }

  static double getPriceWithoutMask(price){
    final replace = replaceMaskPrice(price);
    return replace != '' ? double.parse(replace) / 100 : 0.0;
  }

  static String formatCurrency({value, name = ''}){

    var numberValue = value is String ? double.parse(value) : value;

    final currency = new NumberFormat.simpleCurrency(name: name);

    return currency.format(numberValue);
  }

  static String formatDataWithYear({date, lang}){
    var dateJif;
    if(date is int){
      dateJif = Jiffy.unix(date);
    }else{
      dateJif = Jiffy(date, 'yMMM');
    }
    var month = lang == 'pt' ? Constants.MONTH_PT[dateJif.month] : Constants.MONTH_EN[dateJif.month];
    return "$month - ${dateJif.year}";
  }

  static final Uri _emailLaunchUri = Uri(
      scheme: 'mailto',
      path: Constants.EMAIL,
      queryParameters: {
        'subject': '[Wallep]-'
      }
  );


  static void launchUrl() async {
    launch(_emailLaunchUri.toString());
  }

}