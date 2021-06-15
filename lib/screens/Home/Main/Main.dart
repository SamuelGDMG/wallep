import 'package:finance/screens/FormCreditCard/FormCreditCard.dart';
import 'package:finance/screens/FormSimpleRegister/FormSimpleRegister.dart';
import 'package:finance/screens/Home/AccountSummary/AccountSummary.dart';
import 'package:finance/screens/Home/CardSimpleRegister/CardSimpleRegister.dart';
import 'package:finance/screens/Home/ScrollHorizontalCards/ScrollContainers.dart';
import 'package:finance/screens/Home/SummaryChart/SummaryChart.dart';
import '../CardCreditCard/CardCreditCard.dart';
import 'package:finance/screens/Home/widgets/OnTapCard.dart';
import 'package:finance/state/StateSystem.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Main extends StatelessWidget {

  final String titleDialogSettings = 'titleDialogSettings'.tr;
  final String titleHomeSummaryChart = 'titleHomeSummaryChart'.tr;
  final String titleHomeCreditCards = 'titleHomeCreditCards'.tr;
  final String titleHomeIncomesAndExpenses = 'titleHomeIncomesAndExpenses'.tr;
  final String messageNoCreditCardHome = 'messageNoCreditCardHome'.tr;
  final String messageNoSimpleRegisterHome = 'messageNoSimpleRegisterHome'.tr;

  final StateSystem _stateSystem = Get.find();

  Widget showMyRegisters(){
    return Container(
      child: Obx(() => Row(
        children: [
          OnTapCard(onTap: () async {
            Get.to(() => FormSimpleRegister());
          }),
          Visibility(
              visible: _stateSystem.arrayDataSimpleRegister.length < 1,
              child: Container(
                width: Get.width * 0.75,
                child: Text(messageNoSimpleRegisterHome),
              )
          ),
          ..._stateSystem.arrayDataSimpleRegister.map((element) => CardSimpleRegister(register: element)).toList()
        ],
      )),
    );
  }

  Widget showMyCreditCards(){

    return Container(
      child: Obx(() => Row(
        children: [
          OnTapCard(onTap: () async {
            Get.to(() => FormCreditCard());
          }),
          Visibility(
              visible: _stateSystem.arrayCreditCards.length < 1,
              child: Container(
                width: Get.width * 0.75,
                child: Text(messageNoCreditCardHome),
              )
          ),
          ..._stateSystem.arrayCreditCards.map((element) => CardCreditCard(creditCard: element)).toList()
        ],
      )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        AccountSummary(),
        SummaryChart(labelChart: titleHomeSummaryChart,),
        ScrollHorizontalCards(widget: showMyCreditCards(), labelCarousel: titleHomeCreditCards),
        ScrollHorizontalCards(widget: showMyRegisters(), labelCarousel: titleHomeIncomesAndExpenses,),
        SizedBox(
          height: 10,
        )
      ],
    );
  }
}
