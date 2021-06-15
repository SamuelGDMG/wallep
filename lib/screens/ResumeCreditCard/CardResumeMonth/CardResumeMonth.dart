import 'package:expandable/expandable.dart';
import 'package:finance/model/SimpleRegister.dart';
import 'package:finance/utils/Constants.dart';
import 'package:finance/utils/HelpFunctions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CardResumeMonth extends StatelessWidget {

  final data;

  final resumeCreditCardLabelRegisterInstallment = 'resumeCreditCardLabelRegisterInstallment'.tr;

  CardResumeMonth({this.data});

  @override
  Widget build(BuildContext context) {
    return ExpandablePanel(
      header: Container(
        height: 40,
        child: Padding(
          padding: EdgeInsets.only(left: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(HelpFunctions.formatDataWithYear(date: data["key"], lang: Get.locale!.languageCode))
            ],
          ),
        ),
      ),
      expanded: Container(),
      collapsed: ListView.builder(
          physics: NeverScrollableScrollPhysics(),
        itemCount: data["registers"].length,
          shrinkWrap: true,
          itemBuilder: (_, index){

        SimpleRegister register = data["registers"][index];
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('${register.name}', textAlign: TextAlign.start, style: TextStyle(
                            fontSize: 16,
                          )),
                        ],
                      ),
                      Row(
                        children: [
                          Text(resumeCreditCardLabelRegisterInstallment),
                          Text(HelpFunctions.formatDataWithYear(date: register.firstInstallment, lang: Get.locale!.languageCode))
                        ],
                      ),
                      Row(
                        children: [
                          Text('${register.installments}'),
                          Text(' x '),
                          Text('${HelpFunctions.formatCurrency(value: register.installment, name: 'currency'.tr)}',),
                          Text(' = '),
                          Text('${HelpFunctions.formatCurrency(value: register.price, name: 'currency'.tr)}',
                            style: TextStyle(
                                color: Constants.COLOR_EXPENSE
                            ),
                          ),
                        ],
                      )
                    ],
                  )
                ],
              ),
              Divider()
            ],
          ),
        );
      }),
    );
  }
}
