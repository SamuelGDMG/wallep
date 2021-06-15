import 'package:finance/model/SimpleRegister.dart';
import 'package:finance/screens/FormSimpleRegister/FormSimpleRegister.dart';
import 'package:finance/state/StateSystem.dart';
import 'package:finance/utils/Constants.dart';
import 'package:finance/utils/HelpFunctions.dart';
import 'package:finance/utils/HexColor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CardSimpleRegister extends StatelessWidget {

  final borderRadius = 16.0;

  final containerDimension = 120.0;

  final SimpleRegister register;

  final currency = 'currency'.tr;

  final cardSimpleRegisterExpense = 'cardSimpleRegisterExpense'.tr;
  final cardSimpleRegisterIncome = 'cardSimpleRegisterIncome'.tr;

  CardSimpleRegister({required this.register});

  @override
  Widget build(BuildContext context) {
    
    StateSystem _stateSystem = Get.find();

    return Padding(
      padding: const EdgeInsets.only(bottom: 14, top: 12, left: 6, right: 6),
      child: Material(
        shadowColor: register.isIncome == Constants.INCOME ? Constants.COLOR_INCOME : Constants.COLOR_EXPENSE,
        borderRadius: BorderRadius.circular(borderRadius),
        elevation: 6,
        child: InkWell(
          onTap: (){
            Get.to(() => FormSimpleRegister(simpleRegister: register,));
          },
          borderRadius: BorderRadius.circular(borderRadius),
          child: Container(
            height: containerDimension,
            width: containerDimension,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(6, 2, 6, 2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      child: Text("${register.isIncome == Constants.INCOME ? cardSimpleRegisterIncome : cardSimpleRegisterExpense}",
                        style: TextStyle(
                            color: register.isIncome == Constants.INCOME ? Constants.COLOR_INCOME : Constants.COLOR_EXPENSE,
                            fontSize: 15
                        ),
                        textAlign:
                        TextAlign.start,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      child: Text(register.name,
                          style: TextStyle(
                            fontSize: 15
                          ),
                          textAlign:
                          TextAlign.start,
                          maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Obx(() => Row(
                      textDirection: TextDirection.rtl,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        _stateSystem.showMoney.value ?
                        Text("${register.installments} x ${HelpFunctions.formatCurrency(value: register.installment, name: currency)}", textAlign: TextAlign.start,style: TextStyle(
                            fontSize: 12
                        ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,) : Text('---', textAlign: TextAlign.start,style: TextStyle(
                            fontSize: 12
                        ))
                      ],
                    )),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      child: Row(
                        textDirection: TextDirection.rtl,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Obx(() => Flexible(
                            child: Text("${register.isIncome == Constants.INCOME ? "" : "- "}$currency ${_stateSystem.showMoney.value ? register.price : '---'}", style: TextStyle(
                                color: register.isIncome == Constants.INCOME ? HexColor('3DDC97') : Colors.red,
                                fontSize: 15
                            ),
                              maxLines: 1,
                                overflow: TextOverflow.visible,
                                softWrap: false,),
                          )),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
