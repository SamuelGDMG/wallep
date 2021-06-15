import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:finance/state/StateFormSalary.dart';
import 'package:finance/state/StateSystem.dart';
import 'package:finance/utils/HexColor.dart';
import 'package:finance/widgets/Button.dart';
import 'package:finance/widgets/InputTextFormField.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class DialogSalary extends StatelessWidget {

  final double padding = 16.0;
  final double avatarRadius = 66.0;
  final borderRadius = 100.0;

  final titleDialogSalary = 'titleDialogSalary'.tr;
  final labelDialogSalary = 'labelDialogSalary'.tr;
  final labelInputDialogSalary = 'labelInputDialogSalary'.tr;
  final buttonCancelDialogSalary = 'buttonCancelDialogSalary'.tr;
  final buttonConfirmDialogSalary = 'buttonConfirmDialogSalary'.tr;

  @override
  Widget build(BuildContext context) {

    StateFormSalary _stateFormSalary = Get.put(StateFormSalary());

    return AlertDialog(
      title: Text(titleDialogSalary),
      content: Container(
        child: Form(
          key: _stateFormSalary.formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Text(labelDialogSalary)
                ],
              ),
              Obx(() => InputTextFormField(
                  controller: _stateFormSalary.controllerSalary.value,
                  maxLength: 12,
                  labelText: "$labelInputDialogSalary",
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    CurrencyTextInputFormatter(
                      decimalDigits: 2,
                      symbol: 'R\$ ', // or to remove symbol set ''.
                    )
                  ]
              ))
            ],
          ),
        ),
      ),
      actions: [
        Row(
          children: [
            Button(onTap: (){
              Get.back();
            }, buttonTitle: buttonCancelDialogSalary, buttonColor: Colors.red,),
            SizedBox(
              width: 5,
            ),
            Button(onTap: (){
              _stateFormSalary.validate();
            }, buttonTitle: buttonConfirmDialogSalary, buttonColor: Get.theme.primaryColor,),
          ],
        )
      ],
    );
  }

}
