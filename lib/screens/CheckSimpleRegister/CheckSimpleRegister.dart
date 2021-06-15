import 'package:finance/model/SimpleRegister.dart';
import 'package:finance/screens/CheckSimpleRegister/Resume/ResumeCheckExpense.dart';
import 'package:finance/state/StateCheckListSimpleRegister.dart';
import 'package:finance/state/StateSystem.dart';
import 'package:finance/utils/Constants.dart';
import 'package:finance/utils/HelpFunctions.dart';
import 'package:finance/utils/HexColor.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';

class CheckSimpleRegister extends StatelessWidget {

  final borderRadius = 16.0;

  final message = 'messageDontHaveAnyCheck'.tr;

  @override
  Widget build(BuildContext context) {

    StateCheckListSimpleRegister _stateCheckListSimpleRegister = Get.put(StateCheckListSimpleRegister());

    _stateCheckListSimpleRegister.loadingData();

    StateSystem _stateSystem = Get.find();

    return Obx(() => _stateCheckListSimpleRegister.arraySimpleRegister.length < 1 ? Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(HelpFunctions.formatDataWithYear(date: _stateSystem.selectedDate.value, lang: Get.locale!.languageCode), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
          Icon(
            Icons.article_outlined
          ),
          Text(message)
        ],
      ),
    ) : Column(
      children: [
        ResumeCheckExpense(),
        Flexible(
          child: Obx(() => ListView.builder(
              physics: ScrollPhysics(),
              itemBuilder: (_, index){

                SimpleRegister simpleRegister = _stateCheckListSimpleRegister.arraySimpleRegister[index];

                return Padding(
                  padding: const EdgeInsets.only(top: 2),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Obx(() => Checkbox(value: simpleRegister.getCheckByMonth(_stateSystem.getSelectedDateAsYMMM), onChanged: (val){
                            _stateCheckListSimpleRegister.checkRegister(
                                simpleRegister: simpleRegister,
                                value: val,
                            );
                          })),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(simpleRegister.name, textAlign: TextAlign.start, style: TextStyle(
                                    fontSize: 16,
                                  )),
                                ],
                              ),
                              Row(
                                children: [
                                  _stateSystem.showMoney.value ? Text('${simpleRegister.isIncome == Constants.INCOME ? '+ ': '- '} ${HelpFunctions.formatCurrency(value: simpleRegister.installment, name: 'currency'.tr)}',
                                    style: TextStyle(
                                        color: simpleRegister.isIncome == Constants.INCOME ? Constants.COLOR_INCOME : Constants.COLOR_EXPENSE
                                    ),
                                  ) : Text('${'currency'.tr} ---',
                                    style: TextStyle(
                                        color: simpleRegister.isIncome == Constants.INCOME ? Constants.COLOR_INCOME : Constants.COLOR_EXPENSE
                                    ),
                                  )
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
              },
              itemCount: _stateCheckListSimpleRegister.arraySimpleRegister.length,
            ),
          ),
        ),
      ],
    ));
  }
}
